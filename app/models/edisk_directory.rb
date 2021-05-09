class EdiskDirectory < ApplicationRecord

  belongs_to :user, optional: true
  has_many :edisk_files, dependent: :destroy
  validates :name, presence: true
  validates :name, uniqueness: {scope: [:ancestry,  :user_id], message: :ll}
  has_ancestry

  def ancestry_into_array
    a = ancestry.to_s.split("/")
    @text = ""
    a.each do |temp|
      @text += EdiskDirectory.find(temp.to_i).name
      @text += "/"
    end
    @text += name
  end

end
