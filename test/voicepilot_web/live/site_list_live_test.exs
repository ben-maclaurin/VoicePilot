defmodule VoicepilotWeb.SiteListLiveTest do
  use VoicepilotWeb.ConnCase

  import Phoenix.LiveViewTest
  import Voicepilot.BusinessFixtures

  @create_attrs %{title: "some title"}
  @update_attrs %{title: "some updated title"}
  @invalid_attrs %{title: nil}

  defp create_site_list(_) do
    site_list = site_list_fixture()
    %{site_list: site_list}
  end

  describe "Index" do
    setup [:create_site_list]

    test "lists all sitelists", %{conn: conn, site_list: site_list} do
      {:ok, _index_live, html} = live(conn, ~p"/sitelists")

      assert html =~ "Listing Sitelists"
      assert html =~ site_list.title
    end

    test "saves new site_list", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/sitelists")

      assert index_live |> element("a", "New Site list") |> render_click() =~
               "New Site list"

      assert_patch(index_live, ~p"/sitelists/new")

      assert index_live
             |> form("#site_list-form", site_list: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#site_list-form", site_list: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/sitelists")

      html = render(index_live)
      assert html =~ "Site list created successfully"
      assert html =~ "some title"
    end

    test "updates site_list in listing", %{conn: conn, site_list: site_list} do
      {:ok, index_live, _html} = live(conn, ~p"/sitelists")

      assert index_live |> element("#sitelists-#{site_list.id} a", "Edit") |> render_click() =~
               "Edit Site list"

      assert_patch(index_live, ~p"/sitelists/#{site_list}/edit")

      assert index_live
             |> form("#site_list-form", site_list: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#site_list-form", site_list: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/sitelists")

      html = render(index_live)
      assert html =~ "Site list updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes site_list in listing", %{conn: conn, site_list: site_list} do
      {:ok, index_live, _html} = live(conn, ~p"/sitelists")

      assert index_live |> element("#sitelists-#{site_list.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#sitelists-#{site_list.id}")
    end
  end

  describe "Show" do
    setup [:create_site_list]

    test "displays site_list", %{conn: conn, site_list: site_list} do
      {:ok, _show_live, html} = live(conn, ~p"/sitelists/#{site_list}")

      assert html =~ "Show Site list"
      assert html =~ site_list.title
    end

    test "updates site_list within modal", %{conn: conn, site_list: site_list} do
      {:ok, show_live, _html} = live(conn, ~p"/sitelists/#{site_list}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Site list"

      assert_patch(show_live, ~p"/sitelists/#{site_list}/show/edit")

      assert show_live
             |> form("#site_list-form", site_list: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#site_list-form", site_list: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/sitelists/#{site_list}")

      html = render(show_live)
      assert html =~ "Site list updated successfully"
      assert html =~ "some updated title"
    end
  end
end
