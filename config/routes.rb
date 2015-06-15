Spree::Core::Engine.routes.draw do
  # Add your extension routes here
   get "/sale" => "home#sale"
   get "/new"  => "home#new"
   post "/payment" => "home#create"
end
