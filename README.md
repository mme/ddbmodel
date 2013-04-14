ExDynamoDBModel
================================

*ActiveRecord-like Model for DynamoDB*


To make a DynamoDB model, do this:
```elixir
defmodule YourModel do
  use ExDynamoDBModel
end
```

The default DynamoDB table name is the name ot the model. If you have the environment variable DYNAMO_DB_PREFIX set, all your tablenames will be prefixed.

Set a custom table name like this:
```elixir
defmodule YourModel do
  use ExDynamoDBModel, table_name: "your_dynamo_table"
end
```

