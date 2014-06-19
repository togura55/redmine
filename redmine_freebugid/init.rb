require 'redmine'

unless defined?(Redmine::CustomFieldFormat)
    require_dependency 'freebugid_field_format'
end

if defined?(Redmine::CustomFieldFormat)
    Redmine::CustomFieldFormat.map do |fields|

	base_order = 1

        fields.register    FreebugidCustomFieldFormat.new('freebugid',    :label => :label_freebugid_text, :order => base_order + 0.1)
    end
end


#
# Å´ÉRÉåâΩÇ‚Ç¡ÇƒÇÈÇÒÇæÇÎÇ§ÅH
#
Rails.configuration.to_prepare do

#    unless String.method_defined?(:html_safe)
#        String.send(:include, ExtendedStringHTMLSafePatch)
#    end
#
#    unless ActionView::Base.included_modules.include?(ExtendedFieldsHelper)
#        ActionView::Base.send(:include, ExtendedFieldsHelper)
#    end
#
#    unless defined? ActiveSupport::SafeBuffer
#        unless ActionView::Base.included_modules.include?(ExtendedHTMLEscapePatch)
#            ActionView::Base.send(:include, ExtendedHTMLEscapePatch)
#        end
#    end
#
#    unless AdminController.included_modules.include?(ExtendedAdminControllerPatch)
#        AdminController.send(:include, ExtendedAdminControllerPatch)
#    end
#    unless UsersController.included_modules.include?(ExtendedUsersControllerPatch)
#        UsersController.send(:include, ExtendedUsersControllerPatch)
#    end
#    unless IssuesController.included_modules.include?(ExtendedIssuesControllerPatch)
#        IssuesController.send(:include, ExtendedIssuesControllerPatch)
#    end
#    if ActiveRecord::Base.connection.adapter_name =~ %r{mysql}i
#        unless CalendarsController.included_modules.include?(ExtendedCalendarsControllerPatch)
#            CalendarsController.send(:include, ExtendedCalendarsControllerPatch)
#        end
#    end
#    if Redmine::VERSION::MAJOR == 2 && Redmine::VERSION::MINOR < 5
#        unless ApplicationHelper.included_modules.include?(ExtendedApplicationHelperPatch)
#            ApplicationHelper.send(:include, ExtendedApplicationHelperPatch)
#        end
#    end
#    unless QueriesHelper.included_modules.include?(ExtendedQueriesHelperPatch)
#        QueriesHelper.send(:include, ExtendedQueriesHelperPatch)
#    end

    unless CustomFieldsHelper.included_modules.include?(FreebugidFieldsHelperPatch)
        CustomFieldsHelper.send(:include, FreebugidFieldsHelperPatch)
    end
    if defined?(Redmine::CustomFieldFormat)
        unless CustomField.included_modules.include?(FreebugidCustomFieldPatch)
            CustomField.send(:include, FreebugidCustomFieldPatch)
        end
    end

#    begin
#        unless CustomFieldValue.included_modules.include?(ExtendedCustomFieldValuePatch)
#            CustomFieldValue.send(:include, ExtendedCustomFieldValuePatch)
#        end
#    rescue NameError
#    end
#    unless CustomValue.included_modules.include?(ExtendedCustomValuePatch)
#        CustomValue.send(:include, ExtendedCustomValuePatch)
#    end
#    if defined?(Redmine::CustomFieldFormat)
#        unless Query.included_modules.include?(ExtendedCustomQueryPatch)
#            Query.send(:include, ExtendedCustomQueryPatch)
#        end
#    end
#    unless Project.included_modules.include?(ExtendedProjectPatch)
#        Project.send(:include, ExtendedProjectPatch)
#    end
#    unless User.included_modules.include?(ExtendedUserPatch)
#        User.send(:include, ExtendedUserPatch)
#    end
#
#    unless AdminController.included_modules.include?(CustomFieldsHelper)
#        AdminController.send(:helper, :custom_fields)
#        AdminController.send(:include, CustomFieldsHelper)
#    end
#    unless WikiController.included_modules.include?(CustomFieldsHelper)
#        WikiController.send(:helper, :custom_fields)
#        WikiController.send(:include, CustomFieldsHelper)
#    end
#
#    if defined? ActionView::OptimizedFileSystemResolver
#        unless ActionView::OptimizedFileSystemResolver.method_defined?(:[])
#            ActionView::OptimizedFileSystemResolver.send(:include, ExtendedFileSystemResolverPatch)
#        end
#    end

## 
    if CustomField.method_defined?(:format_in?)
        unless CustomField.included_modules.include?(FreebugidFormatInPatch)
            CustomField.send(:include, FreebugidFormatInPatch)
        end
    end

#    if defined? XlsExportController
#        unless XlsExportController.included_modules.include?(ExtendedFieldsHelper)
#            XlsExportController.send(:include, ExtendedFieldsHelper)
#        end
#    end
end


Redmine::Plugin.register :redmine_freebugid do
  name 'Redmine GetBugID plugin'
  author 'Tsuyoshi OGURA'
  description 'This is a plugin for Redmine enabling the insertion of the latest  Bug ID number to a specified custom field.'
  version '0.0.1'
  url 'http://collaboration.sdl.com/Corporate/offices/tokyo/Engineering/Tools_Project/QARepDB/default.aspx'
end
