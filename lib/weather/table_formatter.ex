defmodule Weather.TableFormatter do
  import Enum, only: [map_join: 3]

  def print_table_for_columns(columns, headers) do
    with column_widths = [24, 24, 25],
      format = format_for(column_widths)
    do
      puts_one_line_in_columns(headers, format)
      IO.puts(separator(column_widths))
      puts_one_line_in_columns(columns, format)
    end
  end

  def format_for(column_widths) do
    map_join(column_widths, "|", fn width -> "~-#{width}s" end) <> "~n"
  end

  def separator(column_widths) do
    map_join(column_widths, "-+-", fn width -> List.duplicate("-", width) end)
  end

  def puts_one_line_in_columns(fields, format) do
    :io.format(format, fields)
  end
end
