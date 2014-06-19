require_dependency 'custom_field'

module FreebugidCustomFieldPatch

    def self.included(base)
        base.send(:include, AliasCastValueMethod)
        if base.method_defined?(:possible_values_options)
            base.send(:include, AliasPossibleValuesOptionsMethod)
            base.class_eval do
                unloadable

                alias_method_chain :possible_values_options, :freebugid
                alias_method_chain :cast_value,              :freebugid
            end
        else
            base.send(:include, OverridePossibleValuesMethod)
            base.class_eval do
                unloadable

                alias_method_chain :cast_value, :freebugid
            end
        end
    end

    module AliasPossibleValuesOptionsMethod

        def possible_values_options_with_freebugid(obj = nil)
            case field_format
            when 'project'
                if obj.is_a?(User)
                    projects = Project.visible(obj).all
                else
                    projects = Project.visible.all
                end
                projects.collect{ |project| [ project.name, project.id.to_s ] }
            else
                possible_values_options_without_freebugid(obj)
            end
        end

    end

    module OverridePossibleValuesMethod

        def possible_values(dummy = nil)
            case field_format
            when 'project'
                Project.visible.all.collect{ |project| [ project.name, project.id.to_s ] }
            else
                read_attribute(:possible_values)
            end
        end

        alias_method :possible_values_options, :possible_values

    end

    module AliasCastValueMethod

        def cast_value_with_freebugid(value)
            case field_format
            when 'wiki', 'link', 'freebugid'
#            when 'freebugid'
                value.blank? ? nil : value
            when 'project'
                unless value.blank?
                    Project.find_by_id(value)
                else
                    nil
                end
            else
                cast_value_without_freebugid(value)
            end
        end

    end

end