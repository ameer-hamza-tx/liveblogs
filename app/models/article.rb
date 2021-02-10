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
    articles=Article.where("body LIKE ? or title LIKE ? or id LIKE ?","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%") if params[:search].present?
    articles
  end

  ransacker :id do
    Arel::Nodes::SqlLiteral.new(
      "regexp_replace(to_char(\"#{table_name}\".\"id\", '99999999'), ' ', '', 'g')"
    )
  end
  
end
