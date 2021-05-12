class EdiskFile < ApplicationRecord
  belongs_to :edisk_Directory, optional: true
  has_one_attached :avatar, dependent: :destroy
  validates :avatar, presence:true
  validates :name, presence:true, uniqueness: true
  validate :acceptable_image, :on => :create

  def acceptable_image
    return unless avatar.attached?
    u = User.find(userID)
    unless avatar.byte_size <= (u.ediskSize-u.current_size)
      errors.add(:avatar, "is too big")
    end
  end
  def pic_for_type
    @a = ''
    case avatar.content_type
    when 'application/pdf'
      @a = 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/df/Icon-pdf.svg/711px-Icon-pdf.svg.png'
    else
      @a = 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fthumb%2F0%2F0c%2FFile_alt_font_awesome.svg%2F512px-File_alt_font_awesome.svg.png&f=1&nofb=1'
    end
  end
end
