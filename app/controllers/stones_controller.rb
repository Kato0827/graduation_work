# frozen_string_literal: true

class StonesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @stones = Stone.includes(:user)
  end

  def show
    @stone = Stone.find(params[:id])
  end

  def new
    @stone = Stone.new
  end

  def create
    @stone = current_user.stones.build(stone_params)
    if @stone.save
      redirect_to stones_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def stone_params
    params.require(:stone).permit(:title, :body, :stone_size, :record_date)
  end
end
