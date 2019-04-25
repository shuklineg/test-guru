class TestsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_record_not_found

  def index
    @tests = Test.all
  end

  def show
    @test = Test.find(params[:id])
  end

  private

  def rescue_with_record_not_found
    render plain: I18n.t('record_not_found')
  end
end
