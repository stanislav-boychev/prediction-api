require 'rails_helper'

describe PredictionService do
  subject do
    described_class.new
  end

  let(:parameters) do
    {
      team1: 'Virtus Pro',
      team2: 'Ninjas in Pyjamas'
    }
  end


  describe '#call' do
    context 'with valid parameters' do
      it 'returns successful result' do
        expect(subject.call(parameters)).to be_success
      end

      it 'returns result with correct value' do
        result = subject.call(parameters)
        expect(result.value).to eq 0.24
      end
    end

    context 'with Liguid & GODSENT parameters' do
      let(:parameters) do
        {
          team1: 'Liquid',
          team2: 'GODSENT'
        }
      end

      it 'returns successful result' do
        expect(subject.call(parameters)).to be_fail
      end

      it 'returns result with correct value' do
        result = subject.call(parameters)
        expect(result.errors). to include probability: ["can't be calculated"]
      end
    end

    context 'with Kinguin & Liquid parameters' do
      let(:parameters) do
        {
          team1: 'Kinguin',
          team2: 'Liquid'
        }
      end

      it 'returns successful result' do
        expect(subject.call(parameters)).to be_success
      end

      it 'returns result with correct value' do
        result = subject.call(parameters)
        expect(result.value). to eq 0.1
      end
    end

    context 'with fnatic & FaZe parameters' do
      let(:parameters) do
        {
          team1: 'fnatic',
          team2: 'FaZe'
        }
      end

      it 'returns successful result' do
        expect(subject.call(parameters)).to be_fail
      end

      it 'returns result with correct value' do
        result = subject.call(parameters)
        expect(result.errors). to include probability: ["can't be calculated"]
      end
    end

    context 'with invalid parameters' do
      context 'witn missing team names' do
        let(:parameters) do
          {
            team1: nil,
            team2: nil
          }
        end

        it 'returns Unprocessable entity' do
          expect(subject.call(parameters)).to be_fail
        end

        it 'returns correct prediction' do
          result = subject.call(parameters)
          expect(result.errors). to include team1: ['must be present', 'must be String']
          expect(result.errors). to include team2: ['must be present', 'must be String']
        end
      end

      context 'witn non string value' do
        let(:parameters) do
          {
            team1: [],
            team2: 1232
          }
        end

        it 'returns Unprocessable entity' do
          expect(subject.call(parameters)).to be_fail
        end

        it 'returns correct prediction' do
          result = subject.call(parameters)
          expect(result.errors). to include team1: ['must be String']
          expect(result.errors). to include team2: ['must be String']
        end
      end
    end
  end
end
