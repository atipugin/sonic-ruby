module Sonic
  module Channels
    class Base
      attr_reader :connection

      def initialize(connection)
        @connection = connection
      end

      def ping
        execute('PING')
      end

      def help(manual)
        execute('HELP', manual)
      end

      def quit
        execute('QUIT')
        connection.disconnect
      end

      private

      def execute(*args)
        connection.write(*args.join(' '))
        yield if block_given?
        connection.read
      end

      def quote(value)
        "\"#{value}\""
      end
    end
  end
end
