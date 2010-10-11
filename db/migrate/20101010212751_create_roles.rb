class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
    create_table :role_assignments, :id => false do |t|
      t.references :user, :role
      
      t.timestamps
    end
  end

  def self.down
    drop_table :roles
    drop_table :role_assignments
  end
end
