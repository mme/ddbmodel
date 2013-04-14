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

defmodule TestRangeKey do
  use ExDynamoDBModel, key: {:a_hash_key, :a_range_key}
end

defmodule TestDefColumn do
  use ExDynamoDBModel
  
  defcolumn :uuid
end