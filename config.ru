require 'bundler/setup'
require 'logger'
require 'mime/types'

Bundler.require(:default)

LOGGER      = Logger.new(STDOUT)
ROOT        = Pathname(File.dirname(__FILE__))
BUILD_DIR   = ROOT.join("build")

app = lambda do |env|
  files = {}
  Dir["#{BUILD_DIR}/**/*.*"].each do |path|
    name = File.basename(path)
    type = MIME::Types.type_for(name)[0].to_s
    files[name] = { :path => path, :type => type === '' ? 'text/plain' : type }
  end

  asset = files[env['PATH_INFO'].sub('/assets/','')]

  if asset
    [200, { 'Content-Type' => asset[:type] }, [File.read(asset[:path])]]
  else
    [200, { 'Content-Type' => 'text/plain' }, ["#{asset.inspect}"]]
  end
end

run app
