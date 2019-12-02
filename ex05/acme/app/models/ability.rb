# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)

    # grâce à gem Rolify, on cherche les rôles de l'utilisateur
    if user.has_role? :admin
      # Et là, on lui donne les permissions souhaitées
      can :manage, :all
      if user.admin?
        can :access, :rails_admin   # grant access to rails_admin
        can :read, :dashboard       # grant access to the dashboard
      end
    elsif user.has_role? :mod
      can :manage, [Brand, Product]
    else
      can %i[read add remove remove_all checkout], Product
      can :read, Brand
      can :read, User
      can :manage, [Cart, CartItem]
    end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
