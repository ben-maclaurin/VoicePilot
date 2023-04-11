defmodule VoicepilotWeb.VoiceLiveTest do
  use VoicepilotWeb.ConnCase

  import Phoenix.LiveViewTest
  import Voicepilot.BusinessFixtures

  @create_attrs %{voice_id: "some voice_id"}
  @update_attrs %{voice_id: "some updated voice_id"}
  @invalid_attrs %{voice_id: nil}

  defp create_voice(_) do
    voice = voice_fixture()
    %{voice: voice}
  end

  describe "Index" do
    setup [:create_voice]

    test "lists all voices", %{conn: conn, voice: voice} do
      {:ok, _index_live, html} = live(conn, ~p"/voices")

      assert html =~ "Listing Voices"
      assert html =~ voice.voice_id
    end

    test "saves new voice", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/voices")

      assert index_live |> element("a", "New Voice") |> render_click() =~
               "New Voice"

      assert_patch(index_live, ~p"/voices/new")

      assert index_live
             |> form("#voice-form", voice: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#voice-form", voice: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/voices")

      html = render(index_live)
      assert html =~ "Voice created successfully"
      assert html =~ "some voice_id"
    end

    test "updates voice in listing", %{conn: conn, voice: voice} do
      {:ok, index_live, _html} = live(conn, ~p"/voices")

      assert index_live |> element("#voices-#{voice.id} a", "Edit") |> render_click() =~
               "Edit Voice"

      assert_patch(index_live, ~p"/voices/#{voice}/edit")

      assert index_live
             |> form("#voice-form", voice: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#voice-form", voice: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/voices")

      html = render(index_live)
      assert html =~ "Voice updated successfully"
      assert html =~ "some updated voice_id"
    end

    test "deletes voice in listing", %{conn: conn, voice: voice} do
      {:ok, index_live, _html} = live(conn, ~p"/voices")

      assert index_live |> element("#voices-#{voice.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#voices-#{voice.id}")
    end
  end

  describe "Show" do
    setup [:create_voice]

    test "displays voice", %{conn: conn, voice: voice} do
      {:ok, _show_live, html} = live(conn, ~p"/voices/#{voice}")

      assert html =~ "Show Voice"
      assert html =~ voice.voice_id
    end

    test "updates voice within modal", %{conn: conn, voice: voice} do
      {:ok, show_live, _html} = live(conn, ~p"/voices/#{voice}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Voice"

      assert_patch(show_live, ~p"/voices/#{voice}/show/edit")

      assert show_live
             |> form("#voice-form", voice: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#voice-form", voice: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/voices/#{voice}")

      html = render(show_live)
      assert html =~ "Voice updated successfully"
      assert html =~ "some updated voice_id"
    end
  end
end
