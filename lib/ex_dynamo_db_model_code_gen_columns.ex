defmodule ExDynamoDBModel.CodeGen.Columns do

  
  def generate(:column, name, opts) do
    quote do
      unquote(make_getter(name))
      unquote(make_setter(name))
    end
  end
  
  
  defp make_getter(name) do
    quote do
      def unquote(name)({__MODULE__, dict}) do
        HashDict.get(dict, unquote(name))
      end
    end
  end
  
  defp make_setter(name) do
    quote do
      def unquote(name)(value, {__MODULE__, dict}) do
        {__MODULE__, HashDict.put(dict, unquote(name), value)}
      end
    end
  end
  
end