import json
import requests
import sys
from urllib.parse import urlparse

def get_latest_tag(owner, repository, token):
    url = f"https://api.github.com/repos/{owner}/{repository}/tags"
    headers = {"Authorization": f"Bearer {token}"}
    
    response = requests.get(url, headers=headers)
    
    if response.status_code == 200:
        tags = json.loads(response.text)
        latest_tag = tags[0]['name'] if tags else 'N/A'
    else:
        latest_tag = 'N/A'
    
    return latest_tag

def parse_package_swift(file_path, dependencies):
    with open(file_path, 'r') as file:
        file_content = file.read()
    
    dependencies_section = re.search(r'dependencies:\s*\[(.*?)\]', file_content, re.DOTALL)
    
    if dependencies_section:
        package_matches = re.findall(r'.package\s*\((.*?)\)', dependencies_section.group(1), re.DOTALL)
        
        for package_match in package_matches:
            url_match = re.search(r'url:\s*["\'](.*?)["\']', package_match)
            version_match = re.search(r'(?:from|exact):\s*["\'](.*?)["\']', package_match)
            
            if url_match and version_match:
                url = url_match.group(1)
                version = version_match.group(1)
                
                parsed_url = urlparse(url)
                path_parts = parsed_url.path.strip('/').split('/')
                
                if len(path_parts) >= 2:
                    owner = path_parts[0]
                    repository = path_parts[1].rstrip('.git')
                    
                    package_info = {
                        'full_url': url,
                        'owner': owner,
                        'repository': repository,
                        'version': version
                    }
                    
                    dependencies.append(package_info)
    
    return dependencies

def extract_version(version):
    version = version.lstrip('v') if version.startswith('v') else version
    version = version.split('-')[0] if '-' in version else version
    version = re.search(r'\d+\.\d+\.\d+', version).group(0) if re.search(r'\d+\.\d+\.\d+', version) else ""
    
    return version

def compare_versions(package_version, git_version):
    v1_parts = list(map(int, package_version.split('.')))
    v2_parts = list(map(int, git_version.split('.')))
    
    comparison_result = (v1_parts > v2_parts) - (v1_parts < v2_parts)
    
    return comparison_result < 0

def check_available_new_version(token, data):
    available_version_info = []
    
    for package in data:
        owner, repository, version, url = package['owner'], package['repository'], package['version'], package['full_url']
        latest_tag = get_latest_tag(owner, repository, token)
        latest_tag = extract_version(latest_tag)
        
        result = compare_versions(version, latest_tag)
        if result:
            package_info = {
                'currentVersion': version,
                'newVersion': latest_tag,
                'repository': url
            }
            available_version_info.append(package_info)
    
    return available_version_info

gh_token = sys.argv[1]
package_files = sys.argv[2:]

all_dependencies = []

for package_swift_file_path in package_files:
    parse_package_swift(package_swift_file_path, all_dependencies)

results = check_available_new_version(gh_token, all_dependencies)

print(json.dumps(results))
