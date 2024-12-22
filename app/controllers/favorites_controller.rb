class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    post=Post.find(params[:post_id])
    favorite=current_user.favorites.new(post: post)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    post=Post.find(params[:post_id])
    favorite=current_user.favorites.find_by(post: post)
    favorite&.destroy
    redirect_to request.referer
  end

  def index
    @favorite_posts=current_user.favorite_posts
  end
















end
