module Sonic
  class Client
    def initialize(host, port, password = nil)
      @host = host
      @port = port
      @password = password
    end

    def channel(type)
      channel_class(type).new(Connection.connect(@host, @port, type, @password))
    end

    private

    def channel_class(type)
      case type.to_sym
      when :control then Channels::Control
      when :ingest then Channels::Ingest
      when :search then Channels::Search
      else raise ArgumentError, "`#{type}` channel type is not supported"
      end
    end
  end
end
