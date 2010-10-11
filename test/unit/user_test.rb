require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "token generation" do
    u = User.first
    role = Role.first
    role_sym = role.name.underscore.to_sym
    u.roles << role
    assert u.role_symbols.include?(role_sym), "Testrole symbol, #{role_sym}, not in user role symbol list: #{u.role_symbols}"
  end
end
