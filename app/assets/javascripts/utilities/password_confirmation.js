document.addEventListener('turbolinks:load', function() {
  var password = document.querySelector('#user_password')
  var confirm = document.querySelector('#user_password_confirmation')

  if (password && confirm) {   
    var validClass = 'is-valid'
    var invalidClass = 'is-invalid'

    function onInput() {  
      if (password.value && confirm.value) {
        var valid = password.value == confirm.value
        confirm.classList.toggle(invalidClass, !valid)
        confirm.classList.toggle(validClass, valid)
      } else {
        confirm.classList.remove(validClass, invalidClass)
      }
    }
    
    password.addEventListener('input', onInput)
    confirm.addEventListener('input', onInput)
  }
})
