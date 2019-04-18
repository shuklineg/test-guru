# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create([
  { email: 'pooh@mail.ru', encrypted_password: Digest::SHA1.hexdigest('12345') },
  { email: 'piglet@yandex.ru', encrypted_password: Digest::SHA1.hexdigest('50 cents') },
  { email: 'tigger@gmail.com', encrypted_password: Digest::SHA1.hexdigest('1q2w3e4r') },
  { email: 'rabbit@gmail.com', encrypted_password: Digest::SHA1.hexdigest('carrot') },
  { email: 'eeyore@mail.com', encrypted_password: Digest::SHA1.hexdigest('111') }
])

categories = Category.create([
  { title: 'Объектно ориентированное программирование' },
  { title: 'SQL' },
  { title: 'Ruby' },
  { title: 'Ruby On Rails' }
])

tests = Test.create([
  { category: categories[0], title: 'Принципы ООП' },
  { category: categories[0], title: 'Объект и класс' },
  { category: categories[1], title: 'Оператор SELECT' },
  { category: categories[2], title: 'Утиная типизация' },
  { category: categories[2], title: 'Блоки' },
  { category: categories[3], title: 'Миграции' },
  { category: categories[3], title: 'ORM' }
])

questions = Question.create([
  { test: tests[0], body: 'Класс является типом данных?' },
  { test: tests[1], body: 'Объект является экземпляром класса?' },
  { test: tests[2], body: 'Что вернет SELECT "Hello, world!"?' },
  { test: tests[3], body: 'Если оно выглядит как утка, плавает как утка и крякает как утка, то это ...' },
  { test: tests[4], body: 'В каких block_given? возвращает true' },
  { test: tests[5], body: 'Зачем нужны миграции?' },
  { test: tests[6], body: 'Что означает аббривиатура ORM?' }
])

Answer.create([
  { question: questions[0], body: 'Да', correct: true},
  { question: questions[1], body: 'Нет', correct: false },
  { question: questions[2], body: 'Вернет выборку из одной строки содержащую "Hello, world!"', correct: true},
  { question: questions[3], body: 'Редкий вид крякающей чайки', correct: false},
  { question: questions[4], body: 'Если функции передан блок', correct: true},
  { question: questions[5], body: 'Для переселения людей', correct: false},
  { question: questions[6], body: 'Объектно-реляционное отображение', correct: true}
])

PassedTest.create([
  { user: users[0], test: tests[0] },
  { user: users[1], test: tests[1] },
  { user: users[2], test: tests[2] },
  { user: users[3], test: tests[3] },
  { user: users[4], test: tests[4] },
  { user: users[0], test: tests[5] },
  { user: users[1], test: tests[6] }
])