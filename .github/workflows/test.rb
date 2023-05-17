require 'json'
require 'net/http'
require 'uri'

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

gh_token = ARGV[0]
package_files = ARGV[1..]
all_dependencies = []

package_files.each do |package_swift_file_path|
  parse_package_swift(package_swift_file_path, all_dependencies)
end

puts JSON.generate(results)
