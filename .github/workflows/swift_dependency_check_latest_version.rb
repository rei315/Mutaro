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

def parse_package_resolved(file_path)
    file = File.read(file_path)
    data = JSON.parse(file)
    packages = data['pins']
    results = []
    
    packages.each do |package|
        state = package['state']
        next if state.nil? || state.empty?
        
        version = state['version']
        next if version.nil? || version.empty?
        
        location = package['location']
        next if location.nil? || location.empty?
        
        uri = URI.parse(location)
        path_parts = uri.path.split('/').reject(&:empty?)

        owner = path_parts[0]
        next if owner.nil? || owner.empty?
        repository = path_parts[1]
        next if repository.nil? || repository.empty?
        
        repository.gsub!(/\.git$/, '')
        
        package_info = {}
        package_info['owner'] = owner
        package_info['repository'] = repository
        package_info['version'] = version
        results << package_info
    end
    
    results
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
        owner, repository, version = package['owner'], package['repository'], package['version']
        latest_tag = get_latest_tag(owner, repository, token)
        latest_tag = extract_version(latest_tag)
        
        result = compare_versions(version, latest_tag)
        next if result == false
        package_info = {}
        package_info['currentVersion'] = version
        package_info['newVersion'] = latest_tag
        package_info['repository'] = "https://github.com/#{owner}/#{repository}"
        available_version_info << package_info
    end
    
    available_version_info
end

file_path = ARGV[0]
token = ARGV[1]
parsed_data = parse_package_resolved(file_path)
results = check_available_new_version(token, parsed_data)

puts JSON.generate(results)
