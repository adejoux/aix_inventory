class CreateLinuxSecurityFixes < ActiveRecord::Migration
  def change
    create_table :linux_security_fixes do |t|
      t.string :name
      t.string :severity
      t.string :rhsa
      t.string :category

      t.timestamps
    end
  end
end
