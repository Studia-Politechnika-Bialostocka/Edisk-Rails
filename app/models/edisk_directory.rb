class EdiskDirectory < ApplicationRecord
  belongs_to :user, optional: true
  validates :name, presence:true, uniqueness: {scope: [:ancestry, :user_id]}
  # validates :path, presence:true
  # validates :parent_id, absence:true
  has_ancestry
end
