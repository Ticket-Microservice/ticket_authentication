defmodule Authentication.ErrorHandler do
  def changeset_error_handler(changeset_resp, nested_atom_arr) do
    errors = changeset_resp.errors

    err_nested =
      case length(nested_atom_arr) do
        0 ->
          []

        _ ->
          nested_atom_arr
          |> Enum.reduce([], fn x, acc ->
            a =
              changeset_resp.changes[x].errors
              |> Enum.map(fn y ->
                {key, {msg, _}} = y
                %{key: to_string(x) <> "." <> to_string(key), msg: msg}
              end)

            acc ++ a
          end)
      end

    err_upper =
      errors
      |> Enum.map(fn x ->
        {key, {msg, _}} = x
        %{key: to_string(key), msg: msg}
      end)

    err_upper ++ err_nested
  end

  def changeset_error_handler_msg(changeset_resp, nested_atom_arr) do
    errors = changeset_resp.errors

    err_nested =
      case length(nested_atom_arr) do
        0 ->
          []

        _ ->
          nested_atom_arr
          |> Enum.reduce([], fn x, acc ->
            a =
              changeset_resp.changes[x].errors
              |> Enum.map(fn y ->
                {key, {msg, _}} = y
                Atom.to_string(key) <> ":" <> msg
              end)

            acc ++ a
          end)
      end

    err_upper =
      errors
      |> Enum.map(fn x ->
        {key, {msg, _}} = x
        Atom.to_string(key) <> ":" <> msg
      end)

    err_upper ++ err_nested
    Enum.join(err_upper, ", ")
  end
end
