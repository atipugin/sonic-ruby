module Sonic
  module Channels
    class Control < Base
      def trigger(action)
        execute('TRIGGER', action)
      end
    end
  end
end
