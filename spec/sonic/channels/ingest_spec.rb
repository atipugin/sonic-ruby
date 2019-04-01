module Sonic
  module Channels
    RSpec.describe Ingest do
      include_examples 'channel'

      subject { client.channel(:ingest) }

      let(:collection) { 'collection' }
      let(:bucket) { 'bucket' }
      let(:object) { 'object' }
      let(:text) { 'text' }

      describe '#push' do
        it 'returns true' do
          expect(subject.push(collection, bucket, object, text)).to eq(true)
        end
      end

      describe '#pop' do
        it 'returns a number' do
          expect(subject.pop(collection, bucket, object, text))
            .to be_an(Integer)
        end
      end

      describe '#count' do
        it 'returns a number' do
          expect(subject.count(collection, bucket, object)).to be_an(Integer)
        end
      end

      describe '#flushc' do
        it 'returns a number' do
          expect(subject.flushc(collection)).to be_an(Integer)
        end
      end

      describe '#flushb' do
        it 'returns a number' do
          expect(subject.flushb(collection, bucket)).to be_an(Integer)
        end
      end

      describe '#flusho' do
        it 'returns a number' do
          expect(subject.flusho(collection, bucket, object)).to be_an(Integer)
        end
      end
    end
  end
end
