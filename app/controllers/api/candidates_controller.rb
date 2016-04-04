module Api
  class CandidatesController < ApplicationController
    def index
      render json: collection, each_serializer: CandidateSerializer, root: false
    end
    private

    def collection
      Candidate.all
    end
  end
end
