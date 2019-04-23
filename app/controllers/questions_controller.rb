class QuestionsController < ApplicationController
  before_action :find_question, only: %i[show destroy]
  before_action :find_test, only: %i[index new create]
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_record_not_found

  def index
    @questions = @test.questions
  end

  def show; end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to test_questions_path(test_id: @question.test_id)
    else
      render :new
    end
  end

  def new
    @question = Question.new(test: @test)
  end

  def destroy
    @question.destroy
    redirect_to test_questions_path(test_id: @question.test_id)
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
