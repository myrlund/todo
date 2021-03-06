require 'bluecloth'

class List < ActiveRecord::Base
  using_access_control
  
  belongs_to :user
  has_many :tasks
  
  def self.active
    List.all.select {|list| list.tasks.pending.length > 0}
  end

  def self.finished
    List.all.select {|list| list.tasks.pending.length == 0}
  end
  
  def progress
    unless self.tasks.empty?
      self.tasks.done.length.to_f / self.tasks.length.to_f
    else
      0
    end
  end

  def to_param
    "#{id}-#{name.urlify}"
  end
  
end
