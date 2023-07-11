# frozen_string_literal: true

module Photos
  class PhotosController < ApplicationController

    def show
      photo = Photo.find_by(id: params[:id])

      render json: {
        result: photo&.serializable_hash(
          methods: [:file_url, :blob_id],
        )
      }
    end

    def create
      photo = Photo.create!(photo_params)

      render json: {result: photo}
    end

    def update
      photo = Photo.find_by(id: params[:id]).update!(photo_params)

      render json: {result: photo}
    end

    def destroy
      Photo.find_by(id: params[:id]).destroy

      head :no_content
    end

    private 

    def photo_params
      params
        .require(:photo)
        .permit(
            :title,
            :blob_id,
            :album_id,
            file: [:io, :filename],
        ).tap do |parameters|
          if parameters[:blob_id].blank? && parameters[:file]
            parameters[:file][:io] = sanitize_file(parameters.dig(:file, :io))
          else
            parameters.delete(:blob_id)
            parameters.delete(:file) if parameters[:file]
          end
        end
    end

    def sanitize_file(file)
      return if !file

      tmp_file = Tempfile.new
      tmp_file << Base64.decode64(file).force_encoding("UTF-8")
      tmp_file.open
    end
  end
end
