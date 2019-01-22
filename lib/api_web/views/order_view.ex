defmodule TokenxApiWeb.OrderView do
  use TokenxApiWeb, :view
  alias TokenxApiWeb.OrderView

  def render("index.json", %{orders: orders}) do
    %{data: render_many(orders, OrderView, "order.json")}
  end

  def render("show.json", %{order: order}) do
    %{data: render_one(order, OrderView, "order.json")}
  end

  def render("order.json", %{order: order}) do
    %{id: order.id,
      uuid: order.uuid,
      token_sell: order.token_sell,
      token_buy: order.token_buy,
      token_amount_sell: order.token_amount_sell,
      token_amount_buy: order.token_amount_buy,
      date_start: order.date_start,
      date_end: order.date_end,
      status: order.status,
      hash: order.hash,
      is_active: order.is_active,
      author: order.author}
  end
end
