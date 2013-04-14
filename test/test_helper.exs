ExUnit.start

defmodule TestDefaultTableName do
  use ExDynamoDBModel
end

defmodule TestCustomTableName do
  use ExDynamoDBModel, table_name: "Custom"
end