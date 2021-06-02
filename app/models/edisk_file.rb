class EdiskFile < ApplicationRecord
  belongs_to :edisk_Directory, optional: true
  has_one_attached :efile, dependent: :purge_later
  validates :efile, presence:true
  validates :name, presence:true, uniqueness: true
  # validate :acceptable_image, :on => :create

  # def acceptable_image
  #   return unless efile.attached?
    # u = User.find(userID)
    # unless efile.byte_size <= (u.ediskSize-u.current_size)
    #   errors.add(:efile, "is too big")
    # end
  # end
  def pic_for_type
    @a = ''
    case efile.filename.to_s.split(".").last
    when 'pdf'
      @a = '\assets\pdf.png'
    when 'doc'
      @a = '\assets\doc.png'
    when 'docx'
      @a = '\assets\doc.png'
    when 'js'
      @a = '\assets\js.png'
    when 'mp3'
      @a = '\assets\mp3.png'
    when 'mp4'
      @a = '\assets\mp4.png'
    when 'pptx'
      @a = '\assets\powerpoint.png'
    when 'zip'
      @a = '\assets\zip.png'
    when "xls"
      @a = '\assets\xls.png'
    when "txt"
      @a = '\assets\txt.png'
    else
      @a = '\assets\text.png'
    end
  end
end
