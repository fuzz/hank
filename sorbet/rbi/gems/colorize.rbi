# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: true
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/colorize/all/colorize.rbi
#
# colorize-0.8.1

module Colorize
end
module Colorize::ClassMethods
  def color_codes; end
  def color_matrix(_ = nil); end
  def color_methods; end
  def color_samples; end
  def colors; end
  def disable_colorization(value = nil); end
  def disable_colorization=(value); end
  def mode_codes; end
  def modes; end
  def modes_methods; end
end
module Colorize::InstanceMethods
  def background_color(color); end
  def color(color); end
  def color_from_symbol(match, symbol); end
  def colorize(params); end
  def colorized?; end
  def colors_from_hash(match, hash); end
  def colors_from_params(match, params); end
  def defaults_colors(match); end
  def mode(mode); end
  def require_windows_libs; end
  def scan_for_colors; end
  def split_colors(match); end
  def uncolorize; end
end
class String
  def black; end
  def blink; end
  def blue; end
  def bold; end
  def cyan; end
  def green; end
  def hide; end
  def italic; end
  def light_black; end
  def light_blue; end
  def light_cyan; end
  def light_green; end
  def light_magenta; end
  def light_red; end
  def light_white; end
  def light_yellow; end
  def magenta; end
  def on_black; end
  def on_blue; end
  def on_cyan; end
  def on_green; end
  def on_light_black; end
  def on_light_blue; end
  def on_light_cyan; end
  def on_light_green; end
  def on_light_magenta; end
  def on_light_red; end
  def on_light_white; end
  def on_light_yellow; end
  def on_magenta; end
  def on_red; end
  def on_white; end
  def on_yellow; end
  def red; end
  def swap; end
  def underline; end
  def white; end
  def yellow; end
  extend Colorize::ClassMethods
  include Colorize::InstanceMethods
end
