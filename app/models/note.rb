class Note < ApplicationRecord
  belongs_to :user
  has_rich_text :content

  validates :title, :content, :game_type, :game_name, presence: true
end