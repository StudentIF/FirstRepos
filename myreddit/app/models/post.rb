class Post < ApplicationRecord
  belongs_to :user
  acts_as_votable
  has_many :comments , dependent: :destroy

  def self.search(search)
    where("content LIKE ? OR title LIKE ?", "%#{search}%" , "%#{search}%")
    # could search by user name as well
  end

end
