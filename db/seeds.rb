# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
def qlup
  10.times do |i|
    p "changing chapter #{i}"
    ql = Question.where(chapter:i).order(:created_at)
     counter = 0 
     ql.all.each{|q| q.update_attribute(:index_number, q.chapter.to_s + ((counter+=1)>9 ? counter.to_s : "0#{counter}"))}
     p "#{counter} index updated"
  end 
end

qlup
