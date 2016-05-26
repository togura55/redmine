# Patches Redmine's Issues dynamically.  Adds a default assignee per
# project.
#
# Based heavily on edavis10's stuff-to-do plugin
#
module ScreenshotlinkIssuePatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)

    # Same as typing in the class
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development

      before_save :assign_openner
    end
  end

  module InstanceMethods
    # 
    def assign_openner
	
	begin
		screenshots = custom_field_values.detect {|c| c.custom_field.name == "Screenshots."} 
		
		shotlink = custom_field_values.detect {|c| c.custom_field.name == "Screenshot Link."} 
		# {{unc(\\tokyoproj6\Test)}}
		
		currentshot = custom_field_values.detect {|c| c.custom_field.name == "Current Screenshot."}
		
		fixedshot = custom_field_values.detect {|c| c.custom_field.name == "Fixed Screenshot."}
		s = shotlink.value.to_s
		str2 = (s.slice(8,s.length - 11)).gsub('\\',"/") + '/'
		currentshot.value = ""
		if  shotlink.value.to_s != "" then
			unless fixedshot.nil?
				str = screenshots.value.to_s + "\r\n" + fixedshot.value.to_s
			else
				str = screenshots.value.to_s
			end
			logger.debug("BBBBB")
			#str‚ğ‰üs‚Å‹æØ‚Á‚Ä”z—ñ‚É“ü‚ê‚é
			lines = str.rstrip.split(/\r?\n/).map {|line| line.chomp }
			
			lines.each{|x|
				if x != "" then
					check = x.include?('\\')
					if check
						pos = x.rindex('\\')
						newStr = x[pos+1, 500]
						filpath = x.gsub('\\',"/")
						currentshot.value += '"' + newStr + "\":file:" + filpath +"\r\n"
					else
						currentshot.value += '"' + x + "\":file://" + str2 +  x + "\r\n"
					end
				end
			}
		else
			#currentshot.value =""
		end
	rescue => ex
  		  logger.debug(ex.message)
	end

    end

  end
end