class PostsController < ApplicationController
  # before_action :authenticate_user!
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote ]
  load_and_authorize_resource

  # GET /posts
  def index
    # @posts = Post.all
    # @posts = Post.all.sort_by{|p| p.votes_for.size}   is just number of votes, regardless of up or down.

    if params[:search]
      @posts = Post.search(params[:search]).sort_by{|p| p.get_dislikes.size - p.get_likes.size}
    else
      @posts = Post.all.sort_by{|p| p.get_dislikes.size - p.get_likes.size}
    end
    # this would be useful with pagination as opposed to reading in the whole file.

  end

  # GET /posts/1
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    # @post = Post.new(post_params)
    # @post.user_id = current_user.id

    @post = current_user.posts.new(post_params)


    if @post.save
        # redirect_to @post, notice: 'Post was successfully created.'   shorthand for the below.
        redirect_to post_path(@post.id), notice: 'Post was successfully created.'
    else
        render :new
    end
  end

  # PATCH/PUT /posts/1
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
    @post.liked_by current_user
    redirect_to posts_url
  end

  def downvote
    @post.downvote_from current_user
    redirect_to posts_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content)
    end
end
