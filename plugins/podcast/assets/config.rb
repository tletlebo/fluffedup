#
# This file is only needed for Compass/Sass integration. If you are not using
# Compass, you may safely ignore or delete this file.
#
# If you'd like to learn more about Sass and Compass, see the sass/README.txt
# file for more information.
#

# Suppressing warnings due to old Zen theme and deprecated legacy browser support.
disable_warnings = true

# Change this to :production when ready to deploy the CSS to the live server.
#environment = :development
environment = :production

# Create sourcemaps
sourcemap = true

# In development, we can turn on the FireSass-compatible debug_info.
#firesass = false
firesass = false
Sass::Plugin.options[:debug_info] = false

# Location of the theme's resources.
css_dir         = "css"
sass_dir        = "sass"
fonts_dir       = "css/fonts"
extensions_dir  = "sass-extensions"
images_dir      = "images"
javascripts_dir = "js"
cache_path = '/tmp/.sass-cache'


# Require any additional compass plugins installed on your system.
require 'autoprefixer-rails'
require 'sassy-buttons'
require 'breakpoint'
require "rgbapng"


# You can select your preferred output style here (can be overridden via the command line):
# output_style = :expanded or :nested or :compact or :compressed
output_style = (environment == :development) ? :expanded : :compressed

# To enable relative paths to assets via compass helper functions. Since Drupal
# themes can be installed in multiple locations, we don't need to worry about
# the absolute path to the theme from the server root.
relative_assets = true

# To disable debugging comments that display the original location of your selectors. Uncomment:
line_comments = false

# Pass options to sass. For development, we turn on the FireSass-compatible
# debug_info if the firesass config variable above is true.
# sass_options = (environment == :development && firesass == true) ? {:debug_info => true} : {}

# Run autoprefixer after compass compiles
# Using on_stylesheet_saved post-compile hook
on_stylesheet_saved do |file|
  css = File.read(file)
  File.open(file, 'w') { |io| io << AutoprefixerRails.process(css, browsers: ['> 20%', 'IE 10'], remove: false) }

  cssfile = File.basename file

# Append sourcemap reference that autoprefixer removed to css file.
  system( "printf '/*# sourceMappingURL=" + cssfile + ".map */' >> " + File.absolute_path(file) )
  system( "echo '" + cssfile + ".map sourcemap reference appended to '" + cssfile )
  system( "echo 'Autoprefixer has processed " + cssfile + "'" )
end