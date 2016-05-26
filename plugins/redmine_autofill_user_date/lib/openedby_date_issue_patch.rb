# Patches Redmine's Issues dynamically.  Adds a default assignee per
# project.
#
# Based heavily on edavis10's stuff-to-do plugin
#
module OpenedbymeOpeneddateIssuePatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)

    # Same as typing in the class
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development

      before_save :set_openedby
    end
  end

  module InstanceMethods
    #
	def set_openedby
		ob_name = "Opened By."
		ob = custom_field_values.detect {|c| c.custom_field.name == ob_name}
		etsg_name = "ETSG-J Issue No.."
		etsgObj = custom_field_values.detect {|c| c.custom_field.name == etsg_name}
		odate_name = "Opened Date."
		odate = custom_field_values.detect {|c| c.custom_field.name == odate_name}
		if etsgObj.nil? then check = false	
		else check = etsgObj.value.to_s.include?("S000")
		end
		if !check
			unless ob.nil? then
			if ob.value.to_s == "" then
				ob.value = User.current.to_s
			end
			end
			unless odate.nil? then
			if odate.value.to_s == "" then
				day = Time.now.strftime("%Y-%m-%d")
				odate.value = day
			end
			end
		end

		# Checked By.
		checkedby_name = "Checked By."
		chkby = custom_field_values.detect {|c| c.custom_field.name == checkedby_name}
		unless chkby.nil? then			
			if chkby.value.to_s =="" then
				chkby.value = User.current.to_s
			end
		else
			logger.debug ('Not found "Checked By."')
		end
		# Date.
		chkdate_name = "Date."
		chkdate = custom_field_values.detect {|c| c.custom_field.name == chkdate_name}
		unless chkdate.nil? then			
			if chkdate.value.to_s =="" then
				day = Time.now.strftime("%Y-%m-%d")
				chkdate.value = day
			end
		else
			logger.debug ('Not found "Date."')
		end
	end # def end
  end
end
