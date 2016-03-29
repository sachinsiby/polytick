module Api
  class ResultsController < ApplicationController
    def index
      render json: collection, each_serializer: ResultSerializer, root: false
    end

    private

    def collection
      Result.all
    end
  end
end
