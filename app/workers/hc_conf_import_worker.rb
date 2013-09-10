require "clockwork"
require "sanitize"

class HcConfImportWorker
  include Sidekiq::Worker

  def hcm_conf_json(filename)
      f=File.open(filename, 'r')
      json = JSON.load(f)
      f.close()

      json['CONFIGS'].each do |x|
        puts x['SERVER']
        srv = Srv.find_or_create_by_name(:name => x['SERVER'])
        if srv.customer.nil?
          srv.customer=json['CUSTOMER']
        end

        x['RESULTS'].each do |y|
            conf = srv.server_attributes.select{|h| h.name==y['PLUG']}.first
            if conf.nil?
              srv.build_server_attributes.build(:name=>y['PLUG'], :description=>y['DESCRIPTION'], :output=>y['OUTPUT'], :return_code=>y['CODE'], :conf_errors=>'', :category => "hcm")
            else
              conf.update_attributes( :description=>y['DESCRIPTION'], :output=>y['OUTPUT'], :return_code=>y['CODE'].to_i, :conf_errors=>'')
            end

        end
        begin
          srv.save!
        rescue Exception => e
            puts "ERROR: unable to save SRV : #{e.message}"
        end
      end
    end


  def perform
    puts Rails.root
    new_path=Rails.root.join('import','new','conf').to_s
    done_path=Rails.root.join('import','imported','conf').to_s
    files = Dir.entries(new_path).select{|x| x.end_with?("json")}
    files.each do |x|

    hcm_conf_json([new_path,x].join('/'))
    File.rename([new_path,x].join('/'), [done_path,x+Time.new.to_formatted_s(:number)].join('/'))
    end
  end

end
