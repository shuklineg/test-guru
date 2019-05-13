document.addEventListener('turbolinks:load', function(){
  $('.resource-errors').each(function() {
    formInlineHandler(this.dataset.resourceId)
  })

  $('.form-inline-link').on('click', function(event){
    event.preventDefault()

    var testId = this.dataset.testId

    if ($(this).hasClass('form-inline-cancel')) {
      var text = $('.test-title[data-test-id="' + testId + '"]').text()
      $('.form-inline[data-test-id="' + testId + '"] input[type="text"]').val(text)
    }

    formInlineHandler(testId)
  })
})

function formInlineHandler(testId) {
  $('.test-title[data-test-id="' + testId + '"]').toggle()
  $('.form-inline[data-test-id="' + testId + '"]').toggle()
  $('.form-inline-link[data-test-id="' + testId + '"]').toggle()
}
