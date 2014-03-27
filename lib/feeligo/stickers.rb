require "feeligo/stickers/version"
require "feeligo/stickers/loader_script_tag"


module Feeligo
  module Stickers
    
    # Returns a <script> tag which can be added to a View to load the Feeligo
    # Stickers module.
    # The <script> tag should be inserted right after the opening <body> tag
    def self.loader_script_tag opts = {}
      LoaderScriptTag.new(opts).to_s
    end
  end
end
