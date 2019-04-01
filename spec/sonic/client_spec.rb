module Sonic
  RSpec.describe Client do
    include_context 'client'

    subject { client }

    describe '#channel' do
      let(:type) { :control }

      it 'returns instance of channel' do
        expect(subject.channel(type)).to be
      end

      context 'when type is invalid' do
        let(:type) { :invalid }

        it 'raises error' do
          expect { subject.channel(type) }.to raise_error(ArgumentError)
        end
      end
    end
  end
end
