class Book < ApplicationRecord
  has_one_attached :image
  has_many :favorites, dependent: :destroy
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :week_favorites, -> { where(created_at: Time.current.all_week) }
  validates :title, presence: true
  validates :body, length: { minimum: 1, maximum: 200 }
  has_many :view_counts, dependent: :destroy

  scope :created_today, -> { where(created_at: Time.current.all_day) } 
  scope :created_yesterday, -> { where(created_at: Time.current.yesterday.all_day) } 
  scope :created_2day_ago, -> { where(created_at: 2.day.ago.all_day) }
  scope :created_3day_ago, -> { where(created_at: 3.day.ago.all_day) }
  scope :created_4day_ago, -> { where(created_at: 4.day.ago.all_day) }
  scope :created_5day_ago, -> { where(created_at: 5.day.ago.all_day) }
  scope :created_6day_ago, -> { where(created_at: 6.day.ago.all_day) }
  scope :created_this_week, -> { where(created_at: Time.current.all_week) } 
  scope :created_last_week, -> { where(created_at: Time.current.last_week.all_week) } 
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
