import plistlib
import os
import sys

def openPlist(plistPath):
    try:
        with open(plistPath, 'rb') as fp:
            tmpPlist = plistlib.load(fp)
            return tmpPlist
    except:
        print("Retty: - there is no plist in path")
            
def updateVersion(version, plistPath, originalFile):
    try:
        with open(plistPath, 'wb') as fp:
            originalFile["CFBundleShortVersionString"] = version
            plistlib.dump(originalFile, fp)
    except:
        print("Retty: - Failed to update version")


def updateBuildVersion(version, plistPath, originalFile):
    try:
        with open(plistPath, 'wb') as fp:
            originalFile["CFBundleVersion"] = version
            plistlib.dump(originalFile, fp)
    except:
        print("Retty: - Failed to update build version")


shuoldSkipUpdate = os.environ['should_skip']

mainInfoPListFilePath = "./Retty/Info.plist"
notificationInfoPListFilePath = "./NotificationService/Info.plist"

mainPlist = openPlist(mainInfoPListFilePath)
originalVersion = mainPlist["CFBundleShortVersionString"]
notificationPlist = openPlist(notificationInfoPListFilePath)

if shuoldSkipUpdate == 'true':
    originalBuildVersion = mainPlist["CFBundleVersion"]
    nextBuildVersion = str(int(originalBuildVersion) + 1)
    updateBuildVersion(nextBuildVersion, mainInfoPListFilePath, mainPlist)
    updateBuildVersion(nextBuildVersion, notificationInfoPListFilePath, notificationPlist)
    
    print(originalVersion)
    exit()
    
base, _ , minor = originalVersion.rpartition('.')
nextVersion = base + '.' + str(int(minor) + 1)

updateVersion(nextVersion, mainInfoPListFilePath, mainPlist)
updateVersion(nextVersion, notificationInfoPListFilePath, notificationPlist)

print(nextVersion)
