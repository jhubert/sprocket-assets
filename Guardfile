guard 'bundler' do
  watch('Gemfile')
end

guard 'pow' do
  watch('Gemfile.lock')
  watch('Rakefile')
  watch('config.ru')
end

guard :shell do
  watch(%r{^(src|lib)/(.*/)?([^/]+)\.*$}) { |m| n(m[0], 'Recompiling'); `rake compile` }
end
