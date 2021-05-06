class EdiskFile < ApplicationRecord
  belongs_to :edisk_Directory, optional: true
end
