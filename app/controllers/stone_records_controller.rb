# frozen_string_literal: true

class StoneRecordsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @stone_records = StoneRecord.includes(:user)
  end

  def show
    @stone_record = StoneRecord.find(params[:id])
  end

  def new
    @stone_record = StoneRecord.new
  end

  def create
    @stone_record = current_user.stone_records.build(stone_record_params)
    if @stone_record.save
      redirect_to stone_records_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def stone_record_params
    params.require(:stone_record).permit(:title, :body, :stone_size, :record_date)
  end
end
