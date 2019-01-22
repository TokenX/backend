defmodule TokenxApiWeb.OrderControllerTest do
  use TokenxApiWeb.ConnCase

  alias TokenxApi.Exchange
  alias TokenxApi.Exchange.Order

  @create_attrs %{
    author: "some author",
    date_end: "some date_end",
    date_start: "some date_start",
    hash: "some hash",
    is_active: true,
    status: "some status",
    token_amount_buy: "some token_amount_buy",
    token_amount_sell: "some token_amount_sell",
    token_buy: "some token_buy",
    token_sell: "some token_sell",
    uuid: "some uuid"
  }
  @update_attrs %{
    author: "some updated author",
    date_end: "some updated date_end",
    date_start: "some updated date_start",
    hash: "some updated hash",
    is_active: false,
    status: "some updated status",
    token_amount_buy: "some updated token_amount_buy",
    token_amount_sell: "some updated token_amount_sell",
    token_buy: "some updated token_buy",
    token_sell: "some updated token_sell",
    uuid: "some updated uuid"
  }
  @invalid_attrs %{author: nil, date_end: nil, date_start: nil, hash: nil, is_active: nil, status: nil, token_amount_buy: nil, token_amount_sell: nil, token_buy: nil, token_sell: nil, uuid: nil}

  def fixture(:order) do
    {:ok, order} = Exchange.create_order(@create_attrs)
    order
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all orders", %{conn: conn} do
      conn = get(conn, Routes.order_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create order" do
    test "renders order when data is valid", %{conn: conn} do
      conn = post(conn, Routes.order_path(conn, :create), order: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.order_path(conn, :show, id))

      assert %{
               "id" => id,
               "author" => "some author",
               "date_end" => "some date_end",
               "date_start" => "some date_start",
               "hash" => "some hash",
               "is_active" => true,
               "status" => "some status",
               "token_amount_buy" => "some token_amount_buy",
               "token_amount_sell" => "some token_amount_sell",
               "token_buy" => "some token_buy",
               "token_sell" => "some token_sell",
               "uuid" => "some uuid"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.order_path(conn, :create), order: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update order" do
    setup [:create_order]

    test "renders order when data is valid", %{conn: conn, order: %Order{id: id} = order} do
      conn = put(conn, Routes.order_path(conn, :update, order), order: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.order_path(conn, :show, id))

      assert %{
               "id" => id,
               "author" => "some updated author",
               "date_end" => "some updated date_end",
               "date_start" => "some updated date_start",
               "hash" => "some updated hash",
               "is_active" => false,
               "status" => "some updated status",
               "token_amount_buy" => "some updated token_amount_buy",
               "token_amount_sell" => "some updated token_amount_sell",
               "token_buy" => "some updated token_buy",
               "token_sell" => "some updated token_sell",
               "uuid" => "some updated uuid"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, order: order} do
      conn = put(conn, Routes.order_path(conn, :update, order), order: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete order" do
    setup [:create_order]

    test "deletes chosen order", %{conn: conn, order: order} do
      conn = delete(conn, Routes.order_path(conn, :delete, order))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.order_path(conn, :show, order))
      end
    end
  end

  defp create_order(_) do
    order = fixture(:order)
    {:ok, order: order}
  end
end
