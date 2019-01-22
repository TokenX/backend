defmodule TokenxApi.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :uuid, :string, null: false
      add :token_sell, :string
      add :token_buy, :string
      add :token_amount_sell, :string
      add :token_amount_buy, :string
      add :date_start, :string
      add :date_end, :string
      add :status, :string
      add :hash, :string
      add :is_active, :boolean, default: false, null: false
      add :author, :string

      timestamps()
    end

    create unique_index(:orders, [:uuid])
  end
end
