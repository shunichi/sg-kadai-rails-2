class Comment < ActiveRecord::Base
  belongs_to :entry
  validates :entry_id, :body, presence: true
  validates :status, inclusion: { in: %w(approved unapproved) }
  after_initialize :set_default_values, if: :new_record?

  private
    def set_default_values
      self.status ||= 'unapproved'
    end
end
