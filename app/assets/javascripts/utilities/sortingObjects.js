// Функция сортировки произвольных объектов
//
// sortingObjects(options)
//
// где options объект содержащий следующие опции:
//    targetSelector - селектор объекта содержащий список объектов для сортировки
//    elmSelector - селектор сортируемых объектов
//    control - объект содержащий опции управления
//      selector - селектор элемента управления
//      orderBy - селектор элемента по которому будет производиться сортировка
//      controlGroup - селектор для группировки элементов управления, не обязательный параметр
//      event - событие обрабатываемое элементом управления, не обязательный параметр (по умолчанию 'click')

function sortingObjects(options){
  var controlElement = document.querySelector(options.control.selector)
  if (controlElement) { controlElement.addEventListener(options.control.event || 'click', function() {
    var target = document.querySelector(options.targetSelector)
    var nodes = target.querySelectorAll(options.elmSelector)
    var sortedObjects = []
    var sortAsc = !this.classList.contains('control-sorted-asc')

    if (options.control.controlGroup) {
      var controls = document.querySelectorAll(options.control.controlGroup)
      for (var i = 0; i < controls.length; i++) {
        if (controls[i] != this) {
          controls[i].classList.remove('control-sorted-asc')
          controls[i].classList.remove('control-sorted-desc')
        }
      }
    }

    for (var i = 0; i < nodes.length; i++) { sortedObjects.push(nodes[i]) }

    sortedObjects.sort(function(obj1, obj2) {
      var text1 = obj1.querySelector(options.control.orderBy).textContent.trim()
      var text2 = obj2.querySelector(options.control.orderBy).textContent.trim()
    
      if (text1 < text2) { return sortAsc ? -1 : 1 }
      if (text1 > text2) { return sortAsc ? 1 : -1 }
      return 0
    })

    var sortedElement = target.cloneNode()

    for (var i = 0; i < sortedObjects.length; i++) { sortedElement.appendChild(sortedObjects[i]) }

    target.parentNode.replaceChild(sortedElement, target)
    this.classList.toggle('control-sorted-asc', sortAsc)
    this.classList.toggle('control-sorted-desc', !sortAsc)
  })}
}
