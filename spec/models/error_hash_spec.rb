require 'rails_helper'

describe ErrorHash do
  subject do
    described_class.new
  end

  describe 'initialization' do
    it 'is a Hash' do
      expect(subject).to be_a Hash
    end
  end

  describe '#add' do
    it 'adds a value to an array under the key' do
      expect { subject.add(:foo, 'bar') }.to change { subject[:foo] }
        .from([]).to(['bar'])
    end

    context 'given a key with existing values' do
      before { subject.add(:foo, 'baz') }

      it 'does not remove existing values in array' do
        expect { subject.add(:foo, 'bar') }.to change { subject[:foo] }
          .from(['baz']).to(['baz', 'bar'])
      end
    end
  end
end
