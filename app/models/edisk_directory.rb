class EdiskDirectory < ApplicationRecord
  belongs_to :user, optional: true
  validates :name, presence:true, uniqueness:{scope: :path}
  validates :path, presence:true
  acts_as_tree order: "name", dependent: :destroy
  extend ActsAsTree::TreeView
end
