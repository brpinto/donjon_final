class Note < ApplicationRecord
  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_rich_text :content

  after_validation :set_slug, only: [:create, :update]

  validates :title, :content, :game_type, :game_name, presence: true
  validate :title_validation, on: [:create, :update]

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(", ")
  end

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