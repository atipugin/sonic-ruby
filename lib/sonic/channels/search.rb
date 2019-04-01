module Sonic
  module Channels
    class Search < Base
      def query(collection, bucket, terms, limit = nil, offset = nil, lang = nil) # rubocop:disable Metrics/ParameterLists, Metrics/LineLength
        arr = [collection, bucket, quote(terms)]
        arr += "LIMIT(#{limit})" if limit
        arr += "OFFSET(#{offset})" if offset
        arr += "LANG(#{lang})" if lang

        execute('QUERY', *arr) do
          connection.read # ...
        end
      end

      def suggest(collection, bucket, word, limit = nil)
        arr = [collection, bucket, quote(word)]
        arr += "LIMIT(#{limit})" if limit

        execute('SUGGEST', *arr) do
          connection.read # ...
        end
      end
    end
  end
end
