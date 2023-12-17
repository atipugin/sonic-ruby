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
      socket&.close
      socket = nil
    end

    def connected?
      !socket.nil?
    end

    def read
      data = socket.gets&.chomp

      if data.nil?
        # connection was dropped from timeout
        disconnect
        raise ServerError, "Connection expired. Please reconnect."
      end

      raise ServerError, "#{data.force_encoding('UTF-8')} (#{@last_write})" if data.start_with?('ENDED ')
      raise ServerError, "#{data.force_encoding('UTF-8')} (#{@last_write})" if data.start_with?('ERR ')

      data
    end

    def write(data)
      @last_write = data

      begin
        socket.puts(data)
      rescue Errno::EPIPE => error
        disconnect
        raise ServerError, "Connection expired. Please reconnect.", error.backtrace
      end
    end


    private

    def socket
      @socket ||= begin
                    socket = TCPSocket.open(@host, @port)
                    # disables Nagle's Algorithm, prevents multiple round trips with MULTI
                    socket.setsockopt(Socket::IPPROTO_TCP, Socket::TCP_NODELAY, 1)
                    socket
                  end
    end

  end
end
