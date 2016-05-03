# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

books = Book.create([{question: 'Do you want to read fiction, non-fiction, or a biography?'}, {question: "What kind of genre are you interested in?"}, {question: "What topic are you wanting to read about?"}])
