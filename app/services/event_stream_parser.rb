# frozen_string_literal: true
class EventStreamParser
  def initialize(event_name, &on_parsed_block)
    @event_name = event_name
    @buffer = ''
    @on_parsed_block = on_parsed_block
  end

  def feed(chunk)
    if chunk.blank?
      event = parse_event(@buffer)
      @on_parsed_block.call(event) if @on_parsed_block && event
      @buffer.clear
    else
      @buffer << chunk
    end
  end

  private

  def parse_event(buffer)
    match = event_format_regex.match(buffer)
    return nil unless match
    OpenStruct.new JSON.parse(match[1])
  end

  def event_format_regex
    /
        event:\s#{@event_name}\n
        data:\s(\{.*\})
    /x
  end
end
