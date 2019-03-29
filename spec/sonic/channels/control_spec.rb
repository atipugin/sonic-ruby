module Sonic
  module Channels
    RSpec.describe Control do
      subject { described_class.new(connection) }

      let(:connection) { Connection.connect(host, port, type, password) }
      let(:host) { 'localhost' }
      let(:port) { 1491 }
      let(:type) { 'control' }
      let(:password) { 'SecretPassword' }

      describe '#trigger' do
        let(:action) { 'consolidate' }

        it 'returns ok' do
          expect(subject.trigger(action)).to eq('OK')
        end

        context 'when action is invalid' do
          let(:action) { 'invalid' }

          it 'raises error' do
            expect { subject.trigger(action) }.to raise_error(ServerError)
          end
        end
      end
    end
  end
end
