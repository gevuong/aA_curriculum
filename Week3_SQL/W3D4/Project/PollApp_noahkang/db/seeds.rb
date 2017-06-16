# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Poll.destroy_all
Question.destroy_all
AnswerChoice.destroy_all
Response.destroy_all

users = User.create([{ user_name: 'noah' }, { user_name: 'george' }])

polls = Poll.create([{ title: 'Age', author_id: users.first.id }])

questions = Question.create([{ poll_id: polls.first.id, text: 'What is your age?' }])

answer_choices = AnswerChoice.create([{ question_id: questions.first.id, text: '5'}, { question_id: questions.first.id, text: '15'}, { question_id: questions.first.id, text: '25' }])

responses = Response.create([{ user_id: users.last.id, answer_choice_id: answer_choices.first.id }])
