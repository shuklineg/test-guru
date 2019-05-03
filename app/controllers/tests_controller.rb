class TestsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_test, only: :start
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_record_not_found

  def index
    @tests = Test.all
  end

  def start
    if @test.active?
      current_user.tests.push(@test)
      redirect_to current_user.test_passage(@test)
    else
      redirect_to tests_path
    end
  end

  private

  def find_test
    @test = Test.find(params[:id])
  end

  def rescue_with_record_not_found
    render plain: I18n.t('record_not_found')
  end
end
