defmodule ExDynamoDBModel do
  
  defmacro __using__(opts) do
    setup(opts)
  end
  
  defp setup(opts) do
    quote do
      Module.register_attribute __MODULE__, :model_column, accumulate: true, persist: true
      unquote(ExDynamoDBModel.CodeGen.generate(:model, opts))
      import ExDynamoDBModel
    end
  end
  
  @doc "define a column"
  defmacro defcolumn(name, opts // []), do: ExDynamoDBModel.CodeGen.Columns.generate(:column, name, opts)
  
end
