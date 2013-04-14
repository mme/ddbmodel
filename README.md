ExDynamoDBModel
================================

*ActiveRecord-like Model for DynamoDB*

Environment Variables
- __DYNAMO_DB_PREFIX__ - All DynamoDB tablenames will be prefixed with the value of this variable (optional)
- __AWS_ACCESS_KEY_ID__ - AWS access key
- __AWS_SECRET_ACCESS_KEY__ - AWS secret key

Usage
-------------------------

```elixir
defmodule YourModel do
  
  # specify the DynamoDB key column (default is :hash). 
  use ExDynamoDBModel, key: :id
  
  # if you have a table with hash key and range, pass a tuple
  use ExDynamoDBModel, key: {:id, :timestamp}
  
  # optionally set a custom table name. default is the model name
  use ExDynamoDBModel, table_name: "your_dynamo_table"
  
end
```

Defining Models
-------------------------

```elixir
defmodule Account do
  
  use ExDynamoDBModel
  
  # uuid type automatically creates a uuid before saving if needed
  defcolumn :uuid, type: :uuid
  
  # set default value
  defcolumn :status, default: :A
  
  # validate in_list
  defcolumn :membership, default: :free, in_list: [:free, :paid]
  
  # validate not null
  defcolumn :first_name, null: false
  
  # validate by function
  defcolumn :last_name, validate: &1 != "Doe"
  # or defcolumn :last_name, validate: fn(v) v != "Doe" end
  
end
```

Using Models
-------------------------

Create a new instance with the new function
```elixir
  account = Account.new
```

Pass in parameters by keyword
```elixir
  account = Account.new first_name: "Dale", last_name: "Cooper"
```

Update a single parameter (don't forget to assign to a variable, the update does not happen in place..)
```elixir
  account = account.membership(:paid)
```

Mass Assignment
```elixir
  account = account.set membership: :paid, status: :A
```

Whitelisted mass assignment
```elixir
  # change only membership and status
  account = account.set [membership: :paid, status: :A, first_name: "John"], [:membership, :status]
```

License
-------------------------
__BSD__
http://opensource.org/licenses/BSD-2-Clause



