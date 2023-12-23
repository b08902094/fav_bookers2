class Book < ApplicationRecord
  has_one_attached :image
  has_many :favorites, dependent: :destroy
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :week_favorites, -> { where(created_at: Time.current.all_week) }
  validates :title, presence: true
  validates :body, length: { minimum: 1, maximum: 200 }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
end
