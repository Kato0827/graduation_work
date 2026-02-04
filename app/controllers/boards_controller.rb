# frozen_string_literal: true

class BoardsController < ApplicationController
  before_action :set_board, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :authorize_user!, only: %i[edit update destroy]

  def index
    @boards = Board.includes(:user)
  end

  def show
  end

  def new
    @board = Board.new
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to boards_path, notice: '掲示板を作成しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @board.update(board_params)
      redirect_to @board, notice: '掲示板を更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @board.destroy!
    redirect_to boards_path, notice: '掲示板を削除しました', status: :see_other
  end

  private

  def set_board
    @board = Board.find(params[:id])
  end

  def authorize_user!
    unless @board.user == current_user
      redirect_to boards_path, alert: '権限がありません'
    end
  end

  def board_params
    params.require(:board).permit(:title, :body)
  end
end