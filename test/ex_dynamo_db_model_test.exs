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
  
  test "def column" do
    x = TestDefColumn.new uuid: "7342C9D3-ED28-4E60-A9BD-CDE60EB69BEC"
    assert x.uuid == "7342C9D3-ED28-4E60-A9BD-CDE60EB69BEC"
    x = x.uuid("D0F126F4-90C1-4855-B73F-99E8E9A8D151")
    assert x.uuid == "D0F126F4-90C1-4855-B73F-99E8E9A8D151"
  end
  
  test "column default" do
    x = TestDefColumnDefault.new
    assert x.first_name == "Markus"
    x = x.first_name "Niko"
    assert x.first_name == "Niko"
  end
  
end
