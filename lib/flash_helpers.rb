require 'active_support'

module Bounga
  module FlashHelpers
    # This extension provides a simple way to handle flash messages.
    # You can easily display notices, errors and warnings using the convinience method.
    #
    # == Example
    #
    # For example, in your layout use :
    #
    #   display_flashes # Use defaults
    #
    # Then in your controllers you can use :
    #   flash[:notice] = "Successfully created..."
    #   flash[:errors] = "Creation failed!"
    #   flash[:errors] = @news.errors
    #   flash[:warning] = "The new user has no blog associated..."
   
    # == Global options for helpers
    #
    # Options for flash helpers are optional and get their default values from the
    # <tt>Bounga::FlashHelpers::ViewHelpers.flash_options</tt> hash. You can write to this hash to
    # override default options on the global level:
    #
    #   Bounga::FlashHelpers::ViewHelpers.flash_options[:notice_class] = 'my_notice'
    #
    # By putting this into "config/initializers/flash_helpers.rb" (or simply environment.rb in
    # older versions of Rails) you can easily override any default option.
    module ViewHelpers
      # default options that can be overridden on the global level
      @@flash_options = {
        :list_class     => 'errors_list',
        :notice_class     => 'notice',
        :errors_class     => 'errors',
        :warning_class    => 'warning',
        :default_message  => 'There are problems in your submission:'
      }
      mattr_reader :flash_options
      
      # Display flash messages.
      # You can pass an optional string as a parameter. It will be display before
      # error messages.
      def display_flashes(message = @@flash_options[:default_message])
        if flash[:notice]
          flash_to_display, level = flash[:notice], @@flash_options[:notice_class]
        elsif flash[:warning]
          flash_to_display, level = flash[:warning], @@flash_options[:warning_class]
        elsif flash[:errors]
          level = @@flash_options[:errors_class]
          if flash[:errors].instance_of? ActiveRecord::Errors
            flash_to_display = message
            flash_to_display << activerecord_error_list(flash[:errors])
          else
            flash_to_display = flash[:errors]
          end
        else
          return
        end
        flash.discard(:notice); flash.discard(:warning); flash.discard(:errors)
        content_tag 'div', flash_to_display, :class => "#{level}"
      end 

      
      def activerecord_error_list(errors)
        error_list = '<ul class="' + @@flash_options[:list_class] + '">'
        error_list << errors.collect do |e, m|
          "<li>#{e.humanize unless e == "base"} #{m}</li>"
        end.to_s << '</ul>'
        error_list
      end
    end
  end
end