class User < ApplicationRecord
  #TODO: validates
  has_many :tweets, dependent: :destroy     #ユーザを消すとツイートも消える
  has_many :likes, dependent: :destroy    #ユーザを消すといいねも消える
  has_many :like_tweets, through: :likes, source: :tweet
  
  validates :password, presence: true, confirmation: true
  
  attr_accessor :password, :password_confirmation
  
  def password=(val)
    if val.present?
      self.pass = BCrypt::Password.create(val)
    end
    @password = val
  end
end