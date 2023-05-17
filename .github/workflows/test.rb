require 'json'
require 'net/http'
require 'uri'

def get_latest_tag(owner, repository, token)
    url = "https://api.github.com/repos/#{owner}/#{repository}/tags"
    
    uri = URI(url)
    request = Net::HTTP::Get.new(uri)
    request['Authorization'] = "Bearer #{token}"
    
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
    end
    
    if response.code == '200'
        tags = JSON.parse(response.body)
        latest_tag = tags[0]['name'] unless tags.empty?
        latest_tag ||= 'N/A'
    else
        latest_tag = 'N/A'
    end
    
    latest_tag
end

def parse_package_swift(file_path, dependencies)
  file_content = File.read(file_path)

  # Find the dependencies section within the package.swift file
  dependencies_section = file_content.match(/dependencies:\s*\[(.*?)\]/m)&.captures&.first

  if dependencies_section
    # Find each package within the dependencies section
    dependencies_section.scan(/.package\s*\((.*?)\)/m) do |package_match|
      package = package_match[0]

      # Extract the URL and version from each package
      url_match = package.match(/url:\s*["'](.*?)["']/)
      version_match = package.match(/(?:from|exact):\s*["'](.*?)["']/)

      url = url_match&.captures&.first
      version = version_match&.captures&.first
      next if url.nil? || version.nil?

      uri = URI.parse(url)
      path_parts = uri.path.split('/').reject(&:empty?)
      owner = path_parts[0]
      next if owner.nil? || owner.empty?
      repository = path_parts[1]
      next if repository.nil? || repository.empty?
      repository.gsub!(/\.git$/, '')

      package_info = {}
      package_info['full_url'] = url
      package_info['owner'] = owner
      package_info['repository'] = repository
      package_info['version'] = version
      dependencies << package_info
    end
  end

  dependencies
end

def extract_version(version)
    version.gsub!(/^v/, '') if version.start_with?('v')
    version.gsub!(/-.*/, '') if version.include?('-')
    version = version.match(/\d+\.\d+\.\d+/) ? version.match(/\d+\.\d+\.\d+/)[0] : ""
    version
end

def compare_versions(packageVersion, gitVersion)
    v1_parts = packageVersion.split('.').map(&:to_i)
    v2_parts = gitVersion.split('.').map(&:to_i)
    
    comparison_result = v1_parts <=> v2_parts
    
    return false if comparison_result == 1 || comparison_result == 0
    return true
end

def check_available_new_version(token, data)
    available_version_info = []
    
    data.each do |package|
        owner, repository, version, url = package['owner'], package['repository'], package['version'], package['full_url']
        latest_tag = get_latest_tag(owner, repository, token)
        latest_tag = extract_version(latest_tag)
        
        result = compare_versions(version, latest_tag)
        next if result == false
        package_info = {}
        package_info['currentVersion'] = version
        package_info['newVersion'] = latest_tag
        package_info['repository'] = url
        available_version_info << package_info
    end
    
    available_version_info
end

gh_token = ARGV[0]
package_files = ARGV[1..]
all_dependencies = []

package_files.each do |package_swift_file_path|
  parse_package_swift(package_swift_file_path, all_dependencies)
end
results = check_available_new_version(token, all_dependencies)

puts JSON.generate(results)
