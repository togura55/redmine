# Patches Redmine's Issues dynamically.  Synchronize status value to parent per
# project.
#
module SyncstatIssuePatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)

    # Same as typing in the class
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development
      after_save :sync_status

    end
  end

  module InstanceMethods
    #
    # If the issue has a parent ticket, then copy custom field value to the parent's
    #
    def sync_status
       if !self.parent_issue_id.blank? then
         @parent_issue = Issue.find_by(id: self.parent_issue_id)
         self.custom_field_values.each do |cfv|
#           logger.debug ("key = #{cfv.custom_field_id.to_s}")
           custom_field = CustomField.find_by_id(cfv.custom_field_id)
           if custom_field.is_syncstat then
#             logger.debug ("is_syncstat is set true")             
             @parent_issue.custom_field_values.each do |p_cfv|
               if p_cfv.custom_field_id == cfv.custom_field_id then
#                  logger.debug ("Found id: #{cfv.value.to_s} -> #{p_cfv.value.to_s}")
                  p_cfv.value = cfv.value.to_s
                  @parent_issue.save
               end
             end
           end
         end
       
       end

    end
  end
end