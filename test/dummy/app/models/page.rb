class Page < ActiveRecord::Base
  attr_accessible :content, :name

  validates :name, presence: true
  validates :content, presence: true
end
