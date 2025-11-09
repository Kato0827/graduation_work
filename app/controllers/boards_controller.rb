class BoardsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @boards = Board.includes(:user)
  end
end
