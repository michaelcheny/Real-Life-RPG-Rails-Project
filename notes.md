# Notes for Rails project

leveling formula




# backups

<div class="row">
  <div class="col-sm-6">
    <div class="card">
      <div class="card-body">

        <h3 class="card-header">Most Recent Incomplete Tasks</h3>
        <p class="card-text"><%= render 'tasks/incomplete_tasks', tasks: @user.tasks.last_five %></p>
      
      </div>
    </div>
  </div>

  <div class="col-sm-6">
    <div class="card">
      <div class="card-body">

        <h3 class="card-header">Most Recent Completed Tasks</h3>
        <p class="card-text"><%= render 'tasks/completed_tasks', tasks: @user.tasks.last_five %></p>
      
      </div>
    </div>
  </div>
</div>
 



## tables


##current

User
-has_many skills
-has_many tasks
-has_many habits, through tasks
-has_many daily_goals, through tasks
-has_many todos, through tasks
  :gold
  :experience_pts

Skill
-belongs_to user
  :intelligence
  : 

  m = User.first
  m.dexterity.level

Tasks
-belongs_to user
-belongs_to habit
-belongs_to daily_goal
-belongs_to todo
  :completed, dafaults: false

Habit
-has_many tasks
-has_many users, through tasks
  :name
  :description
  :completion_points

Daily_goal
-has_many tasks
-has_many users, through tasks
  :name
  :description
  :completion_points

Todo
-has_many tasks
-has_many users, through tasks
  :name
  :description
  :completion_points







User 
has many user_skills
has many skills through user-skills
has many user_tasks
has many tasks through user_tasks

user_skills
belongs to user
belings to skills
  (premade skills only)
  :experience
  :level
  

Skills
has many userskills
has many useres through userskills
  (premade skills only)
  :intelligence
  :athleticism
  :leadership
  :laziness
  :cooking
  :


user_task
belongs to user
belings to skills
status

task
has many user skills
has many users through userskills
  :name
  :desc
  :difficulty_level
  :priority_level


task-skills
belongs to tsak
belonfs to skill
  :completion_pts
  :duration




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