authorization do
  
  role :guest do
    has_permission_on :users, :to => :create
  end
  
  role :user do
    
    has_permission_on :lists, :to => :manage do
      if_attribute :user => is { user }
    end
    
    has_permission_on :tasks, :to => :manage do
      if_attribute :list => { :user => is { user } }
    end
    
  end
  
  role :admin do
    
    # Meta
    has_permission_on :authorization_rules, :to => :read
    has_permission_on :authorization_usages, :to => :read
    
    # Everything
    has_permission_on [:lists, :tasks, :users], :to => :manage
    
  end
  
end

privileges do
  # Default privilege hierarchies to facilitate RESTful Rails apps
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read,   :includes => [:index, :show, :search]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end
