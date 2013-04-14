ExDynamoDBModel
================================

*ActiveRecord-like Model for DynamoDB*

Usage
-------------------------
Environment Variables
- *DYNAMO_DB_PREFIX* All DynamoDB tablenames will be prefixed with the value of this variable
- *AWS_ACCESS_KEY_ID* AWS access key
- *AWS_SECRET_ACCESS_KEY* AWS secret key

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



