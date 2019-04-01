module Sonic
  RSpec.shared_examples 'channel' do
    include_context 'client'

    describe '#ping' do
      it 'pongs' do
        expect(subject.ping).to eq('PONG')
      end
    end

    describe '#quit' do
      it 'closes connection' do
        subject.quit
        expect { subject.connection.read }.to raise_error(IOError)
      end
    end
  end
end
