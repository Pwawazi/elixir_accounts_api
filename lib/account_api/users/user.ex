defmodule AccountApi.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :phone_number, :string
    field :gender, :string
    field :biography, :string

    belongs_to :account, AccountApi.Accounts.Account

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:account_id, :first_name, :last_name, :phone_number, :gender, :biography])
    |> validate_required([:account_id])
  end
end
