# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'bundler' do
  watch('Gemfile')
end

guard :rspec do
  watch(%r{^spec/app/entities/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})           { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/app/spec_helper.rb')    { "spec" }
  watch(%r{^app/entities/(.+)\.rb$})  { |m| "spec/app/entities/#{m[1]}_spec.rb" }


end


