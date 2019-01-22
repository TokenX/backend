defmodule TokenxApi.ExchangeTest do
  use TokenxApi.DataCase

  alias TokenxApi.Exchange

  describe "orders" do
    alias TokenxApi.Exchange.Order

    @valid_attrs %{author: "some author", date_end: "some date_end", date_start: "some date_start", hash: "some hash", is_active: true, status: "some status", token_amount_buy: "some token_amount_buy", token_amount_sell: "some token_amount_sell", token_buy: "some token_buy", token_sell: "some token_sell", uuid: "some uuid"}
    @update_attrs %{author: "some updated author", date_end: "some updated date_end", date_start: "some updated date_start", hash: "some updated hash", is_active: false, status: "some updated status", token_amount_buy: "some updated token_amount_buy", token_amount_sell: "some updated token_amount_sell", token_buy: "some updated token_buy", token_sell: "some updated token_sell", uuid: "some updated uuid"}
    @invalid_attrs %{author: nil, date_end: nil, date_start: nil, hash: nil, is_active: nil, status: nil, token_amount_buy: nil, token_amount_sell: nil, token_buy: nil, token_sell: nil, uuid: nil}

    def order_fixture(attrs \\ %{}) do
      {:ok, order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Exchange.create_order()

      order
    end

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Exchange.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Exchange.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      assert {:ok, %Order{} = order} = Exchange.create_order(@valid_attrs)
      assert order.author == "some author"
      assert order.date_end == "some date_end"
      assert order.date_start == "some date_start"
      assert order.hash == "some hash"
      assert order.is_active == true
      assert order.status == "some status"
      assert order.token_amount_buy == "some token_amount_buy"
      assert order.token_amount_sell == "some token_amount_sell"
      assert order.token_buy == "some token_buy"
      assert order.token_sell == "some token_sell"
      assert order.uuid == "some uuid"
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Exchange.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      assert {:ok, %Order{} = order} = Exchange.update_order(order, @update_attrs)
      assert order.author == "some updated author"
      assert order.date_end == "some updated date_end"
      assert order.date_start == "some updated date_start"
      assert order.hash == "some updated hash"
      assert order.is_active == false
      assert order.status == "some updated status"
      assert order.token_amount_buy == "some updated token_amount_buy"
      assert order.token_amount_sell == "some updated token_amount_sell"
      assert order.token_buy == "some updated token_buy"
      assert order.token_sell == "some updated token_sell"
      assert order.uuid == "some updated uuid"
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Exchange.update_order(order, @invalid_attrs)
      assert order == Exchange.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Exchange.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Exchange.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Exchange.change_order(order)
    end
  end
end
