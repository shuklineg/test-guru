module TestPassagesHelper
  def correct_percentage(test_passage)
    percentage = test_passage.correct_percentage
    style = 'text-success'
    msg = t('.test_passed')
    unless test_passage.passed?
      style = 'text-danger'
      msg = t('.test_failed')
    end
    "<strong>#{msg} <span class='#{style}'>#{number_to_percentage percentage, precision: 0}</span></strong>".html_safe
  end
end
