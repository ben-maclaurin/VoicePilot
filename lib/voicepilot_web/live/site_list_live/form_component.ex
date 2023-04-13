defmodule VoicepilotWeb.SiteListLive.FormComponent do
  use VoicepilotWeb, :live_component

  alias Voicepilot.Business

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage site_list records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="site_list-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Site list</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{site_list: site_list} = assigns, socket) do
    changeset = Business.change_site_list(site_list)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"site_list" => site_list_params}, socket) do
    changeset =
      socket.assigns.site_list
      |> Business.change_site_list(site_list_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"site_list" => site_list_params}, socket) do
    save_site_list(socket, socket.assigns.action, site_list_params)
  end

  defp save_site_list(socket, :edit, site_list_params) do
    case Business.update_site_list(socket.assigns.site_list, site_list_params) do
      {:ok, site_list} ->
        notify_parent({:saved, site_list})

        {:noreply,
         socket
         |> put_flash(:info, "Site list updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_site_list(socket, :new, site_list_params) do
    case Business.create_site_list(site_list_params) do
      {:ok, site_list} ->
        notify_parent({:saved, site_list})

        {:noreply,
         socket
         |> put_flash(:info, "Site list created successfully")
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
