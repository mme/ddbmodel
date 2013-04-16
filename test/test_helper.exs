ExUnit.start

defmodule TestDefaultTableName do
  use DDBModel
end

defmodule TestCustomTableName do
  use DDBModel, table_name: "Custom"
end

defmodule TestDefaultKey do
  use DDBModel
end

defmodule TestCustomKey do
  use DDBModel, key: :a_key
end

defmodule TestRecordID do
  use DDBModel, key: {:hash, :range}
  
  defcolumn :hash
  defcolumn :range
end

defmodule TestRangeKey do
  use DDBModel, key: {:a_hash_key, :a_range_key}
end

defmodule TestDefColumn do
  use DDBModel
  
  defcolumn :uuid
end

defmodule TestDefColumnDefault do
  use DDBModel
  
  defcolumn :first_name, default: "Markus"
end

defmodule TestMassAssignment do
  use DDBModel
  
  defcolumn :first_name
  defcolumn :last_name
  defcolumn :password
end

defmodule TestValidate do
  use DDBModel
  
  defcolumn :first_name, default: "John", validate: fn(first_name) -> first_name == "John" end
  defcolumn :last_name, default: "Doe", validate: &1 == "Doe"
  defcolumn :status, default: :A, null: :false
  defcolumn :membership, default: :free, in_list: [:free, :paid]
  
end

defmodule TestCustomValidate do
  use DDBModel
  
  def validate(record) do
    _ = super(record)
    {:error, [{:error, {:something, "Something's not right" }}]}
  end
end


defmodule TestModelHashKey do
  use DDBModel, key: :uuid
  with_timestamps
  
  defcolumn :uuid, type: :uuid
    
end