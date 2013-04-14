ExUnit.start

defmodule TestDefaultTableName do
  use ExDynamoDBModel
end

defmodule TestCustomTableName do
  use ExDynamoDBModel, table_name: "Custom"
end

defmodule TestDefaultKey do
  use ExDynamoDBModel
end

defmodule TestCustomKey do
  use ExDynamoDBModel, key: :a_key
end

defmodule TestRecordID do
  use ExDynamoDBModel, key: {:hash, :range}
  
  defcolumn :hash
  defcolumn :range
end

defmodule TestRangeKey do
  use ExDynamoDBModel, key: {:a_hash_key, :a_range_key}
end

defmodule TestDefColumn do
  use ExDynamoDBModel
  
  defcolumn :uuid
end

defmodule TestDefColumnDefault do
  use ExDynamoDBModel
  
  defcolumn :first_name, default: "Markus"
end

defmodule TestMassAssignment do
  use ExDynamoDBModel
  
  defcolumn :first_name
  defcolumn :last_name
  defcolumn :password
end

defmodule TestValidate do
  use ExDynamoDBModel
  
  defcolumn :first_name, default: "John", validate: fn(first_name) -> first_name == "John" end
  defcolumn :last_name, default: "Doe", validate: &1 == "Doe"
  defcolumn :status, default: :A, null: :false
  defcolumn :membership, default: :free, in_list: [:free, :paid]
  
end