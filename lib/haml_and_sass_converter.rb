module HamlAndSassConverter

  def convert_sass_to_css(file_path)
    Dir.glob("#{file_path}/**/*.sass") do |sass_file_path|
      template = File.read(sass_file_path)
      sass_engine = Sass::Engine.new(template)
      output = sass_engine.to_css
      css_file_path = sass_file_path.sub(/source/, "output").gsub(/sass/, "css")
      File.write(css_file_path, output)
    end
  end

  def convert_haml_to_html(file_path)
    Dir.glob("#{file_path}/**/*.haml") do |haml_file_path|
      template = File.read(haml_file_path)
      haml_engine = Haml::Engine.new(template)
      output = haml_engine.render
      http_file_path = haml_file_path.sub(/source/,"output").gsub(/haml/,"html")
      File.write(http_file_path, output)
    end
  end

end
