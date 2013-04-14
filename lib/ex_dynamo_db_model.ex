defmodule ExDynamoDBModel do
  
  defmacro __using__(opts) do
    setup(opts)
  end
  
  defp setup(opts) do
    quote do
      unquote(ExDynamoDBModel.CodeGen.generate_functions(opts))
    end
  end
  
end
