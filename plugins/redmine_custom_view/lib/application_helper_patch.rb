# encoding: utf-8
#

require 'application_helper'

ApplicationHelper.module_eval do

##aditiona codes for count  
def countdown_field(field_id,update_id,max,options = {})
  function = "$('#{update_id}').innerHTML = (#{max} - $F('#{field_id}').length);" 
  count_field_tag(field_id,function,options)
end

def count_field(field_id,update_id,options = {})
  function = "$('#{update_id}').innerHTML = $F('#{field_id}').length;" 
  count_field_tag(field_id,function,options)
end

def count_field_tag(field_id,function,options = {})  
  out = javascript_tag function
  out += observe_field(field_id, options.merge(:function => function))
  return out
end

end



