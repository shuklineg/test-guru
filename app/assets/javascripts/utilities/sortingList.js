document.addEventListener('turbolinks:load', function(){
  var control = document.querySelector('.sort-by')

  control.addEventListener('click', sortListBy) 
})

function sortListBy(){
  sortBy = this.dataset.sortBy

  function compareNodesAsc(row1, row2){
    var text1 = row1.querySelector(sortBy).textContent
    var text2 = row2.querySelector(sortBy).textContent
  
    if (text1 < text2) { return -1 }
    if (text1 > text2) { return 1 }
    return 0
  }
  
  function compareNodesDesc(row1, row2){
    var text1 = row1.querySelector(sortBy).textContent
    var text2 = row2.querySelector(sortBy).textContent
  
    if (text1 < text2) { return 1 }
    if (text1 > text2) { return -1 }
    return 0
  }

  var sortableList = document.querySelector(this.dataset.sortTarget)

  // NodeList
  // https://developer.mozilla.org/ru/docs/web/API/NodeList
  var nodes = sortableList.querySelectorAll(this.dataset.sortElements)
  var sortedNodes = []
  
  for (var i = 0; i < nodes.length; i++){
    sortedNodes.push(nodes[i])
  }

  var arrow_up = this.querySelector('.octicon-arrow-up')
  var arrow_down = this.querySelector('.octicon-arrow-down')

  if (arrow_up.classList.contains('hide')) {
    arrow_up.classList.remove('hide')
    arrow_down.classList.add('hide')
    sortedNodes.sort(compareNodesAsc)
  } else {
    arrow_up.classList.add('hide')
    arrow_down.classList.remove('hide')
    sortedNodes.sort(compareNodesDesc)
  }

  var sortedList = document.createElement(sortableList.tagName)

  sortedList.classList = sortableList.classList

  for (var i = 0; i < sortedNodes.length; i++) {
    sortedList.appendChild(sortedNodes[i])
  }

  sortableList.parentNode.replaceChild(sortedList, sortableList)
}
