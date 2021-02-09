class Article < ApplicationRecord
	has_one_attached :image
	belongs_to :user
	has_many :comments, dependent: :destroy
	
	validates :title, presence: true
  validates :body, presence: true

  def self.ransackable_trributes
  	["id", "title", "body"]
  end

  
  
end
