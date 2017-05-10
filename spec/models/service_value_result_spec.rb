require 'rails_helper'

describe ServiceValueResult do
  subject { described_class.new(value) }

  let(:value) { 'Foo' }

  describe 'initialization' do
    context 'given a valid value' do
      it 'successfuly creates an instance' do
        expect(subject).to be_a described_class
      end
    end

    context 'given a nil value' do
      let(:value) do
        nil
      end

      it 'raises an error' do
        expect { described_class.new(value) }
          .to raise_error('cannot have a successful result with nil value')
      end
    end
  end

  describe '#success?' do
    it 'returns true' do
      expect(subject.success?).to be true
    end
  end

  describe '#fail?' do
    it 'returns false' do
      expect(subject.fail?).to be false
    end
  end
end
