class Note < ApplicationRecord
  belongs_to :user
  has_rich_text :content

  validates :title, :content, :game_type, :game_name, presence: true
  validate :title_validation, on: [:create, :update]

  def title_validation
    validates_with TitleValidator
  end
end