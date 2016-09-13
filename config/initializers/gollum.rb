require 'gollum/app'

Rails.application.routes.draw do
  Precious::App.set(:gollum_path, Rails.root.join('wiki').to_s)
  Precious::App.set(:default_markup, :markdown) # set your favorite markup language
  Precious::App.set(:wiki_options, {:universal_toc => false})
end
