authorization do
  role :super_admin do
    has_permission_on :users, :to => :manage
  end
  role :guest do
    has_permission_on :users, :to => :read
    has_permission_on :users, :to => [:create, :update, :destroy] do
      if_attribute :id => is {user.id}
    end
  end
  
end

privileges do
  privilege :manage do
    includes :create, :read, :update, :destroy
  end
end