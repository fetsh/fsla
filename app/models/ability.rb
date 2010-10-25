class Ability
  include CanCan::Ability

  def initialize(user)
  
    user ||= User.new # guest user
      
    if user.role? :admin
      can :manage, :all
    else
      can :create, Task
      can :read, Task do |task|
        task.try(:user) == user
      end
      can :manage, Task do |task|
        task.try(:user) == user
      end
    end
  end
end
