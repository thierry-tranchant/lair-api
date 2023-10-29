# frozen_string_literal: true

class WebUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :game_players, class_name: 'Games::GamePlayer', dependent: :nullify
  has_one_attached :avatar

  def avatar_url
    avatar.attached? ? avatar.service_url : nil
  end 
end
