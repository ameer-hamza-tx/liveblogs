class Article < ApplicationRecord
	has_one_attached :image
	belongs_to :user
	has_many :comments, dependent: :destroy

	validates :title, presence: true
  validates :body, presence: true

  def self.ransackable_attributes(auth_object=null)
  	["id", "title", "body"]
  end

  # def self.search(params)
  #   articles=Article.where("body ILIKE ? or title ILIKE ? or cast(id as text) lIKE ?","%#{params[:search]}%","%#{params[:search]}%","#{params[:search]}")
  #   articles
  #   end

  ransacker :id_to_s do 
  Arel.sql("regexp_replace(to_char(\"#{table_name}\".\"id\", '9999999'), ' ', '', 'g')")
  end
  
end
