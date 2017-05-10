require 'rails_helper'

describe ServiceErrorResult do
  subject do
    described_class.new(value)
  end

  let(:value) do
    { field: ['invalid'] }
  end

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
          .to raise_error('cannot create an error result given a nil error object')
      end
    end

    context 'given an empty value' do
      let(:value) do
        {}
      end

      it 'raises an error' do
        expect { described_class.new(value) }
          .to raise_error('cannot create an error result given an empty error object')
      end
    end
  end

  describe '#success?' do
    it 'returns false' do
      expect(subject.success?).to be false
    end
  end

  describe '#fail?' do
    it 'returns true' do
      expect(subject.fail?).to be true
    end
  end
end
