module UsersHelper

  # Returns the Gravatar for the given user.
	def gravatar_for(user, options = { size: 80 })
    image_tag(user.avatar.url(:thumb), alt: user.fname, class: "gravatar")
  end

end
