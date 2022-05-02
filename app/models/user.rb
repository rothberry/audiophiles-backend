class User < ApplicationRecord
  has_secure_password
  has_many :songs, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  has_many :active_relationships, class_name: 'Following', foreign_key: 'follower_id', dependent: :destroy
  has_many :passive_relationships, class_name: 'Following', foreign_key: 'followed_id', dependent: :destroy
  has_many :followed_users, through: :active_relationships, source: :followed
  has_many :follower_users, through: :passive_relationships, source: :follower

  # For AWS
  has_one_attached :image_link

  # accepts_nested_attributes_for :songs, :favorites, :followed_users, :follower_users, :comments

  validates :username, :name, :location, :bio, presence: true
  validates_presence_of :password, on: :create
  validates :username, uniqueness: true
  validates :username, length: {minimum: 1, maximum: 20}
end
