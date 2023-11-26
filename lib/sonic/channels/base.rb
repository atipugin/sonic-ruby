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
        if connection.connected?
          execute('QUIT')
          connection.disconnect
          return true
        end

        return false
      end

      def close
        connection.disconnect
      end

      def connected?
        connection.connected?
      end

      private

      def execute(*args)
        connection.write(*args.join(' '))
        yield if block_given?
        type_cast_response(connection.read)
      end

      def normalize(value)
        quote(sanitize(value))
      end

      def sanitize(value)
        value.gsub('"', '\\"').gsub(/[\r\n]+/, '\\n').gsub(/\\/, '\\\\')
      end

      def quote(value)
        "\"#{value}\""
      end

      def type_cast_response(value)
        if value == 'OK'
          true
        elsif value.start_with?('RESULT ')
          value.split(' ').last.to_i
        elsif value.start_with?('EVENT ')
          value.split(' ')[3..-1].join(' ')
        else
          value
        end
      end
    end
  end
end
