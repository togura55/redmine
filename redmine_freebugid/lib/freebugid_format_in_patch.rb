require_dependency 'custom_field'

module FreebugidFormatInPatch

    def self.included(base)
        base.send(:include, InstanceMethods)
        base.class_eval do
            unloadable

            alias_method_chain :format_in?, :freebugid
        end
    end

    module InstanceMethods

        def format_in_with_freebugid?(*args)
            case field_format
#            when 'wiki'
            when 'freebugid'
                args.include?('text')
#            when 'link'
#                args.include?('link') || args.include?('string')
#            when 'project'
#                args.include?('version')
            else
                format_in_without_freebugid?(*args)
            end
        end

    end

end
