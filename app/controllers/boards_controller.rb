# frozen_string_literal: true

class BoardsController < ApplicationController
  before_action :set_board, only: %i[show edit update]
  before_action :authenticate_user!, only: %i[new create edit update]

  def index
    @boards = Board.includes(:user)
  end

  def show
    @board = Board.find(params[:id])
  end

  def new
    @board = Board.new
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to boards_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # 本人以外の編集を禁止
    unless @board.user == current_user
      redirect_to boards_path, alert: '権限がありません'
    end
  end

  def update
    # 本人以外の更新を禁止
    unless @board.user == current_user
      redirect_to boards_path, alert: '権限がありません'
      return
    end

    if @board.update(board_params)
      redirect_to @board, notice: '掲示板を更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_board
    @board = Board.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:title, :body)  # 必要なカラムを追加してください
  end
end
