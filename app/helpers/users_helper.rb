module UsersHelper

  def populate_skills(user)
    if user.skills.empty?
      Skill.all.each do |s|
        user.skills << s
      end
    end
  end

end
