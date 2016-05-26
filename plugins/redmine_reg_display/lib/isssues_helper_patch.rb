require_dependency 'issues_helper'

# Patches Redmine's custom_fields_helper dynamically. 

module IssuesHelperPatch
  def self.included(base) # :nodoc:
    #base.extend(ClassMethods)
    base.send(:include, InstanceMethods)

    # Same as typing in the class
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development

      alias_method :render_descendants_tree, :render_descendants_tree_add_cf

    end	
  end

module InstanceMethods

 def render_descendants_tree_add_cf(issue)


    # read/store tracker flags to global valuables
    trackers_regression_environment = Tracker.find_all_by_is_hide_qarepdbc(true)

    $is_hide_qarepdbc = []
    trackers_regression_environment.each do |t|
    $is_hide_qarepdbc << t.id
    end

    if $is_hide_qarepdbc.include?(@issue.tracker.id)

    	s = '<form><table class="list issues">'
    	issue_list(issue.descendants.visible.sort_by(&:lft)) do |child, level|

        #if $hide_regression_environment.include?(@issue.tracker.id)
          cfv92 =CustomValue.find(:first, :conditions => ["customized_id = ? and  custom_field_id = ?", child.id, 92])
          cfv95 =CustomValue.find(:first, :conditions => ["customized_id = ? and  custom_field_id = ?", child.id, 95])
          cfv93 =CustomValue.find(:first, :conditions => ["customized_id = ? and  custom_field_id = ?", child.id, 93])
	  cfv96 =CustomValue.find(:first, :conditions => ["customized_id = ? and  custom_field_id = ?", child.id, 96])

      	s << content_tag('tr',
             content_tag('td', check_box_tag("ids[]", child.id, false, :id => nil), :class => 'checkbox') +
	     #changed truncate value from 60 to 3
	     content_tag('td', link_to_issue(child, :truncate => 3), :class => 'subject') +
             #removed sataus
	     #content_tag('td', h(child.status)) + 
	     content_tag('td', h(cfv93)) + 
             content_tag('td', h(cfv92)) +
	     content_tag('td', h(cfv95)) +
	     content_tag('td', h(cfv96)) +
             content_tag('td', link_to_user(child.assigned_to)) +
             content_tag('td', progress_bar(child.done_ratio, :width => '80px')),
             :class => "issue issue-#{child.id} hascontextmenu #{level > 0 ? "idnt idnt-#{level}" : nil}")
	 end
    else

    #if not QARepDBc do original
    s = '<form><table class="list issues">'
    issue_list(issue.descendants.visible.sort_by(&:lft)) do |child, level|
      s << content_tag('tr',
             content_tag('td', check_box_tag("ids[]", child.id, false, :id => nil), :class => 'checkbox') +
             content_tag('td', link_to_issue(child, :truncate => 60), :class => 'subject') +
             content_tag('td', h(child.status)) +
             content_tag('td', link_to_user(child.assigned_to)) +
             content_tag('td', progress_bar(child.done_ratio, :width => '80px')),
             :class => "issue issue-#{child.id} hascontextmenu #{level > 0 ? "idnt idnt-#{level}" : nil}")
         end
    end

    s << '</table></form>'
    s.html_safe
  end

  end
end
IssuesHelper.send(:include, IssuesHelperPatch)
