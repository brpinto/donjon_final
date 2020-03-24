class Note < ApplicationRecord
  belongs_to :user
  has_rich_text :content
  serialize :content

  after_validation :set_slug, only: [:create, :update]

  validates :title, :content, :game_type, :game_name, presence: true
  validate :title_validation, on: [:create, :update]

  def title_validation
    validates_with TitleValidator
  end

  def set_slug
    self.slug = title.to_s.parameterize
  end

  def to_param
    slug
  end
end