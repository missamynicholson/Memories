class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :memes, dependent: :destroy

  validates :username, presence: true, length: { minimum: 4, maximum: 16 }

  validates_uniqueness_of :username
end
