class ServerImportWorker
  include Sidekiq::Worker

  def process_server(filename)
      f=File.open(filename, 'r')
    end


  def perform
    puts Rails.root
    new_path=Rails.root.join('import','server','new').to_s
    done_path=Rails.root.join('import','server','imported').to_s
    files = Dir.entries(new_path).select{|x| x.end_with?("json")}
    files.each do |x|
      process_server([new_path,x].join('/'))
      File.rename([new_path,x].join('/'), [done_path,x+Time.new.to_s.gsub(' ','-')].join('/'))
    end
  end

end
