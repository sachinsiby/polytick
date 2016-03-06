module Api
  class StatesController < ApplicationController
    def index
      render json: collection, each_serializer: StateSerializer, root: false
    end

    private

    def collection
      State.all
    end
  end
end
