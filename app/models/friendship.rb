class Friendship < ActiveRecord::Base
  attr_accessible :user, :friend, :status
  belongs_to :user, :foreign_key =>"actor_id", :primary_key => "actor_id"
  belongs_to :friend, :class_name => "User", :primary_key => "actor_id", :foreign_key => "friendActor_id"
  
  validates_presence_of :friendActor_id, :actor_id
  
  def self.are_friends(user, friend)
    returns false if user == friend
    return true unless find_by_actor_id_and_friendActor_id_and_status(user, friend, "accepted").nil?
    return true unless find_by_actor_id_and_friendActor_id_and_status(friend, user, "accepted").nil?
    false
  end
  
  def self.are_friends_pending(user, friend)
    return false if user == friend
    return true unless find_by_actor_id_and_friendActor_id_and_status(user, friend, "pending").nil?
    return true unless find_by_actor_id_and_friendActor_id_and_status(friend, user, "requested").nil?
    false
  end
  
  def self.request(user, friend)
    return false if are_friends(user, friend)
    return false if user == friend
    f1 = new(:user => user, :friend => friend, :status => "pending")
    f2 = new(:user => friend, :friend => user, :status => "requested")
    transaction do
      f1.save
      f2.save
    end
  end
  
  def self.accepted(user, friend)
    f1 = find_by_actor_id_and_friendActor_id(user.actor_id, friend.actor_id)
    f2 = find_by_actor_id_and_friendActor_id(friend.actor_id, user.actor_id)
    if f1.nil? or f2.nil?
      return false
    else
      transaction do
        f1.update_attributes(:status => "accepted")
        f2.update_attributes(:status => "accepted")
        
      end 
    end
    return true
  end
  
  def self.reject(user,friend)
    f1 = find_by_actor_id_and_friendActor_id(user.actor_id, friend.actor_id)
    f2 = find_by_actor_id_and_friendActor_id(friend.actor_id, user.actor_id)
    if f1.nil? or f2.nil?
      return false
    else
      transaction do
        f1.destroy
        f2.destroy
        return true
        
      end
    end
  end
  
  
end