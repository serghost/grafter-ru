class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      if user.admin?
        can :manage, :all
      else
        can :edit, Price
        can :edit, Review do |review|
          review.user_id == user.id
        end
        can :destroy, Review do |review|
          review.user_id == user.id
        end
      end
    end

    can :read, :all
  end
end
