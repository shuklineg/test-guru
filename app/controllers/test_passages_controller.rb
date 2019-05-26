class TestPassagesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_test_passage, only: %i[gist show update result]

  def show; end

  def result; end

  def gist
    servise = GistQuestionService.new(@test_passage.current_question)
    servise.call

    flash_options = if servise.success?
                      current_user.gists.create(
                        question: @test_passage.current_question,
                        gistid: servise.response.id
                      )
                      { notice: t('.success', url: (helpers.link_to 'Gist', servise.response.html_url, target: '_blank')) }
                    else
                      { alert: t('.failure') }
                    end

    redirect_to @test_passage, flash_options
  end

  def update
    @test_passage.accept!(params[:answer_ids] || [])

    if @test_passage.completed?
      TestsMailer.completed_test(@test_passage).deliver_now
      Badge.reward!(@test_passage)
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  private

  def find_test_passage
    @test_passage = TestPassage.find(params[:id])
  end
end
