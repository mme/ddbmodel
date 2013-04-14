defmodule ExDynamoDBModel.CodeGen do
  
  def generate_functions(opts) do
    quote do
      unquote(generate_table_name(opts[:table_name]))
    end
  end
  
  def generate_table_name(nil) do
    quote do
      def table_name do
        case :os.getenv('DYNAMO_DB_PREFIX') do
          false  -> inspect(__MODULE__)
          prefix -> list_to_binary(prefix) <> "." <> inspect(__MODULE__)
        end
      end
    end
  end
  
  def generate_table_name(table_name) do
    quote do
      def table_name, do: unquote(table_name)
    end
  end 
  
end