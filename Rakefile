task default: %w[lint test]

task :lint do
  sh 'rubocop ./lib'
end

task :test do
  sh 'rspec'
end
