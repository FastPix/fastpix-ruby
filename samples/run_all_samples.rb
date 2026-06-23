#!/usr/bin/env ruby
# frozen_string_literal: true

# FastPix Ruby SDK - Sample Runner
# This script runs all available samples in the correct order

require 'time'
require 'fastpixapi'

# Configuration
USERNAME = ENV['FASTPIX_USERNAME'] || 'your_username_here'
PASSWORD = ENV['FASTPIX_PASSWORD'] || 'your_password_here'

puts "🚀 FastPix Ruby SDK - Sample Runner"
puts "=" * 50
puts "Starting at: #{Time.now.strftime('%Y-%m-%d %H:%M:%S')}"
puts ""

# Check prerequisites
def check_prerequisites
  puts "🔍 Checking prerequisites..."
  
  # Check Ruby version
  ruby_version = RUBY_VERSION
  if Gem::Version.new(ruby_version) >= Gem::Version.new('3.2')
    puts "✅ Ruby version: #{ruby_version} (compatible)"
  else
    puts "❌ Ruby version: #{ruby_version} (requires 3.2+)"
    return false
  end
  
  # Check credentials
  if USERNAME == 'your_username_here' || PASSWORD == 'your_password_here'
    puts "⚠️  Using placeholder credentials - set FASTPIX_USERNAME and FASTPIX_PASSWORD"
  else
    puts "✅ Credentials configured"
  end
  
  # Check if fastpixapi gem is available (required at the top of the file)
  if defined?(FastpixClient)
    puts "✅ FastPix API SDK gem loaded"
  else
    puts "❌ FastPix API SDK gem not found"
    puts "   Install with: gem install fastpixapi"
    return false
  end
  
  puts ""
  true
end

# Run a sample with error handling
def run_sample(sample_name, sample_file)
  puts "📁 Running #{sample_name}..."
  puts "-" * 30
  
  start_time = Time.now
  
  begin
    # Load and run the sample
    load sample_file
    end_time = Time.now
    duration = (end_time - start_time).round(2)
    
    puts ""
    puts "✅ #{sample_name} completed in #{duration}s"
    puts ""
    
    true
  rescue => e
    end_time = Time.now
    duration = (end_time - start_time).round(2)
    
    puts ""
    puts "❌ #{sample_name} failed after #{duration}s: #{e.message}"
    puts ""
    
    false
  end
end

# Run a single sample, updating results. Returns :stop to halt the run, else :continue.
def run_one_sample(sample, index, total, results)
  puts "🔄 Sample #{index + 1}/#{total}: #{sample[:name]}"

  unless File.exist?(sample[:file])
    puts "❌ Sample file not found: #{sample[:file]}"
    results[:skipped] += 1
    return :continue
  end

  if run_sample(sample[:name], sample[:file])
    results[:passed] += 1
    return :continue
  end

  results[:failed] += 1
  # If it's a required sample, ask if we should continue
  if sample[:required]
    print "   This is a required sample. Continue with remaining samples? (y/n): "
    response = gets.chomp.downcase
    unless response == 'y' || response == 'yes'
      puts "   Stopping execution due to required sample failure."
      return :stop
    end
  end

  :continue
end

# Main execution
def main
  # Check prerequisites
  unless check_prerequisites
    puts "❌ Prerequisites check failed. Please fix the issues above and try again."
    exit 1
  end
  
  # Define samples to run in order
  samples = [
    {
      name: "Basic Usage",
      file: "samples/basic_usage.rb",
      required: true
    },
    {
      name: "Configuration",
      file: "samples/configuration.rb",
      required: false
    },
    {
      name: "Error Handling",
      file: "samples/error_handling.rb",
      required: false
    },
    {
      name: "Media Upload",
      file: "samples/media_upload.rb",
      required: true
    },
    {
      name: "Live Streaming",
      file: "samples/live_streaming.rb",
      required: false
    },
    {
      name: "Playlist Management",
      file: "samples/playlist_management.rb",
      required: false
    },
    {
      name: "Analytics",
      file: "samples/analytics.rb",
      required: false
    },
    {
      name: "AI Features",
      file: "samples/ai_features.rb",
      required: false
    },
    {
      name: "Signing Keys",
      file: "samples/signing_keys.rb",
      required: false
    },
    {
      name: "DRM Configuration",
      file: "samples/drm_configuration.rb",
      required: false
    }
  ]
  
  # Track results
  results = {
    passed: 0,
    failed: 0,
    skipped: 0
  }
  
  start_time = Time.now
  
  # Run each sample
  samples.each_with_index do |sample, index|
    break if run_one_sample(sample, index, samples.length, results) == :stop

    # Add a small delay between samples
    sleep(1) unless index == samples.length - 1
  end
  
  end_time = Time.now
  total_duration = (end_time - start_time).round(2)
  
  # Print summary
  puts "📊 Sample Execution Summary"
  puts "=" * 30
  puts "Total time: #{total_duration}s"
  puts "Passed: #{results[:passed]}"
  puts "Failed: #{results[:failed]}"
  puts "Skipped: #{results[:skipped]}"
  puts ""
  
  if results[:failed] == 0
    puts "🎉 All samples completed successfully!"
    puts ""
    puts "Next steps:"
    puts "- Review the sample code to understand SDK usage"
    puts "- Modify samples to fit your specific use case"
    puts "- Integrate SDK functionality into your application"
    puts "- Check out the main SDK documentation for advanced features"
  else
    puts "⚠️  Some samples failed. Please review the errors above."
    puts ""
    puts "Troubleshooting tips:"
    puts "- Verify your FastPix credentials are correct"
    puts "- Check your internet connection"
    puts "- Ensure you have proper permissions for the operations"
    puts "- Review the error messages for specific guidance"
  end
  
  puts ""
  puts "Finished at: #{Time.now.strftime('%Y-%m-%d %H:%M:%S')}"
end

# Run the main function
main
