class Comment < ActiveRecord::Base
  belongs_to :entry
  after_initialize :set_default_values, if: :new_record?

  private
    def set_default_values
      self.status ||= 'unapproved'
    end
end
