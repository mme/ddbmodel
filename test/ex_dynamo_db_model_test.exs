Code.require_file "../test_helper.exs", __FILE__

defmodule ExDynamoDBModelTest do
  use ExUnit.Case
  
  setup do
    :os.putenv("DYNAMO_DB_PREFIX","test.ex_model_dynamo_db.")
    :erlcloud.start()
    :ok
  end

  test "default table name" do
    assert TestDefaultTableName.table_name == "test.ex_model_dynamo_db.TestDefaultTableName"
  end
  
  test "custom table name" do
    assert TestCustomTableName.table_name == "Custom"
  end
  
  test "default key" do
    assert TestCustomKey.key == :a_key
  end
  
  test "custom key" do
    assert TestRangeKey.key == {:a_hash_key, :a_range_key}
  end
  
  
end
