class EdiskDirectory < ApplicationRecord

  belongs_to :user, optional: true
  validates :name, presence:true, uniqueness: {scope: [:ancestry, :user_id]}
  # validates :path, presence:true
  # validates :parent_id, absence:true
  has_ancestry

  def ancestry_into_array
    puts ancestry
    puts "hhihihih-------------------------------------"
    a = ancestry.to_s.split("/")
    @text = ""
    a.each do |temp|
      @text += EdiskDirectory.find(temp.to_i).name
      @text += "/"
    end
    @text += name
  end

end
