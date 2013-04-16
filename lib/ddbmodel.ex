defmodule ExDynamoDBModel do
  
  defmacro __using__(opts) do
    setup(opts)
  end
  
  defp setup(opts) do
    quote do
      Module.register_attribute __MODULE__, :model_column, accumulate: true, persist: true
      unquote(ExDynamoDBModel.CodeGen.generate(:model, opts))
      unquote(ExDynamoDBModel.CodeGen.Validation.generate(:model))
      unquote(ExDynamoDBModel.CodeGen.DB.generate(:model))

      
      import ExDynamoDBModel
    end
  end
  
  @doc "define a column"
  defmacro defcolumn(name, opts // []), do: ExDynamoDBModel.CodeGen.Columns.generate(:column, name, opts)
  
  defmacro with_timestamps do
    quote do
      defcolumn :created_at, type: :created_timestamp
      defcolumn :updated_at, type: :updated_timestamp
      
    end
  end
  
end
