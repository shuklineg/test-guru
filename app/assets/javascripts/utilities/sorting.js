document.addEventListener('turbolinks:load', function() {
  var control = document.querySelector('.sort-by-title')

  if (control) { control.addEventListener('click', sortRowsByTitle) }

  // Сортировка произвольных объектов см. sortingObjects.js
  sortingObjects({
    targetSelector: 'div#user-tests-list',
    elmSelector: 'div.test-list-item',
    control: { selector: 'div#sort-by-title', orderBy: 'div.item-title', controlGroup: '.tests-order'}
  })
  sortingObjects({
    targetSelector: 'div#user-tests-list',
    elmSelector: 'div.test-list-item',
    control: { selector: 'div#sort-by-level', orderBy: 'span.item-level', controlGroup: '.tests-order'}
  })
  sortingObjects({
    targetSelector: 'div#user-tests-list',
    elmSelector: 'div.test-list-item',
    control: { selector: 'div#sort-by-category', orderBy: 'div.item-category', controlGroup: '.tests-order'}
  })
})

function sortRowsByTitle(){
  var tableElement = document.querySelector('tbody')

  // NodeList
  // https://developer.mozilla.org/ru/docs/web/API/NodeList
  var rows = tableElement.querySelectorAll('tr')
  var sortedRows = []
  
  for (var i = 0; i < rows.length; i++){
    sortedRows.push(rows[i])
  }

  var arrow_up = this.querySelector('.octicon-arrow-up')
  var arrow_down = this.querySelector('.octicon-arrow-down')

  if (arrow_up.classList.contains('hide')) {
    arrow_up.classList.remove('hide')
    arrow_down.classList.add('hide')
    sortedRows.sort(compareRowsAsc)
  } else {
    arrow_up.classList.add('hide')
    arrow_down.classList.remove('hide')
    sortedRows.sort(compareRowsDesc)
  }

  var sortedTable = document.createElement(tableElement.tagName)

  for (var i = 0; i < sortedRows.length; i++) {
    sortedTable.appendChild(sortedRows[i])
  }

  tableElement.parentNode.replaceChild(sortedTable, tableElement)
}

function compareRowsAsc(row1, row2){
  var text1 = row1.querySelector('td').textContent.trim()
  var text2 = row2.querySelector('td').textContent.trim()

  if (text1 < text2) { return -1 }
  if (text1 > text2) { return 1 }
  return 0
}

function compareRowsDesc(row1, row2){
  var text1 = row1.querySelector('td').textContent.trim()
  var text2 = row2.querySelector('td').textContent.trim()

  if (text1 < text2) { return 1 }
  if (text1 > text2) { return -1 }
  return 0
}
