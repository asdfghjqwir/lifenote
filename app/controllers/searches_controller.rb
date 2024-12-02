class SearchesController < ApplicationController
  before_action :authenticate_user!

	def search
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]

	  if @model == 'post'
      @results = Post.search_for(@content, @method)
    elsif @model == 'user'
      @results = User.search_for(@content, @method)
    else
      @results = []
		end
	end
end
