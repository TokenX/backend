defmodule TokenxApi.Exchange.Order do
  use Ecto.Schema
  import Ecto.Changeset


  schema "orders" do
    field :author, :string
    field :date_end, :string
    field :date_start, :string
    field :hash, :string
    field :is_active, :boolean, default: false
    field :status, :string
    field :token_amount_buy, :string
    field :token_amount_sell, :string
    field :token_buy, :string
    field :token_sell, :string
    field :uuid, :string

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:uuid, :token_sell, :token_buy, :token_amount_sell, :token_amount_buy, :date_start, :date_end, :status, :hash, :is_active, :author])
    |> validate_required([:uuid, :token_sell, :token_buy, :token_amount_sell, :token_amount_buy, :date_start, :date_end, :status, :hash, :is_active, :author])
    |> unique_constraint(:uuid)
  end

  # TODO 1 добавить логику включения всего тела ордера для формирования хэша
  # TODO 2 стоит ли использовать Bcrypt для создания хэша, есть ли другие способы?
  defp put_order_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, password_hash: Bcrypt.hash_pwd_salt(password))
  end

  defp put_order_hash(changeset) do
    changeset
  end

end
