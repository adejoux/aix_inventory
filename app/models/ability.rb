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

       # if user.role == "editor"
       #   can :manage, Firmware
       #   can :manage, AixAlert
       #   can :manage, SanAlert
       # end

       if user.role == "editor" or user.role == "viewer"
         can :manage, Report
         can :show, Server
         can :load_tab, Server
         can :index, Server
         can :customer, Server
         can :render_stats, Server
         can :update, User, :id => user.id
       end
  end
end
