##
## This utility makes it easy to convert the properties from the default properties file to use confd properties
##

def isCommentOrBlank?(line) 
  return line.start_with?('#') || line.strip.empty?()
end

file_to_update="confd/templates/janitor.properties.tmpl"

File.open("#{file_to_update}.new",'w') do |file|
 lines = File.open(file_to_update).read
 lines.each_line do |line|

    optionalProperty=/^#([^=]+)=(.+)$/

    line.match(optionalProperty) do |m|
	name=m[1].strip
	value=m[2].strip
	env_property=name.gsub('.','/').downcase

	file.write("{{if exists \"/#{env_property}\" -}}\n")
        new_line="#{name} = {{getv \"/#{env_property}\" \"#{value}\"}}\n"
	file.write(new_line)
	file.write("{{end -}}\n")
    end

    if ( isCommentOrBlank?(line)  ) then
	# Don't process comments
	file.write(line)
    else

      name_value = line.split('=')
      name=name_value[0].strip
      value=name_value[1].strip

      env_property=name.gsub('.','/').downcase
      new_line="#{name} = {{getv \"/#{env_property}\" \"#{value}\"}}\n"
      file.write(new_line)
    end
  end
end


