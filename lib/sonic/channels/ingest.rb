module Sonic
  module Channels
    class Ingest < Base
      def push(collection, bucket, object, text, lang = nil)
        arr = [collection, bucket, object, normalize(text)]
        arr << "LANG(#{lang})" if lang

        execute('PUSH', *arr)
      end

      def pop(collection, bucket, object, text)
        execute('POP', collection, bucket, object, normalize(text))
      end

      def count(collection, bucket = nil, object = nil)
        execute('COUNT', *[collection, bucket, object].compact)
      end

      def flushc(collection)
        execute('FLUSHC', collection)
      end

      def flushb(collection, bucket)
        execute('FLUSHB', collection, bucket)
      end

      def flusho(collection, bucket, object)
        execute('FLUSHO', collection, bucket, object)
      end
    end
  end
end
