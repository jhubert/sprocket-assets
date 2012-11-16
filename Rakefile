require 'rubygems'
require 'bundler'
require 'pathname'
require 'logger'
require 'fileutils'
require 'handlebars_assets'

Bundler.require

ROOT        = Pathname(File.dirname(__FILE__))
LOGGER      = Logger.new(STDOUT)
BUNDLES     = %w( application.css application.js )
BUILD_DIR   = ROOT.join("build")
SOURCE_DIR  = ROOT.join("src")
VENDOR_DIR  = ROOT.join("lib")

task :compile do
  sprockets = Sprockets::Environment.new(ROOT) do |env|
    env.logger = LOGGER
  end

  sprockets.context_class.class_eval do
    def asset_path(path, options = {})
      path
    end
  end

  sprockets.append_path HandlebarsAssets.path
  sprockets.append_path(SOURCE_DIR.join('javascripts').to_s)
  sprockets.append_path(SOURCE_DIR.join('stylesheets').to_s)
  sprockets.append_path(VENDOR_DIR.join('stylesheets').to_s)
  sprockets.append_path(VENDOR_DIR.join('javascripts').to_s)
  sprockets.append_path(VENDOR_DIR.to_s)

  # Wipe the build directory and recreate it
  FileUtils.rm_rf(BUILD_DIR)
  FileUtils.mkdir(BUILD_DIR)

  BUNDLES.each do |bundle|
    assets = sprockets.find_asset(bundle)
    prefix, basename = assets.pathname.to_s.split('/')[-2..-1]
    LOGGER.debug basename
    FileUtils.mkpath BUILD_DIR.join(prefix)

    assets.write_to(BUILD_DIR.join(prefix, basename))
  end

  FileUtils.cp_r(SOURCE_DIR.join('images'), BUILD_DIR)
  FileUtils.cp_r(VENDOR_DIR.join('images'), BUILD_DIR)
end
