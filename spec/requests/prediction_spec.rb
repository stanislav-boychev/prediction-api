require 'rails_helper'

describe 'V1::PredictionsController', type: :request do
  let(:parameters) do
    {
      team1: 'Virtus Pro',
      team2: 'Ninjas in Pyjamas'
    }
  end

  let(:json) do
    JSON.parse(response.body)
  end

  describe 'GET /v1/predictions' do
    context 'with valid parameters' do
      it 'returns OK' do
        get v1_predictions_path(parameters)
        expect(response).to have_http_status :ok
      end

      it 'returns correct prediction' do
        get v1_predictions_path(parameters)
        expect(json).to include 'probability'
        expect(json['probability']).to eq '24%'
      end
    end

    context 'with invalid parameters' do
      let(:parameters) do
        {
          team1: 'Virtus Pro',
          team2: nil
        }
      end

      it 'returns Unprocessable entity' do
        get v1_predictions_path(parameters)
        expect(response).to have_http_status :unprocessable_entity
      end

      it 'returns correct prediction' do
        get v1_predictions_path(parameters)
        expect(json).to include 'errors'
        expect(json['errors']).to eq 'team2' => ['must be present', 'must be String']
      end
    end
  end
end
