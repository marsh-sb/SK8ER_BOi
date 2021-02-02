class Post < ApplicationRecord
  belongs_to :user
  attachment :image
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :comments, dependent: :destroy

  with_options presence: true do
    validates :title
    validates :body
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def Post.search(search, user_or_post)
    if user_or_post == "2"
       Post.where(['title LIKE ?', "%#{search}%"])
    else
       Post.all
    end
  end

end
