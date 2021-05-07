class EdiskFile < ApplicationRecord
  belongs_to :edisk_Directory, optional: true
  has_one_attached :avatar
end
