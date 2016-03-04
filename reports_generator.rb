require 'erb'

module Snapshot
  class ReportsGenerator
    def generate

      screens_path = "./screenshots"

      puts "screens_path======#{screens_path}"

      @title = "screenshot report"
      @data = {}

      Dir["#{screens_path}/*"].sort.each do |language_path|
        language = File.basename(language_path)
        Dir[File.join(language_path, '*')].sort.each do |screenshot|
                @data[language] ||= {}
                @data[language][screenshot] ||= []

                resulting_path = File.join('.', language, File.basename(screenshot))
                puts "--------resulting_path = #{resulting_path}"
                @data[language][screenshot] << resulting_path
            end
      end

      html_path = File.join("./", "page.html.erb")
      html = ERB.new(File.read(html_path)).result(binding) # http://www.rrn.dk/rubys-erb-templating-system

      export_path = "#{screens_path}/screenshots.html"
      File.write(export_path, html)

      export_path = File.expand_path(export_path)
      system("open '#{export_path}'")
    end

  end
end
