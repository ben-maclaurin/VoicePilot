defmodule VoicepilotWeb.VoiceLive.FormComponent do
  use VoicepilotWeb, :live_component

  alias Voicepilot.Business

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage voice records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="voice-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:voice_id]} type="text" label="Voice" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Voice</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{voice: voice} = assigns, socket) do
    changeset = Business.change_voice(voice)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"voice" => voice_params}, socket) do
    changeset =
      socket.assigns.voice
      |> Business.change_voice(voice_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"voice" => voice_params}, socket) do
    save_voice(socket, socket.assigns.action, voice_params)
  end

  defp save_voice(socket, :edit, voice_params) do
    case Business.update_voice(socket.assigns.voice, voice_params) do
      {:ok, voice} ->
        notify_parent({:saved, voice})

        {:noreply,
         socket
         |> put_flash(:info, "Voice updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_voice(socket, :new, voice_params) do
    case Business.create_voice(voice_params) do
      {:ok, voice} ->
        notify_parent({:saved, voice})

        {:noreply,
         socket
         |> put_flash(:info, "Voice created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
