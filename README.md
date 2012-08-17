FlashHelper
===========

This extension provides a simple way to handle flash messages.
You can easily display notices, errors and warnings using the convinience method.

Installation
------------

Edit your Gemfile and add:

	gem "flash_helper"

then run bundler:

	bundle install

Example
-------

For example, in your layout use :

	display_flashes

Then in your controllers you can use :

	flash[:notice] = "Successfully created..."
	flash[:errors] = "Creation failed!"
	flash[:errors] = @news.errors
	flash[:warning] = "The new user has no blog associated..."

If you're using Rails >= 2.2, you can translate plugin internal messages.
For example in config/locales/fr.yml you can add :

    flash_helper:
      default_message: "Il y a des problèmes dans le formulaire :"

Tune display_flashes :

Options for flash helpers are optional and get their default values from the
Bounga::FlashHelper::ViewHelpers.flash_options hash. You can write to this hash to
override default options on the global level:

	Bounga::FlashHelper::ViewHelpers.flash_options[:notice_class] = 'my_notice'

Available options (and their defaults) are :

	:list_class       => 'errors_list'
	:notice_class     => 'notice'
	:errors_class     => 'errors'
	:warning_class    => 'warning'
	:default_message  => 'There are problems in your submission:'

By putting this into "config/initializers/flash_helper.rb" (or simply environment.rb in
older versions of Rails) you can easily override any default option.

Other
-----

More information on [Project homepage](http://www.bitbucket.org/Bounga/flash-helper)

Problems, comments, and suggestions are welcome on the [ticket system](http://www.bitbucket.org/Bounga/flash-helper/tickets/new)


Copyright (c) 2012 Nicolas Cavigneaux, released under the MIT license