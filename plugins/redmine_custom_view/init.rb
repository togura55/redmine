require 'redmine'
require 'application_helper_patch'



    # read/store tracker flags to global valuables
#    trackers_qarepdbc = Tracker.find_all_by_is_hide_qarepdbc(true)
#    trackers_environment = Tracker.find_all_by_is_hide_environment(true)
if ActiveRecord::Base.connection.column_exists? :trackers, :is_childticket_qarepdbc then
if ActiveRecord::Base.connection.column_exists? :trackers, :is_hide_environment then
trackers_qarepdbc = Tracker.where(is_hide_qarepdbc: true)
trackers_environment = Tracker.where(is_hide_environment: true)
    $hide_qarepdbc = []
    $hide_environment = []
    trackers_qarepdbc.each do |t|
    $hide_qarepdbc << t.id
    end
    trackers_environment.each do |t|
    $hide_environment << t.id
    end
end
end

	

    
Redmine::Plugin.register :redmine_custom_view do
  name 'redmine_ custom_view'
  author 'tsato'
  description 'Show hide issue fields and count title characters'
  version '1.3'

end


