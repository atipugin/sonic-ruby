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
      read # ...
      write(['START', @channel_type, @password].compact.join(' '))
      read.start_with?('STARTED ')
    end

    def disconnect
      socket.close
    end

    def read
      data = socket.gets.chomp
      raise ServerError, data if data.start_with?('ERR ')

      data
    end

    def write(data)
      socket.puts(data)
    end

    private

    def socket
      @socket ||= TCPSocket.open(@host, @port)
    end
  end
end
