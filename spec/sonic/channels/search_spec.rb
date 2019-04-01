module Sonic
  module Channels
    RSpec.describe Search do
      include_examples 'channel'

      subject { client.channel(:search) }

      let(:collection) { 'collection' }
      let(:bucket) { 'bucket' }
      let(:object) { 'object' }
      let(:terms) { 'terms' }

      before do
        client.channel(:ingest).push(collection, bucket, object, terms)
        client.channel(:control).trigger('consolidate')
      end

      describe '#query' do
        it 'returns proper object' do
          expect(subject.query(collection, bucket, terms)).to eq(object)
        end
      end

      describe '#suggest' do
        it 'suggest proper terms' do
          expect(subject.suggest(collection, bucket, terms[0..-2])).to eq(terms)
        end
      end
    end
  end
end
