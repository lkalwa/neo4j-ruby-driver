# frozen_string_literal: true

RSpec.describe 'StatementResult' do
  describe '#single' do
    subject do
      driver.session { |session| session.run("UNWIND [#{items}] as r RETURN r").single.first }
    end

    shared_examples 'raises exception' do
      specify { expect(&method(:subject)).to raise_error Neo4j::Driver::Exceptions::NoSuchRecordException, message }
    end

    context 'when 0 results' do
      let(:items) { '' }
      let(:message) { Neo4j::Driver::Exceptions::NoSuchRecordException::EMPTY }

      it_behaves_like 'raises exception'
    end

    context 'when 1 result' do
      let(:items) { '1' }

      it { is_expected.to eq 1 }
    end

    context 'when 2 results' do
      let(:items) { '1, 2' }
      let(:message) { Neo4j::Driver::Exceptions::NoSuchRecordException::TOO_MANY }

      it_behaves_like 'raises exception'
    end
  end
end
