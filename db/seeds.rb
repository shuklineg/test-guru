# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.create(
  email: 'adm.guru.2019@gmail.com',
  password: 'change_me',
  first_name: 'Admin',
  last_name: 'Guru',
  type: 'Admin'
)

category = Category.create(title: 'Язык программирования Ruby')

tests = Test.create([
  { category: category, title: 'История Ruby', author: admin, level: 1 },
  { category: category, title: 'Основы языка Ruby', author: admin, level: 2 }
])

questions = Question.create([
  { test: tests[0], body: 'В каком году был опубликован Ruby?' },
  { test: tests[0], body: 'Кто был автором языка Ruby?' },
  { test: tests[0], body: 'Ruby это …' },
  { test: tests[0], body: 'Объектами в языке Ruby являются …' },
  { test: tests[1], body: 'В какую синтаксическую конструкцию нужно обернуть код что бы объединить его в блок?' },
  { test: tests[1], body: 'Объявление класса в Ruby.' },
  { test: tests[1], body: 'Как объявить атрибут класса только для чтения' }
])

Answer.create([
  { question: questions[0], body: '1999 году', correct: false },
  { question: questions[0], body: '1993 году', correct: false },
  { question: questions[0], body: '1995 году', correct: true },
  { question: questions[1], body: 'Линус Торвальдс', correct: false },
  { question: questions[1], body: 'Юкихиро Мацумото', correct: true },
  { question: questions[1], body: 'Стивен Возняк', correct: false },
  { question: questions[2], body: 'динамический, интерпретируемый, высокоуровневый язык программирования', correct: true },
  { question: questions[2], body: 'статический, интерпретируемый, высокоуровневый язык программирования', correct: false },
  { question: questions[2], body: 'статический, компилируемый, низкоуровневый язык программирования', correct: false },
  { question: questions[3], body: 'переменные созданные как экземпляры классов', correct: false },
  { question: questions[3], body: 'все переменные кроме примитивных типов данных', correct: false },
  { question: questions[3], body: 'все переменные являются объектами', correct: true },
  { question: questions[4], body: '{…}', correct: true },
  { question: questions[4], body: 'begin ... end', correct: false },
  { question: questions[4], body: 'do … end', correct: true },
  { question: questions[5], body: 'var MyClass; end', correct: false },
  { question: questions[5], body: 'MyClass class; end', correct: false },
  { question: questions[5], body: 'class MyClass; end', correct: true },
  { question: questions[6], body: 'attribute_accessor :my_attr', correct: false },
  { question: questions[6], body: 'attribute_reader :my_attr', correct: true },
  { question: questions[6], body: 'attrigute_writer :my_attr', correct: false }
])

category = Category.create(title: 'Ruby On Rails')

tests = Test.create([
  { category: category, title: 'Ruby On Rails', author: admin, level: 1 }
])

questions = Question.create([
  { test: tests[0], body: 'Ruby On Rails это …' },
  { test: tests[0], body: 'Как расшифровывается MVC?' },
  { test: tests[0], body: 'Ruby On Rails был выпущен в …' },
  { test: tests[0], body: 'Что означает аббревиатура REST?' }
])

Answer.create([
  { question: questions[0], body: 'фреймворк, написанный на языке Ruby, реализующий архитектурный шаблон MVC для веб-приложений', correct: true },
  { question: questions[0], body: 'библиотека отвечающая за преставление расширений для языка Ruby', correct: false },
  { question: questions[0], body: 'библиотека реализующая технологию ORM(Object Role Model), которая связывает базы данных с концепциями объектно-ориентированных языков программирования', correct: false },
  { question: questions[1], body: 'Model-View-Connection', correct: false },
  { question: questions[1], body: 'Model-View-Controller', correct: true },
  { question: questions[1], body: 'Model-Variable-Controller', correct: false },
  { question: questions[2], body: '1999 году', correct: false },
  { question: questions[2], body: '2001 году', correct: false },
  { question: questions[2], body: '2004 году', correct: true },
  { question: questions[3], body: 'Representational State Transfer — передача состояния представления', correct: true },
  { question: questions[3], body: 'Request State Transfer — запрос состояния представления', correct: false }
])

category = Category.create(title: 'HTML')

tests = Test.create([
  { category: category, title: 'HTML5', author: admin, level: 2 }
])

questions = Question.create([
  { test: tests[0], body: 'Как правильно объявить doctype в HTML5?' },
  { test: tests[0], body: 'Какой тег используется для нумерованного списка?' },
  { test: tests[0], body: 'Как задаются пользовательский аттрибут с именем «my-attr» и значением «my-value» в теге div?' },
  { test: tests[0], body: 'Какой аттрибут задаёт обработчик события для одиночного клика мышки?' }
])

Answer.create([
  { question: questions[0], body: '<!DOCTYPE html>', correct: true },
  { question: questions[0], body: '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">', correct: false },
  { question: questions[0], body: '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">', correct: false },
  { question: questions[1], body: '<ul>', correct: false },
  { question: questions[1], body: '<ol>', correct: true },
  { question: questions[1], body: '<u>', correct: false },
  { question: questions[2], body: '<div data=“my-attr=my-value“>...</div>', correct: false },
  { question: questions[2], body: '<div data-my-attr=“my-value“>...</div>', correct: true },
  { question: questions[2], body: '<div my-attr=“my-value“></div>', correct: false },
  { question: questions[3], body: 'onclick', correct: true },
  { question: questions[3], body: 'ondblclick', correct: false },
  { question: questions[3], body: 'click', correct: false }
])

category = Category.create(title: 'JavaScript')

tests = Test.create([
  { category: category, title: 'Основы JavaScript', author: admin, level: 2 }
])

questions = Question.create([
  { test: tests[0], body: 'Как расшифровывается аббревиатура DOM?' },
  { test: tests[0], body: 'Как объявить функцию?' },
  { test: tests[0], body: 'Как объявить булеву переменную со значением true?' },
  { test: tests[0], body: 'Как вывести окно с сообщением пользователю?' }
])

Answer.create([
  { question: questions[0], body: 'Document Object Model - «объектная модель документа»', correct: true },
  { question: questions[0], body: 'Document Oriented Model - «oриентированная на документ модель»', correct: false },
  { question: questions[0], body: 'Document Operating Model - «операционная модель документа»', correct: false },
  { question: questions[1], body: 'procedure myFunction begin … end', correct: false },
  { question: questions[1], body: 'function myFunction() {…}', correct: true },
  { question: questions[1], body: 'myFunction(…)', correct: false },
  { question: questions[2], body: 'Boolean val = true', correct: false },
  { question: questions[2], body: 'bool val = true', correct: false },
  { question: questions[2], body: 'var val = true', correct: true },
  { question: questions[3], body: 'message(“Текст сообщения“)', correct: false },
  { question: questions[3], body: 'alert(“Текст сообщения“)', correct: true },
  { question: questions[3], body: 'console.log(“Текст сообщения“)', correct: false }
])
