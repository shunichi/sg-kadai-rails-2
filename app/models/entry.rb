class Entry < ActiveRecord::Base
  belongs_to :blog
  has_many :comments, dependent: :destroy
  validates :blog_id, :title, :body, presence: true
end
