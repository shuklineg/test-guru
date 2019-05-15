document.addEventListener('turbolinks:load', function(){
  var testCard = document.querySelector('#test-card')
  if (testCard) {
    var current = testCard.dataset.currentQuestionNumber
    var count = testCard.dataset.questionsCount
    var percent = parseInt(current/count*100) + '%'
    var progressBar = document.querySelector('#test-progress-bar')
    progressBar.style.width = percent
    progressBar.innerText = current + '/' + count
  }
})
