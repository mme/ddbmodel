ExDynamoDBModel
================================

*ActiveRecord-like Model for DynamoDB*

Usage
-------------------------

```elixir
defmodule YourModel do
  
  # specify the DynamoDB key column (default is uuid). 
  use ExDynamoDBModel, key: :id
  
  # if you have a table with hash key and range, pass a tuple
  use ExDynamoDBModel, key: {:id, :timestamp}
  
  # optionally set a custom table name, e.g.
  use ExDynamoDBModel, table_name: "your_dynamo_table"
  
end
```

The default DynamoDB table name is the name ot the model. If you have the environment variable DYNAMO_DB_PREFIX set, all your tablenames will be prefixed.

Defining columns
-------------------------

```elixir
defmodule Account do
  
  use ExDynamoDBModel
  
  # define some columns
  defcolumn :first_name
  
end
```



