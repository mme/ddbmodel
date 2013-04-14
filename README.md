ExDynamoDBModel
================================

*ActiveRecord-like Model for DynamoDB*

Environment Variables
- _DYNAMO_DB_PREFIX_ - All DynamoDB tablenames will be prefixed with the value of this variable
- _AWS_ACCESS_KEY_ID_ - AWS access key
- _AWS_SECRET_ACCESS_KEY_ - AWS secret key

Usage
-------------------------

```elixir
defmodule YourModel do
  
  # specify the DynamoDB key column (default is uuid). 
  use ExDynamoDBModel, key: :id
  
  # if you have a table with hash key and range, pass a tuple
  use ExDynamoDBModel, key: {:id, :timestamp}
  
  # optionally set a custom table name. default is the model name
  use ExDynamoDBModel, table_name: "your_dynamo_table"
  
end
```

Defining columns
-------------------------

```elixir
defmodule Account do
  
  use ExDynamoDBModel
  
  # set default value
  defcolumn :status, default: :A
  
  # validate not null
  defcolumn :first_name, null: false
  
end
```



