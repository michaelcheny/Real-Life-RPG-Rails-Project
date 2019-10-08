# Notes for Rails project


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