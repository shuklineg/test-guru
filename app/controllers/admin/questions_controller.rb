class Admin::QuestionsController < Admin::BaseController
  before_action :find_question, only: %i[show destroy update edit]
  before_action :find_test, only: %i[new create]
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_record_not_found

  def show; end

  def edit; end

  def create
    @question = @test.questions.new(question_params)
    if @question.save
      redirect_to admin_test_path(@test)
    else
      render :new
    end
  end

  def new
    @question = @test.questions.new
  end

  def update
    if @question.update(question_params)
      redirect_to admin_test_path(@question.test)
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to admin_test_path(@question.test)
  end

  private

  def find_question
    @question = Question.find(params[:id])
  end

  def find_test
    @test = Test.find(params[:test_id])
  end

  def question_params
    params.require(:question).permit(:body, :test_id)
  end

  def rescue_with_record_not_found
    render plain: I18n.t('record_not_found')
  end
end
