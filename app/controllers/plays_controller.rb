class PlaysController < ApplicationController
  before_action :find_play, only: [:show, :destroy, :edit, :update]

  def index
    @plays = Play.all.order('created_at DESC')
  end

  def new
    @play = current_user.plays.build
    @categories = Category.all.map { |e|  [e.name, e.id] }
  end

  def edit
    @categories = Category.all.map { |e|  [e.name, e.id] }
  end

  def show
    
  end

  def create
    @play = current_user.plays.build(play_params)
    if @play.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update
    if @play.update(play_params)
      redirect_to @play
    else
      render 'edit'
    end
  end

  def destroy
    if @play.destroy
      redirect_to plays_path
    else
      render 'show'
    end
  end

  private 
    def find_play
      @play = Play.find(params[:id])
    end

    def play_params
      params.require(:play).permit(:title, :description, :director, :category_id)
    end
end
