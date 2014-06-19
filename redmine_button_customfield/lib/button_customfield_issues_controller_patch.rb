require_dependency 'issues_controller'

#module ButtonCustomfieldIssuesControllerPatch
#
#    def self.included(base)
#        base.send(:include, InstanceMethods)
#    end
#
#    module InstanceMethods
#        def button
#    
#        end
#    end
#end

IssuesController.class_eval do
    def button

    end
end

