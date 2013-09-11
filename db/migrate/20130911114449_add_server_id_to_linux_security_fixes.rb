class AddServerIdToLinuxSecurityFixes < ActiveRecord::Migration
  def change
    add_column :linux_security_fixes, :server_id, :integer
  end
end
