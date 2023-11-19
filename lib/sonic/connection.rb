module Sonic
  class Connection
    def self.connect(*args)
      connection = new(*args)
      connection if connection.connect
    end

    def initialize(host, port, channel_type, password = nil)
      @host = host
      @port = port
      @channel_type = channel_type
      @password = password
    end

    def connect
      socket.gets # ...
      write(['START', @channel_type, @password].compact.join(' '))
      read.start_with?('STARTED ')
    end

    def disconnect
      socket.close
    end

    def read
      data = socket.gets&.chomp

      raise ServerError, data if data.nil?
      raise ServerError, data if data.start_with?('ENDED ')
      raise ServerError, data if data.start_with?('ERR ')

      data
    end

    def write(data)
      begin
        socket.puts(data)
      rescue Errno::EPIPE
        reconnect
        socket.puts(data)
      end
    end


    private

    def socket
      @socket ||= TCPSocket.open(@host, @port)
    end

    def reconnect
      @socket.close if @socket
      @socket = TCPSocket.open(@host, @port)

      connect
    end
  end
end
