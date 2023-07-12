# frozen_string_literal: true

module Photos
  class AlbumsController < ApplicationController

    def index
      albums = Album.where(parent_album_id: album_params[:parent_album_id].presence)

      render json: {
        results: albums.map do |album|
          album.serializable_hash(
            include: [
              photos: {only: ['id', 'title'], methods: ['file_url']},
              sub_albums: {only: ['title', 'id']},
            ]
          )
        end
      }
    end

    def show
      album = Album.find_by(id: params[:id])

      render json: {
        result: album.serializable_hash(
          include: [
            photos: {only: ['id', 'title'], methods: ['file_url']},
            sub_albums: {only: ['title', 'id']},
          ]
        )
      }
    end

    def create
      album = Album.create!(album_params)

      render json: {
        result: album.serializable_hash(
          include: [
            photos: {only: ['title', 'file_url']},
            sub_albums: {only: ['title', 'id']},
          ]
        )
      }
    end

    def destroy
      Album.find_by(id: album_params[:id]).destroy
      
      head :no_content
    end

    private 

    def album_params
      params
        .require(:album)
        .permit(:id, :title, :parent_album_id)
    end
  end
end
