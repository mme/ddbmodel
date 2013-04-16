defmodule DDBModel.Model do
  
  def generate(:model, opts) do
    quote do
      
      unquote(generate_table_name(opts[:table_name]))
      unquote(generate_key(opts[:key]))
      
      # get the model columns from module attributes
      defp model_columns do
        attributes = Enum.filter module_info()[:attributes], fn({k,v}) -> k == :model_column end
        Enum.map attributes, fn ({:model_column, [{name, attr}]}) -> {name, attr} end
      end
      
      # get default values for the model columns
      defp model_column_defaults do
        Enum.map model_columns, fn ({key, attr}) -> {key, attr[:default]} end
      end
      
      @doc "make record and init with default values"
      def new (attributes // []) do
        {__MODULE__, HashDict.merge (HashDict.new model_column_defaults), (HashDict.new attributes)}
      end
     
      @doc "update module from dict"
      def set(attributes,record = {__MODULE__, _dict}), do: set(attributes, nil, record)
      
      def set(attributes, allowed_keys, {__MODULE__, dict}) do
        attributes = case allowed_keys do
          nil -> attributes
          _   -> Enum.filter attributes, fn({k,_v}) -> Enum.any? allowed_keys, &1 == k end
        end
        {__MODULE__, HashDict.merge dict, (HashDict.new attributes)}
      end
      
      @doc "get the record id"
      def id(record = {__MODULE__, dict}) do
        case key do
          {hash, range} -> {dict[hash], dict[range]}
          k             -> dict[k]
        end
      end
      
    end
  end
  
  def generate_table_name(nil) do
    quote do
      def table_name do
        case :os.getenv('AWS_DYNAMO_DB_PREFIX') do
          false  -> inspect(__MODULE__)
          prefix -> list_to_binary(prefix)  <> inspect(__MODULE__)
        end
      end
    end
  end
  
  def generate_table_name(table_name) do
    quote do
      def table_name, do: unquote(table_name)
    end
  end 
  
  def generate_key(nil) do
    quote do
      def key, do: :hash
    end
  end
  
  def generate_key(key) do
    quote do
      def key, do: unquote(key)
    end
  end
  
end