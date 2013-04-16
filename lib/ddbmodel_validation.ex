defmodule DDBModel.Validation do
  
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
      
      
      def before_save(record={__MODULE__, dict}) do
        res = Enum.map model_columns, fn({k,opts}) ->
          {k, before_save(opts[:type], dict[k])}
        end
        new(res)
      end
      
      defoverridable [before_save: 1]
      
      def unix_timestamp do
        utc = :calendar.now_to_universal_time(:erlang.now())
        greg = :calendar.datetime_to_gregorian_seconds(utc) 
        greg_1970 = :calendar.datetime_to_gregorian_seconds( {{1970,1,1},{0,0,0}} )
    
        greg - greg_1970
      end
      
      
      def before_save(:uuid, v) do
        if v == nil do
          list_to_binary(:uuid.to_string :uuid.uuid4())
        else
          v
        end
      end
      
      def before_save(:created_timestamp, v) do
        if v == nil do
          unix_timestamp
        else
          v
        end
      end
      
      def before_save(:updated_timestamp, v), do: unix_timestamp
      
      def before_save(_,v), do: v
      
    end
  end
  
  
end