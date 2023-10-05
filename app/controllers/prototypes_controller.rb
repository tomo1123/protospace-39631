class PrototypesController < ApplicationController
before_action :authenticate_user!, only: [:new, :create]
before_action :move_to_index, except: [:index, :show]
before_action :contributor_confirmation, only: [:edit, :update, :destroy]
  def index
    @prototypes = Prototype.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
    unless @prototype.user_id == current_user.id
      redirect_to root_path
    end
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

 def destroy
    if @prototype.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end 
 end
 



  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def new
    @prototype = Prototype.new
    if @prototype.new(prototype_params)
      redirect_to prototype_path(@prototype.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
    
  end
  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
  def contributor_confirmation
    @prototype = Prototype.find(params[:id])
    redirect_to root_path unless current_user == @prototype.user  
  

end
