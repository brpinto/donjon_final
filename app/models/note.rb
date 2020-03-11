class Note < ApplicationRecord
  belongs_to :user

  validates :title, :content, :game_type, :game_name, presence: true
end