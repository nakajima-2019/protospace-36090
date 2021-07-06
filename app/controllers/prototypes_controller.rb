class PrototypesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :set_prototype,only: [:show, :update, :edit, :destroy]
  before_action :move_to_index, except: [:index, :show]

  def index
    @prototype = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def update
    @prototype.update(prototypes_params)
    if @prototype.save
      redirect_to prototype_path
    else
      render :edit
    end
  end

  def edit
  end
  
  def create
    @prototype = Prototype.new(prototypes_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    @prototype.destroy
    redirect_to root_path
  end

  private
  def prototypes_params
    params.require(:prototype).permit(:title, :catch_copy,:concept,:image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def move_to_index
    unless current_user == @prototype.user
      redirect_to action: :index
    end
  end

end

