defmodule Weather.XmlParser do
  require Record
  Record.defrecord :xmlElement, Record.extract(:xmlElement, from_lib: "xmerl/include/xmerl.hrl")
  Record.defrecord :xmlText, Record.extract(:xmlText, from_lib: "xmerl/include/xmerl.hrl")

  def parse_xml({xml, _}) do
    with location = element_value_for('/current_observation/location', xml),
      weather = element_value_for('/current_observation/weather', xml),
      temperature = element_value_for('/current_observation/temperature_string', xml)
    do
      [location, weather, temperature]
    end
  end

  def element_value_for(path, xml) do
    [element] = :xmerl_xpath.string(path, xml)
    [text] = xmlElement(element, :content)
    xmlText(text, :value)
  end
end
