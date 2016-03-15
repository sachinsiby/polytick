module Api
  class PollsController < ApplicationController
    def index
      render json: collection, each_serializer: PollSerializer, root: false
    end

    def show
      render json: Poll.find(params[:id]), serializer: PollSerializer, root: false
    end

    private

    def collection
      Poll.ascending
    end
  end
end
