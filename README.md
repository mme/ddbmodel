ExDynamoDBModel
================================

*ActiveRecord-like Model for DynamoDB*

Environment Variables
- __AWS_DYNAMO_DB_PREFIX__ - All DynamoDB tablenames will be prefixed with the value of this variable (optional)
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

Updating DynamoDB
-------------------------

Use put to create a new or update an existing record
```elixir
  {:ok, account} = account.put!
```

License
-------------------------
Copyright (c) 2013, Markus Ecker

All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

- Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
- Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.



