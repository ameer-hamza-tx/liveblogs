class Article < ApplicationRecord
	has_one_attached :image
	belongs_to :user
	has_many :comments, dependent: :destroy

	validates :title, presence: true
  validates :body, presence: true

  def self.ransackable_trributes
  	["id", "title", "body"]
  end

  def self.search(params)
    articles=Article.where("body ILIKE ? or title ILIKE ? or cast(id as text) lIKE ?","%#{params[:search]}%","%#{params[:search]}%","#{params[:search]}")
    articles
    end
  
end
