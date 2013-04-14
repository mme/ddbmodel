ExDynamoDBModel
================================

*ActiveRecord-like Model for DynamoDB*


To make a dynamodb model, do this:
```
defmodule YourModel do
  use ExDynamoDBModel
end
```

The default dynamodb table name is the name ot the model. If you have the environment variable DYNAMO_DB_PREFIX set, all your tablenames will be prefixed.

You can set a custom table name like this:
```
defmodule YourModel do
  use ExDynamoDBModel, table_name: "your_dynamo_table"
end
```

