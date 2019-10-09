# Notes for Rails project

## tables

User 
has many user_skills
has many skills through user-skills
has many user_tasks
has many tasks through user_tasks

user_skills
belongs to user
belings to skills

Skills
has many userskills
has many useres through userskills


user_task
belongs to user
belings to skills
status

task
has many user skills
has many users through userskills

skills 

task-skills

tasks



## RPG YOUR LIFE TO DO LIST/CALENDER/PLANNER APPPPPPP

USER HAVE LIFE SKILLS (1-99)

USER CAN INCREASE SKILL LEVEL BY DOING STUFF

SKILL LEVEL DEPRECIATES IF USER DOESN'T TRAIN FOR PERIOD OF TIME

example: 
- walking dog +5 cardio, +5 happiness
- cooking dinner for self +5 cooking, +10 survival
- watching tv +10 laziness -10 productivity, +2 intellect
- user can add notes to their task
- settings page to change how much skill gained, etc.



### Has a User model
- User attributes: name, email, password, password_confirmation
- User has many friends through through friendships (self referencial join relationship)
- User can sign up, log in, log out, edit settings, etc.


### Sessions controller
- allows logging in, logging out, (new, create, destroy)

add more here