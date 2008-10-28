$:.unshift "#{File.dirname(__FILE__)}/lib"
require 'flash_helpers'
ActionView::Base.send :include, Bounga::FlashHelpers::ViewHelpers