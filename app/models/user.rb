class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  validates :password, length: { minimum: 8 }, format: { with: /[A-Za-z0-9][^A-Za-z0-9\s]|[^A-Za-z0-9\s][A-Za-z0-9]/,
                                                        message: "at least one special character and a letter/number" }

  validates :username, uniqueness: true, length: { minimum: 2}

end