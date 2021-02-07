class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.guest
    find_or_create_by!(name: 'ゲスト', email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  attachment :profile_image
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_posts, through: :favorites, source: :post
  has_many :comments

  validates :name, presence: true

  def already_favorited?(post)
    self.favorites.exists?(post_id: post.id)
  end

  def User.search(search, user_or_post)
    if user_or_post == "1"
       User.where(['name LIKE ?', "%#{search}%"])
    else
       User.all
    end
  end

end
