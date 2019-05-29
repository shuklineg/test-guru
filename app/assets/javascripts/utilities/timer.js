document.addEventListener('turbolinks:load', function(){
  var timerTag = document.querySelector('#passage-timer')

  if (timerTag) { startTimer(timerTag) }
})

function startTimer(timerTag) {
  var timeLeft = timerTag.dataset.timeLeft
  var timeTotal = timerTag.dataset.timeTotal
  var startTime = (new Date()).getTime()/1000
  setTimeout(function update() {
    var delta = (new Date()).getTime()/1000 - startTime
    var value = Math.max(timeLeft - delta, 0)
    updateTimer(value, timeTotal)
    value > 0 ? setTimeout(update, 500) : setTimeout(submitForm, 1000)
  }, 500)
}

function secondsInTimeString(seconds) {
  var date = new Date(null)
  date.setSeconds(seconds)
  return date.toISOString().substr(11, 8)
}

function updateTimer(value, total) {
  var progressBarTag = document.querySelector('#timer-progress-bar')
  var timerValueTag = document.querySelector('#timer-value')
  if (progressBarTag) { progressBarTag.style.width = parseInt(value/total*100) + '%' }
  if (timerValueTag) { timerValueTag.innerText = secondsInTimeString(value) }
}

function submitForm() {
  var formTag = document.querySelector('#test-passage-form')
  if (formTag) { formTag.submit() }
}
