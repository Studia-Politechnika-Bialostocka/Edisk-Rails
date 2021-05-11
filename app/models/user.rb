class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  has_many :edisk_directories, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  validates :email, presence: true, uniqueness: true                                                                      #TODO case sensitive add
  validates :password, format: { with: /[A-Za-z0-9][^A-Za-z0-9\s]|[^A-Za-z0-9\s][A-Za-z0-9]/,
                                                        message: "at least one special character and a letter/number" }

  validates :username, presence: true, uniqueness: true, length: { minimum: 2}


end