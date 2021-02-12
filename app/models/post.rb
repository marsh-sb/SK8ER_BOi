class Post < ApplicationRecord
  belongs_to :user
  attachment :image
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :comments, dependent: :destroy

  acts_as_taggable   # acts_as_taggable_on :tags の省略

  with_options presence: true do
    validates :title, length: { maximum: 25 }
    validates :body
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search(search)
    return Post.all unless search
    Post.where(["title LIKE ? OR body LIKE ?", "%#{search}%", "%#{search}%"])
  end

end
