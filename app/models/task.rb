class Task < ActiveRecord::Base
  before_save :default_values
  
  belongs_to :list
  
  scope :done, :conditions => "done_at IS NOT NULL"
  scope :pending, :conditions => { :done_at => nil }
  
  # Encapsulating done switch
  def done
    done?
  end
  def done?
    done_at != nil
  end
  
  def done=(value)
    if value and value != '0'
      self.done_at = DateTime.now
    else
      self.done_at = nil
    end
  end
  
  def done!
    self.done = true
  end
  
  def toggle_done
    self.done = ! self.done?
  end
  
  def status
    if done?
      "done"
    else
      "pending"
    end
  end
  
  def to_s
    text
  end
  
  private
  
  def default_values
  end
  
end
