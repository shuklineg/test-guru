class Admin::TestsController < Admin::BaseController
  before_action :find_test, only: %i[show edit update update_inline destroy start]
  before_action :find_tests, only: %i[index update_inline]
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_record_not_found

  def index; end

  def show; end

  def new
    @test = Test.new
  end

  def edit; end

  def create
    @test = Test.new(test_params)
    @test.author = current_user

    if @test.save
      redirect_to admin_tests_path
    else
      render :new
    end
  end

  def update
    if @test.update(test_params)
      redirect_to admin_tests_path
    else
      render :edit
    end
  end

  def update_inline
    if @test.update(test_params)
      redirect_to admin_tests_path
    else
      render :index
    end
  end

  def destroy
    @test.destroy
    redirect_to admin_tests_path
  end

  def start
    if @test.active?
      current_user.tests.push(@test)
      redirect_to current_user.test_passage(@test)
    else
      redirect_to admin_tests_path
    end
  end

  private

  def find_test
    @test = Test.find(params[:id])
  end

  def find_tests
    @tests = Test.all
  end

  def test_params
    params.require(:test).permit(:title, :level, :category_id, :timer_in_minutes)
  end

  def rescue_with_record_not_found
    render plain: I18n.t('record_not_found')
  end
end
