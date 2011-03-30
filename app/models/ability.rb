class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      if user.admin?
        can :manage, :all
      else
        can :edit, Price
        can :edit, University
      end
    end

    can :read, :all
  end
end
