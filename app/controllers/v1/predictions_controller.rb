module V1
  # Controller for handling /v1/predictions endpoint
  class PredictionsController < ApplicationController
    # GET /v1/predictions
    def index
      @result = PredictionService.new.call(team1: index_params[:team1],
                                           team2: index_params[:team2])

      if @result.success?
        render
      else
        render json: { errors: @result.errors }, status: :unprocessable_entity
      end
    end

    private

    def index_params
      params.permit(:team1, :team2)
    end
  end
end
