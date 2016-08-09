# frozen_string_literal: true
require 'test_helper'

class EventStreamParserTest < ActiveSupport::TestCase
  setup do
    @good_stream = File.read('test/fixtures/files/event_stream.txt')
  end

  test 'should parse the correct event format' do
    regex = EventStreamParser.new('measurement').send(:event_format_regex)
    match = regex.match @good_stream
    assert_not_nil(match)
  end

  test 'should parse an event' do
    resulting_events = []

    parser = EventStreamParser.new 'measurement' do |event|
      resulting_events << event
    end

    @good_stream.lines.each { |line| parser.feed(line) }

    assert_equal(1, resulting_events.count)
    resulting_events.each do |event|
      assert_instance_of(OpenStruct, event)
      assert_respond_to(event, :data)
      assert_respond_to(event, :ttl)
      assert_respond_to(event, :published_at)
      assert_respond_to(event, :coreid)
    end
  end

  test 'can handle a lot of nothing' do
    parser = EventStreamParser.new '.*' do |_event|
      raise 'nothing should have been parsed'
    end

    100_000.times { parser.feed "\n" }
  end
end
