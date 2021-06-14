class EdiskFile < ApplicationRecord
  belongs_to :edisk_Directory, optional: true
  has_one_attached :efile, dependent: :purge_later
  validates :efile, presence:true
  validates :name, presence:true, uniqueness: true

  attr_accessor :number_of_expiration
  attr_accessor :type_of_expiration
  def before_save
    this.expiration_time = @number_of_expiration + " " + @type_of_expiration
  end
  def pic_for_type
    @a = ''
    case efile.filename.to_s.split(".").last
    when 'pdf'
      @a = 'pdf.png'
    when 'doc'
      @a = 'doc.png'
    when 'docx'
      @a = 'doc.png'
    when 'js'
      @a = 'js.png'
    when 'mp3'
      @a = 'mp3.png'
    when 'mp4'
      @a = 'mp4.png'
    when 'pptx'
      @a = 'powerpoint.png'
    when 'zip'
      @a = 'zip.png'
    when "xls"
      @a = 'xls.png'
    when "txt"
      @a = 'txt.png'
    else
      @a = 'text.png'
    end
  end
end
