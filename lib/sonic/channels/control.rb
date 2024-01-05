module Sonic
  module Channels
    class Control < Base
      def trigger(action)
        execute('TRIGGER', action)
      end

      def info
        execute('INFO')
      end
    end
  end
end
