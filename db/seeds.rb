# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.destroy_all

Skill.destroy_all

UserSkill.destroy_all


Skill.create(name: "Health", description: "The overall health of your body. (example: not getting sick because you are healthy)")

Skill.create(name: "Strength", description: "The quality or state of being strong. The capacity for exertion or endurance. (example: pulling a truck with your teeth)")

Skill.create(name: "Agility", description: "The quality or state of being agile. Dexterity. (example: dodging a ball while running up a wall)")

Skill.create(name: "Cardio", description:  "You cardiovascular endurance. (example: being able to run a marathon)")

Skill.create(name: "Cooking", description: "The ability to cook a delicous meal. (example: deboning a live chicken and creating a 3 course meal with chicken)")

Skill.create(name: "Intelligence", description: "The ability to learn or understand or to deal with new or trying situations. (example: completing labs on learn.co, or not being tricked into a scam by someone)")

Skill.create(name: "Creativity", description: "The ability to create, or the quality of being creative. (example: inventing a new gadget that benefits mankind)")

Skill.create(name: "Nature", description: "The ability to be one with mothernature. (example: dog whisperer, bees welcome you to steal all their honey)")

Skill.create(name: "Exploration", description: "The ability to travel over new territory for adventures or discovery. (example: visiting a new city and discovering new culture there)")

Skill.create(name: "Social", description: "The ability to interact and act appropriately in given social contexts. (example: communication and friendship making skills.)")

m = User.create(
  email: "michael@michael.com", 
  username: "Michael", 
  password: "password", 
  password_confirmation: "password"
  )

d = User.create(
  email: "dog@dog.com", 
  username: "Dog", 
  password: "password", 
  password_confirmation: "password",
  master: true
  )  

s = User.create(
  email: "shrimply@pibbles.com", 
  username: "Shrimplypibbles", 
  password: "password", 
  password_confirmation: "password"
  )  

b = User.create(
  email: "bird@person.com", 
  username: "Birdperson", 
  password: "password", 
  password_confirmation: "password"
  ) 

t = User.create(
  email: "scary@terry.com", 
  username: "Scaryterry", 
  password: "password", 
  password_confirmation: "password"
  )  

p = User.create(
  email: "pickle@man.com", 
  username: "Thepickleman", 
  password: "password", 
  password_confirmation: "password"
  )  

  
Skill.all.each{ |skill| m.skills << skill }
Skill.all.each{ |skill| d.skills << skill }
Skill.all.each{ |skill| s.skills << skill }
Skill.all.each{ |skill| b.skills << skill }
Skill.all.each{ |skill| t.skills << skill }
Skill.all.each{ |skill| p.skills << skill }


q = Quest.create(name: "Avoid sweets for 2 days", description: "Cut down on sugar intake, and become a healthy person.", difficulty_level: 10, level_requirement: 10, skill_ids: [1,4,3])
qq = Quest.create(name: "Complete 5 labs in a day", description: "We're on JavaScript already! Holy ****!", difficulty_level: 10, level_requirement: 20, skill_ids: [6,7])
qqq = Quest.create(name: "Lose 3 pounds", description: "Burn off all the weight gained from stress eating during project week.", difficulty_level: 6, level_requirement: 30, skill_ids: [1,3,4])
qqqq = Quest.create(name: "Take 2 Strokes Off My Golf Game", description: "Yeaahhh, can't dooooo.", difficulty_level: 10, level_requirement: 16, skill_ids: [3,8,9])
qqqqq = Quest.create(name: "Get Schwifty!", description: "Save the world from angry heads in the sky.", difficulty_level: 10, level_requirement: 20, skill_ids: [8,9,10])
qqqqqq = Quest.create(name: "Lose 6 pounds", description: "Burn off all the weight from stress eating during bootcamp.", difficulty_level: 7, level_requirement: 40, skill_ids: [1,3,4])
Quest.create(name: "Read a book", description: "Finish a book.", difficulty_level: 4, level_requirement: 13, skill_ids: [6,7])
Quest.create(name: "Prank my neighbor 5 days in a row", description: "Pull a prank on a neighbor everyday for 5 days! Muhahahaha!", difficulty_level: 4, level_requirement: 17, skill_ids: [10,9,7])


m.user_quests.create(quest: q)
m.user_quests.create(quest: qq)


b.user_quests.create(quest: qq)

b.tasks.create(name: "Brush my feathers", description: "Must keep my feathers looking shiny to attract mate.", difficulty_level: 3, priority_level: 10, skill_ids: [1,8,10])

b.tasks.create(name: "Find a mating partner", description: "It is considered a good move in bird culture to find a mate.", difficulty_level: 10, priority_level: 10, skill_ids: [8,9,10])
