import requests
import os

def get(url, token):
    headers = {
        'Authorization': 'Bearer {}'.format(token),
        'content-type': 'application/json'
    }
    response = requests.get(url, headers=headers)
    return response
    
def post(url, token, body):
    headers = {
        'Authorization': 'Bearer {}'.format(token),
        'content-type': 'application/json'
    }
    response = requests.post(url, headers=headers, json=body)
    return response

REPOSITORY_NAME = "Mutaro"

JWT_TOKEN = os.environ['JWT_TOKEN']
BRANCH_NAME = os.environ['BRANCH_NAME']
WORKFLOW_NAME = os.environ['WORKFLOW_NAME']
TARGET_PRODUCT_NAME = os.environ['TARGET_PRODUCT_NAME']

productsResponse = get("https://api.appstoreconnect.apple.com/v1/apps", JWT_TOKEN)
if productsResponse.status_code != 200:
    print(productsResponse.status_code.status_code)
    exit()
    
productsResponseJson = productsResponse.json()
productsTargetData = productsResponseJson["data"]
productsTargetCIProduct = [x for x in productsTargetData if x["attributes"]["name"] == TARGET_PRODUCT_NAME]
productsTargetCIProductLink = productsTargetCIProduct[0]["relationships"]["ciProduct"]["links"]["related"]

targetCIProductDetailResponse = get(productsTargetCIProductLink, JWT_TOKEN)
if targetCIProductDetailResponse.status_code != 200:
    print(targetCIProductDetailResponse.status_code)
    exit()

targetCIProductDetailJson = targetCIProductDetailResponse.json()
targetCIProductDetailData = targetCIProductDetailJson["data"]
targetCIWorkflowLink = targetCIProductDetailData["relationships"]["workflows"]["links"]["related"]

workflowListResponse = get(targetCIWorkflowLink, JWT_TOKEN)
if workflowListResponse.status_code != 200:
    print(workflowListResponse.status_code)
    exit()

targetWorkflowJson = workflowListResponse.json()
targetWorkflowData = targetWorkflowJson["data"]
targetWorkflowId = [x for x in targetWorkflowData if x["attributes"]["name"] == WORKFLOW_NAME][0]["id"]

repositoriesResponse = get("https://api.appstoreconnect.apple.com/v1/scmRepositories", JWT_TOKEN)
if repositoriesResponse.status_code != 200:
    print(repositoriesResponse.status_code)
    exit()
    
repositoriesJson = repositoriesResponse.json()
targetRepositoryData = repositoriesJson["data"]
targetRepositoryLink = [x for x in targetRepositoryData if x["attributes"]["repositoryName"] == REPOSITORY_NAME][0]["relationships"]["pullRequests"]["links"]["related"]

targetPullRequestResponse = get(targetRepositoryLink, JWT_TOKEN)
if targetPullRequestResponse.status_code != 200:
    print(targetPullRequestResponse.status_code)
    exit()

targetPullRequestJson = targetPullRequestResponse.json()
targetPullRequestData = targetPullRequestJson["data"]
targetPullRequestId = [x for x in targetPullRequestData if x["attributes"]["sourceBranchName"] == BRANCH_NAME][0]["id"]

requestBuildBody = {
    "data": {
        "type": "ciBuildRuns",
        "attributes": {},
        "relationships": {
            "workflow": {
                "data": {
                    "type": "ciWorkflows",
                    "id": targetWorkflowId
                }
            },
            "pullRequest": {
                "data": {
                    "type": "scmPullRequests",
                    "id": targetPullRequestId
                }
            }
        }
    }
}
buildResponse = post("https://api.appstoreconnect.apple.com/v1/ciBuildRuns", JWT_TOKEN, requestBuildBody)
print(buildResponse.status_code)
