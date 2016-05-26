require_dependency 'issues_controller'

# 
module IssuesControllerPatch
  def self.included(base) # :nodoc:

    base.send(:include, InstanceMethods)

    # Same as typing in the class
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development

      alias_method_chain :new, :default_child_tracker_new

    end
  end

  module ClassMethods
    end

 
module InstanceMethods
   def new_with_default_child_tracker_new
		if !params[:issue].nil? #チケットの詳細ページから飛ぶ場合。親チケットとなるチケットが存在する
			if !params[:issue][:regression].nil? #Regressionチケットの追加
				default_copy_child_tracker
			else #子チケットの追加
				 new_without_default_child_tracker_new   
			end
		else #新規ページからチケットを作成する場合。親チケットは存在しない	
			new_without_default_child_tracker_new
		end
	end
	
   def default_copy_child_tracker
    # copied from sync_stat plugin   
       unless @issue.parent_issue_id.blank? then
	 trackers_environment = Tracker.find_by_is_childticket_environment(true)
	 @issue.tracker_id =trackers_environment.id # if parent filed is not empty, change tracker to Bug_Regression
	 @parent_issue = Issue.find_by_id(@issue.parent_issue_id)
	@issue.custom_field_values.each do |cfv|
           custom_field = CustomField.find_by_id(cfv.custom_field_id)#           if custom_field.is_syncstat then
             @parent_issue.custom_field_values.each do |p_cfv|    # Tracker must be set before custom field values

    #@issue.tracker ||= @project.trackers.find((params[:issue] && params[:issue][:tracker_id]) || params[:tracker_id] || :first)

    		if p_cfv.custom_field_id == cfv.custom_field_id then
		   cfv.value = p_cfv.value.to_s# copy custom filed from it's parent id 
	       end
           end
         end
       end
   end # end copy_child_ticket
   end
  end
# Add module to IssuesController#
#IssuesController.send(:include, IssuesControllerPatch)

