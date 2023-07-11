module Photos
  class Photo < ApplicationRecord
    include ActiveModel::Serialization

    belongs_to :album, class_name: "Photos::Album"
    has_one_attached :file

    def file_url
      file.url
    end

    def blob_id
      file.blob&.id
    end

    def attributes
      {
        title: nil,
        album_id: nil,
      }
    end
  end
end
