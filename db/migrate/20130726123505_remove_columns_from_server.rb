class RemoveColumnsFromServer < ActiveRecord::Migration
  def change
    remove_columns :servers, :install_date
    remove_columns :servers, :sys_model
    remove_columns :servers, :nim
    remove_columns :servers, :sys_serial
    remove_columns :servers, :sys_fwversion
    remove_columns :servers, :global_image
  end
end
