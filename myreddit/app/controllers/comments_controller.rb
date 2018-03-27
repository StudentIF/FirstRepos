class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
     @comment = Comment.find(post_id=[:id])
    # render text: params[:id]
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
    # @comment = @post.comments.create(comment_params)

    #   this doesn't work either
    # @comment = Comment.new(comment_params)
    # @comment.update(post_id: :post_id , user_id: current_user.id)
    # @comment.save

    comment = @post.comments.create(comment_params.merge(user_id: current_user.id))
    redirect_to @post

    # respond_to do |format|
    #   if @comment.save
    #     format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
    #     format.json { render :show, status: :created, location: @comment }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @comment.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    redirect_to @post , notice: 'This comment has been updated'

    # respond_to do |format|
    #   if @comment.update(comment_params)
    #     format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @comment }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @comment.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to @post , notice: 'Comment deleted as requested'

    # respond_to do |format|
    #   format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
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
      params.require(:comment).permit(:text, :user_id)
      # Comment.user_id = current_user.id
    end
end