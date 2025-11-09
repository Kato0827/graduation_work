# frozen_string_literal: true

class BoardsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

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

  private

  def board_params
    params.require(:board).permit(:title, :body)
  end
end
