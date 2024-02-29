import requests
import os
from enum import Enum

class BuildType(Enum):
    scmGitReferences = 1
    scmPullRequests = 2

build_type = BuildType.scmGitReferences
repository_id = None
product_id = None
workflows_list = None
APP_STORE_URL = "https://api.appstoreconnect.apple.com/v1/"
REPOSITORY_NAME = "Mutaro"

JWT_TOKEN = os.environ['JWT_TOKEN']
BRANCH_NAME = os.environ['BRANCH_NAME']
WORKFLOW_NAME = os.environ['WORKFLOW_NAME']
TARGET_PRODUCT_NAME = os.environ['TARGET_PRODUCT_NAME']

def get(url, token):
    headers = {
        'Authorization': 'Bearer {}'.format(token),
        'content-type': 'application/json'
    }
    response = requests.get(APP_STORE_URL+url, headers=headers)
    return response
    
def post(url, token, body):
    headers = {
        'Authorization': 'Bearer {}'.format(token),
        'content-type': 'application/json'
    }
    response = requests.post(APP_STORE_URL+url, headers=headers, json=body)
    return response

def get_repositories():
    response = get("scmRepositories", JWT_TOKEN).json()["data"]
    repositories = []
    for repo in response:
        repository = {
            'id': repo['id'],
            'name': repo['attributes']['repositoryName'],
            'url': repo['attributes']['httpCloneUrl']
        }
        repositories.append(repository)
    return repositories

def get_mutaro_repository_id():
    global repository_id
    if repository_id is None:
        repositories = get_repositories()
        repository = next((repo for repo in repositories if repo["name"] == REPOSITORY_NAME), None)
        if repository:
            repository_id = repository["id"]
    return repository_id

def get_pull_requests(branch):
    repository_id = get_mutaro_repository_id()
    return get(f"scmRepositories/{repository_id}/pullRequests?limit=200&fields[scmPullRequests]=sourceBranchName", JWT_TOKEN).json()

def find_pr_request_for_branch(branch):
    next_page = ''
    pull_requests = get_pull_requests(branch)
    pull_request_id = next((pullRequest["id"] for pullRequest in pull_requests["data"] if pullRequest["attributes"]["sourceBranchName"] == branch), None)
    while pull_request_id is not None or next_page is None:
        next_page = pull_requests.get("links", {}).get("next", "")
        next_page = next_page.replace(APP_STORE_URL, '')
        if not next_page:
            break
        pullRequest = get(next_page, JWT_TOKEN).json()
        pull_request_id = next((pullRequest["id"] for pullRequest in pull_requests["data"] if pullRequest["attributes"]["sourceBranchName"] == branch), None)
    return pull_request_id

def get_git_references():
    repository_id = get_mutaro_repository_id()
    return get(f"scmRepositories/{repository_id}/gitReferences?limit=200&fields[scmGitReferences]=kind,name", JWT_TOKEN).json()

def find_git_reference_for_branch(branch):
    next_page = ''
    references = get_git_references()
    branch_reference = next((reference["id"] for reference in references["data"] if reference["attributes"]["kind"] == "BRANCH" and reference["attributes"]["name"] == branch), None)
    while branch_reference is not None or next_page is None:
        next_page = references.get("links", {}).get("next", "")
        next_page = next_page.replace(APP_STORE_URL, '')
        if not next_page:
            break
        reference = get(next_page, JWT_TOKEN).json()
        branch_reference = next((reference["id"] for reference in references["data"] if reference["attributes"]["kind"] == "BRANCH" and reference["attributes"]["name"] == branch), None)
    return branch_reference

def get_products():
    products_data = get("ciProducts", JWT_TOKEN).json()["data"]
    products = []
    for product in products_data:
        product_info = {
            'id': product['id'],
            'product': product['attributes']['name'],
            'type': product['attributes']['productType']
        }
        products.append(product_info)
    return products

def get_target_product_id():
    global product_id
    if product_id is None:
        products = get_products()
        product = next((p for p in products if p["product"] == TARGET_PRODUCT_NAME), None)
        if product:
            product_id = product["id"]
    return product_id

def get_workflows():
    product_id = get_target_product_id()
    return get(f"ciProducts/{product_id}/workflows?limit=200", JWT_TOKEN).json()["data"]

def get_workflow_id_for_name(name):
    global workflows_list
    if workflows_list is None:
        workflows_list = get_workflows()
    workflow = next((w for w in workflows_list if w["attributes"]["name"].split("_")[0] == name), None)
    if workflow:
        return workflow["id"]
    return None

# scmPullRequests経由でビルド
def start_build_by_pr(workflow_id):
    pr_id = find_pr_request_for_branch(BRANCH_NAME)
    body = {
        'data': {
            'type': 'ciBuildRuns',
            'attributes': {},
            'relationships': {
                'workflow': {
                    'data': {
                        'type': 'ciWorkflows',
                        'id': workflow_id
                    }
                },
                'pullRequest': {
                    'data': {
                        'type': 'scmPullRequests',
                        'id': pr_id
                    }
                }
            }
        }
    }
    response = post("ciBuildRuns", JWT_TOKEN, body)
    return response

# scmGitReferences経由でビルド
def start_build_by_branch(workflow_id):
    branch_id = find_git_reference_for_branch(BRANCH_NAME)
    body = {
        'data': {
            'type': 'ciBuildRuns',
            'attributes': {},
            'relationships': {
                'workflow': {
                    'data': {
                        'type': 'ciWorkflows',
                        'id': workflow_id
                    }
                },
                'sourceBranchOrTag': {
                    'data': {
                        'type': 'scmGitReferences',
                        'id': branch_id
                    }
                }
            }
        }
    }
    response = post("ciBuildRuns", JWT_TOKEN, body)
    return response

def main():
    workflow_id = get_workflow_id_for_name(WORKFLOW_NAME)
    if build_type == BuildType.scmPullRequests:
        build_response = start_build_by_pr(workflow_id)
    elif build_type == BuildType.scmGitReferences:
        build_response = start_build_by_branch(workflow_id)
    else:
        build_response = None

    if build_response is not None:
        build_response.raise_for_status()
        print(build_response.status_code)
    else:
        print("Error: need to set build_type")

if __name__ == "__main__" :
    main()
