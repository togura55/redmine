ActionController::Routing::Routes.draw do |map|
    map.button('issue/:id/button', :controller => 'issue', :action => 'button', :conditions => { :method => :put })
end