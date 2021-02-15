class ArticlesController < ApplicationController
  before_action :authenticate_user!, except:[:index,:show,:search]
  before_action :correct_user, only:[:edit,:update,:destroy]

  def index
  	@articles=Article.all.order("created_at ASC").page(params[:page])
  end

  def search
    if params[:search].blank?
      @articles=Article.all.order("created_at ASC").page(params[:page])
    else 
      @articles=Article.search(params)
    end
  end

  def mine
    @article=Article.where(user_id: current_user.id)
  end

   def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new
    end
  end
  
  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path
  end

  def correct_user
    @article=current_user.articles.find_by(id: params[:id])
    redirect_to articles_path ,notice:"Not Authorized for this action" if @article.nil?
  end

  private
    def article_params
      params.require(:article).permit(:title, :body,:user_id,:image)
    end
end
