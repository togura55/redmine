ActionController::Routing::Routes.draw do |map|
  map.connect 'issues/button', :controller => 'issues', :action => 'button', :conditions => { :method => :put}
end