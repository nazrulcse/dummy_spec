class Blog < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  validates :title, :presence => true
  validates :description, :presence => true

  def self.unpublished
    self.where('status = ? or status IS NULL', false)
  end

  def self.user_published(user_id)
    self.where('status = ? and user_id = ?', true, user_id)
  end

  def self.user_unpublished(user_id)
    self.where('(status = ? or status IS NULL) and user_id = ?', false, user_id)
  end

end
