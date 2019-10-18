# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# skills = [
#   "Health",
#   "Strength",
#   "Agility",
#   "Cardio",
#   "Cooking",
#   "Intelligence",
#   "Creativity",
#   "Nature",
#   "Exploration",
#   "Social"
# ]

# skill_description = [
#   "The overall health of your body. (example: not getting sick because you are healthy)",
#   "The quality or state of being strong. The capacity for exertion or endurance. (example: pulling a truck with your teeth)",
#   "The quality or state of being agile. Dexterity. (example: dodging a ball while running up a wall)",
#   "You cardiovascular endurance. (example: being able to run a marathon)",
#   "The ability to cook a delicous meal. (example: deboning a live chicken and creating a 3 course meal with chicken)",
#   "The ability to learn or understand or to deal with new or trying situations. (example: completing labs on learn.co, or not being tricked into a scam by someone)",
#   "The ability to create, or the quality of being creative. (example: inventing a new gadget that benefits mankind)",
#   "The ability to be one with mothernature. (example: dog whisperer, bees welcome you to steal all their honey)",
#   "The ability to travel over new territory for adventures or discovery. (example: visiting a new city and discovering new culture there)",
#   "The ability to interact and act appropriately in given social contexts. (example: communication and friendship making skills.)"
# ]

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
  password_confirmation: "password"
  )  

Skill.all.each{ |skill| m.skills << skill }
Skill.all.each{ |skill| d.skills << skill }


