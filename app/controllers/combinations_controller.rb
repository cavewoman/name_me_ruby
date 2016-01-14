class CombinationsController < ApplicationController
  respond_to :json

  def index
    @combiner = Combinatorialist.new(combination_params)
    if @combiner.valid?
      if @combiner.execute
        render json: @combiner.combinations, status: 200
      else
        render json: { error: @cleaner.errors }, status: 500
      end
    else
      render json: { error: @combiner.errors }, status: 401
    end
  end

  private

  def combination_params
    params.slice('options')
  end

end
