class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_comment, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    # @comment = Comment.find(post_id=[:id])
    # this is done in hte before_action :set_comment, which is definied at the bottom of the controller in the private section
  end

  # GET /comments/new
  def new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @post = Post.find(params[:post_id])

    comment = @post.comments.new(comment_params.merge(user_id: current_user.id))

    if comment.save
      redirect_to @post, notice: 'Comment was successfully created.'
    else
      redirect_to @post, notice: 'There was a problem with the comment,not created.'
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    @comment.update(comment_params)
    redirect_to @post , notice: 'This comment has been updated'
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    redirect_to @post , notice: 'Comment deleted as requested'
  end


  def upvote
    @comment.liked_by current_user
    redirect_to @post
  end

  def downvote
    @comment.downvote_from current_user
    redirect_to @post
  end

  private

    def set_post
      @post = Post.find(params[:post_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:text)
    end
end
