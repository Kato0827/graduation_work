# frozen_string_literal: true

class StonesController < ApplicationController
  before_action :set_stone, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :authorize_user!, only: %i[edit update destroy]

  def index
    @stones = Stone.includes(:user)
  end

  def show
  end

  def new
    @stone = Stone.new
  end

  def create
    @stone = current_user.stones.build(stone_params)
    if @stone.save
      redirect_to stones_path notice: '排石記録を作成しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @stone.update(stone_params)
      redirect_to @stone, notice: '排石記録を更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @stone.destroy!
    redirect_to stones_path, notice: '掲示板を削除しました', status: :see_other
  end

  private

  def set_stone
    @stone = Stone.find(params[:id])
  end

  def authorize_user!
    unless @stone.user == current_user
      redirect_to stones_path, alert: '権限がありません'
    end
  end

  def stone_params
    params.require(:stone).permit(:title, :body, :stone_size, :record_date)
  end
end
