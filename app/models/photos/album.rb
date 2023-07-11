module Photos
  class Album < ApplicationRecord
    include ActiveModel::Serialization

    has_many :sub_albums, class_name: "Photos::Album", foreign_key: "parent_album_id"
    has_many :photos, class_name: "Photos::Photo", dependent: :destroy
    has_one_attached :file
    belongs_to :parent_album, class_name: "Photos::Album", optional: true

    def attributes
      {
        title: nil,
      }
    end
  end
end
