Dir.glob('./lib/*').each do |folder|
  Dir.glob(folder +"/*.rb").each do |file|
    require file
  end
end

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => 'db/quotation.db'
)
