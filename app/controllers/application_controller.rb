class ApplicationController < ActionController::Base
	def set_global_search_variable
  	@q = Article.ransack(params[:q])
	end
end
