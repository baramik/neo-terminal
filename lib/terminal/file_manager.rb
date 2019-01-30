require 'zip'

module Terminal
  class FileManager
    def self.save(source, content)
      File.open(File.join('tmp', "#{ source }.data"), 'w') do |file|
        file.puts content
      end
    end

    def self.unzip(source_name)
      Dir.mkdir "tmp/#{ source_name }"
      Zip::File.open("tmp/#{ source_name }.data") do |zip_file|
        data_entries = zip_file.glob('{sentinels,sniffers,loopholes}/*.{csv,json}')
        data_entries.each do |entry|
          entry.extract("tmp/#{entry.name}")
        end
      end
    end

    def self.csv_to_hash(path, filename)
      file = File.open("#{path}/#{filename}", 'r:bom|utf-8')
      data = clean(file.read)
      csv = CSV.parse(data, { headers: true })
      csv.map(&:to_h)
    end
  
    private
  
    def self.clean(content)
      content.gsub(/\"/, "").gsub(" ", "")
    end
  end 
end