defmodule VoicepilotWeb.SiteLive.FormComponent do
  use VoicepilotWeb, :live_component

  alias Voicepilot.Business

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage site records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="site-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:url]} type="text" label="Url" />
        <.input field={@form[:voice_id]} type="text" label="Voice" />
        <span class="hidden">
          <.input field={@form[:transcript]} type="text" label="Text" />
          <.input field={@form[:user_id]} type="text" value={@user.id} label="" />
        </span>
        <:actions>
          <.button phx-disable-with="Saving...">Save Site</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{site: site} = assigns, socket) do
    changeset = Business.change_site(site)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"site" => site_params}, socket) do
    changeset =
      socket.assigns.site
      |> Business.change_site(site_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"site" => site_params}, socket) do
    save_site(socket, socket.assigns.action, site_params)
  end

  defp save_site(socket, :edit, site_params) do
    case Business.update_site(socket.assigns.site, site_params) do
      {:ok, site} ->
        notify_parent({:saved, site})

        {:noreply,
         socket
         |> put_flash(:info, "Site updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_site(socket, :new, site_params) do
    case Business.create_site(site_params) do
      {:ok, site} ->
        notify_parent({:saved, site})

        {:noreply,
         socket
         |> put_flash(:info, "Site created successfully")
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
