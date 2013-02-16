# -*- encoding : utf-8 -*-
class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
       user ||= User.new # guest user (not logged in)
       if user.role == "admin"
         can :manage, :all
       end

       if user.role == "editor"
         can :manage, Firmware
         can :manage, AixAlert
         can :manage, SanAlert
       end

       if user.role == "editor" or user.role == "viewer"
         can :read, Server
         can :show, Server
         can :quick_search, Server
         can :general, Server
         can :customer, Server
         can :render_stats, Server
         can :read, SwitchPort
         can :read, Lparstat
         can :san_alerts, SanAlert
         can :aix_alerts, SanAlert
         can :update, User, :id => user.id
       end
  end
end
