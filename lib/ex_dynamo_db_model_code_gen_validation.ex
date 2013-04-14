defmodule ExDynamoDBModel.CodeGen.Validation do
  
  def generate(:model) do
    quote do
      
      def validate(record={__MODULE__, dict}) do
        res = Enum.map model_columns, fn({k,opts}) ->
          Enum.map [:null, :validate, :in_list], fn(opt) ->
            validate(opt, opts[opt], k, dict[k])
          end
        end
        
        case Enum.filter (List.flatten res), &1 != :ok do
          []    -> :ok
          error -> error
        end
      end
      
      defoverridable [validate: 1]
      
      def validate(:null, false, k, nil), do: {:error, {k, atom_to_binary(k) <> " must not be null"}}
      def validate(:null, _, _, _), do: :ok
      
      def validate(:in_list, l, k, v) when is_list(l) do
        if Enum.any? l, &1 == v do
          :ok
        else
          {:error, {k, atom_to_binary(k) <> " must be in list " <> (inspect l)}}
        end
      end
      def validate(:in_list, _, _, _), do: :ok
      
      def validate(:validate, f, k, v) when is_function(f) do
        case f.(v) do
          true  -> :ok
          false -> {:error, {k, atom_to_binary(k) <> " failed validation"}}
          res   -> res
        end
      end
      
      def validate(:validate, _, _, _), do: :ok
      
      def validates?(record={__MODULE__, dict}), do: validate(record) == :ok
    end
  end
  
  
end