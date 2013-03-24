# -*- encoding : utf-8 -*-
class Import < Thor
  require './config/environment'
  require 'smarter_csv'
  
  desc "clear", "clear csv data from csv file"
  def clear
      Server.delete_all
      Lparstat.delete_all
      Healthcheck.delete_all
      AixPort.delete_all
      AixPath.delete_all
      Software.delete_all
      SoftwareDeployment.delete_all
  end
 
  desc "san_csv", "upload switch ports from csv file"
  def san_csv(filename)
  end
  
  desc "fw_csv", "upload firmware recommended version from csv file"
  def fw_csv(filename)
      total_chunks = SmarterCSV.process(filename, :chunk_size => 500, :col_sep => ",") do |chunk|
      SwitchPort.transaction do
        chunk.each do |entry|
          fw = Firmware.new
          fw.model=entry[:model]
          fw.recommended = entry[:recommended_version]
          begin
            fw.save!
          rescue Exception => e
            puts "ERROR: unable to save firmware : #{e.message}"
            puts fw.inspect
          end 
        end
      end
    end        
  end 

  desc "aix_csv", "upload aix servers from csv file"
  def aix_csv(filename, version)
  end
end



