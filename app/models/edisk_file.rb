class EdiskFile < ApplicationRecord
  belongs_to :edisk_Directory, optional: true
  has_one_attached :avatar, dependent: :destroy
  validates :avatar, presence:true
  validates :name, presence:true, uniqueness: true
  validate :acceptable_image

  def acceptable_image
    return unless avatar.attached?

    unless avatar.byte_size <= (User.find(userID).ediskSize-User.find(userID).current_size)
      errors.add(:avatar, "is too big")
    end
  end
  def pic_for_type
    @a = ''
    case avatar.content_type
    when 'application/pdf'
      @a = 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/df/Icon-pdf.svg/711px-Icon-pdf.svg.png'
    end
    end
end
