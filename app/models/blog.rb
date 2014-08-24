class Blog < ActiveRecord::Base
  has_many :entries, dependent: :destroy
  validates :title, presence: true
end
