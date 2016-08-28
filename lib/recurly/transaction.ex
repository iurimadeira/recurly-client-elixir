defmodule Recurly.Transaction do
  @moduledoc """
  Module for handling transactions in Recurly.
  See the [developer docs on transactions](https://dev.recurly.com/docs/list-transactions)
  for more details
  """
  use Recurly.Resource
  alias Recurly.{Resource,Transaction,TransactionDetails}

  @endpoint "/transactions"

  @type t :: %__MODULE__{
    amount_in_cents:  integer,
    currency:         String.t,
    details:          TransactionDetails.t,
    ip_address:       String.t,
    payment_method:   String.t,
    recurring_type:   boolean,
    reference:        String.t,
    refundable_type:  boolean,
    source:           String.t,
    tax_in_cents:     integer,
    test_type:        boolean,
    transaction_code: String.t,
    uuid:             String.t,
    voidable_type:    boolean,
  }

  schema :transaction do
    field :amount_in_cents,  :integer
    field :currency,         :string
    field :details,          Recurly.TransactionDetails, read_only: true
    field :ip_address,       :string
    field :payment_method,   :string
    field :recurring_type,   :boolean
    field :reference,        :string
    field :refundable_type,  :boolean
    field :source,           :string
    field :tax_in_cents,     :integer
    field :test_type,        :boolean
    field :transaction_code, :string
    field :uuid,             :string
    field :voidable_type,    :boolean
  end

  @doc """
  Finds an transaction given a transaction uuid. Returns the transaction or an error.

  ## Parameters

  - `uuid` String transaction uuid

  ## Examples

  ```
  alias Recurly.NotFoundError

  case Recurly.Transaction.find("ialskdjaldkjsaldkjas") do
    {:ok, transaction} ->
      # Found the transaction
    {:error, %NotFoundError{}} ->
      # 404 transaction was not found
  end
  ```
  """
  @spec find(String.t) :: {:ok, Transaction.t} | {:error, any}
  def find(uuid) do
    Resource.find(%Transaction{}, path(uuid))
  end

  @doc """
  Creates an transaction from a changeset. Supports nesting the `billing_info`

  ## Parameters

  - `changeset` Keyword list changeset

  ## Examples

  ```
  alias Recurly.ValidationError

  case Recurly.Transaction.create(transaction_code: "mytransactioncode") do
    {:ok, transaction} ->
      # created the transaction
    {:error, %ValidationError{errors: errors}} ->
      # will give you a list of validation errors
  end
  ```
  """
  @spec create(keyword) :: {:ok, Transaction.t} | {:error, any}
  def create(changeset) do
    Resource.create(%Transaction{}, changeset, @endpoint)
  end

  @doc """
  Updates an transaction from a changeset

  ## Parameters

  - `transaction` transaction resource struct
  - `changeset` Keyword list changeset representing the updates

  ## Examples

  ```
  alias Recurly.ValidationError

  changes = [
    first_name: "Benjamin",
    last_name: nil
  ]

  case Recurly.transaction.update(transaction, changes) do
    {:ok, transaction} ->
      # the updated transaction
    {:error, %ValidationError{errors: errors}} ->
      # will give you a list of validation errors
  end
  ```
  """
  @spec update(Transaction.t, keyword) :: {:ok, Transaction.t} | {:error, any}
  def update(transaction = %Transaction{}, changeset) do
    Resource.update(transaction, changeset)
  end

  @doc """
  Generates the path to an transaction given the transaction code

  ## Parameters

    - `transaction_code` String transaction code

  """
  @spec path(String.t) :: String.t
  def path(transaction_code) do
    Path.join(@endpoint, transaction_code)
  end
end
