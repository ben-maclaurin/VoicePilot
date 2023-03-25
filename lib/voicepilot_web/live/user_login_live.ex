defmodule VoicepilotWeb.UserLoginLive do
  use VoicepilotWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="mt-24 w-64 m-auto space-y-8 flex flex-col items-center">
      <.header class="">
        Sign in to account
        <:subtitle>
          Don't have an account?
          <.link navigate={~p"/users/register"} class="">
            Sign up
          </.link>
          for an account now.
        </:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="login_form"
        action={~p"/users/log_in"}
        phx-update="ignore"
        class=""
      >
        <div class="mb-8 flex flex-col space-y-4">
          <.input field={@form[:email]} type="email" label="Email" required />
          <.input field={@form[:password]} type="password" label="Password" required />
        </div>

        <:actions>
          <.button phx-disable-with="Signing in..." class="">
            Sign in
          </.button>
        </:actions>
        <:actions>
          <div class="flex flex-col items-center mt-3">
            <.link
              href={~p"/users/reset_password"}
              class="text-gray-400 font-medium tracking-tight text-sm"
            >
              Forgot your password?
            </.link>
          </div>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    email = live_flash(socket.assigns.flash, :email)
    form = to_form(%{"email" => email}, as: "user")
    {:ok, assign(socket, form: form), temporary_assigns: [form: form]}
  end
end
