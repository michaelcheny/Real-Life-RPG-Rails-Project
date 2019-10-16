module UsersHelper

  def populate_skills_if_empty(user)
    if user.skills.empty?
      Skill.all.each do |s|
        user.skills << s
      end
    end
  end


  def sort_by_total_exp(users)
    users.sort_by{|u| u.total_exp_pts}.reverse
  end

end
