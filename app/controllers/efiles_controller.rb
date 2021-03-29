class EfilesController < ApplicationController
  def index
    # @efiles = Efile.all

    efiles = Efile.includes(:awards)
    render json: EfileSerializer.new(efiles).serialized_json
  end
end
