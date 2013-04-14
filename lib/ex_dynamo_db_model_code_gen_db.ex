defmodule ExDynamoDBModel.CodeGen.DB do
  def generate(:model) do
    
    quote do
      
      def to_dynamo(record={__MODULE__,dict}) do
        res = Enum.map model_columns, fn({k,opts}) ->
          {atom_to_binary(k), to_dynamo(opts[:type], dict[k])}
        end
        Enum.filter res, fn ({k,v}) -> v != nil and v != "" end
      end
      
      def from_dynamo(dict) do
        res = Enum.map model_columns, fn({k,opts}) ->
          {binary_to_atom(k), from_dynamo(opts[:type], dict[k])}
        end
        new(res)
      end
      
      def to_dynamo(:atom, v),    do: atom_to_binary(v)
      def from_dynamo(:atom, v),  do: binary_to_atom(v)
      
      def to_dynamo(:json, nil),        do: "null"
      def from_dynamo(:json, "null"),   do: nil
      def to_dynamo(:json, v),          do: :jsx.encode(v)
      def from_dynamo(:json, v),        do: :jsx.decode(v)
      
      def to_dynamo(_,v),   do: v
      def from_dynamo(_,v), do: v
      
      # --------------------------------------------
      # Save/Delete Record
      # --------------------------------------------
    
      def before_put(record={__MODULE__,_dict}), do: record
      def after_put(record={__MODULE__,_dict}), do: record
    
      defoverridable [before_put: 1, after_put: 1]
    
      @doc "update record when it exists, otherwise insert"
      def put!(record={__MODULE__,_dict}) do
      
        record = before_put(before_save record)
      
        case validate(record) do
          :ok ->
            case :erlcloud_ddb.put_item(table_name, to_dynamo(record)) do
              {:ok, result}   -> {:ok, after_put(record)}
              error           -> error
            end
          error -> error
        end
      end
      
    end
  end
end