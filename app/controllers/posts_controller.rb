# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_group
  before_action :check_if_user_have_access_of_post
  before_action :set_post, only: %i[show edit update destroy]
  before_action :enure_user_have_access_to_edit_and_delete_post, only: %i[edit destroy]

  # GET /:group_id/posts or /:group_id/posts.json
  def index
    @posts = @group.posts
    @post = @group.posts.new
  end

  # GET /:group_id/posts/1 or /:group_id/posts/1.json
  def show; end

  # GET /:group_id/posts/1/edit
  def edit; end

  # POST /:group_id/posts or /:group_id/posts.json
  def create
    @post = @group.posts.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to group_posts_url(@group), notice: 'Post was successfully created.' }
        format.json { render :no_content }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /:group_id/posts/1 or /:group_id/posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to group_posts_url(@group), notice: 'Post was successfully updated.' }
        format.json { render :no_content }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /:group_id/posts/1 or /:group_id/posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to group_posts_url(@group), notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find(params[:group_id])
  end

  def check_if_user_have_access_of_post
    redirect_to groups_url, notice: "You don't have access of the following Group" unless @group.users.include?(current_user)
  end

  def enure_user_have_access_to_edit_and_delete_post
    redirect_to group_posts_url(@group), notice: "Only Post owner and Group owner can edit/delete post" and return unless current_user == @post.user || current_user == @group.user
  end

  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :content, :group_id)
  end
end
