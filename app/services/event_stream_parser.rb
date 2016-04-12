class EventStreamParser
  def initialize(event_name, &on_parsed_block)
    @event_name = event_name
    @buffer = ''
    @on_parsed_block = on_parsed_block
  end

  def add(chunk)
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
    regexp = %r{
        event:\s.#{@event_name}
        \s
        data:\s(\{.*\})
      }x

    match = regexp.match(buffer)
    return nil unless match
    OpenStruct.new JSON.parse(match[1])
  end
end