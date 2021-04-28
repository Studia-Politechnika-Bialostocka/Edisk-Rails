class EdiskDirectory < ApplicationRecord
  belongs_to :user, optional: true
  validates :name, presence:true, uniqueness:true
  # validates :path, presence:true
  # validates :parent_id, absence:true
  has_ancestry
end
