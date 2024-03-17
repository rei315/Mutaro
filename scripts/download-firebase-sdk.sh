FIREBASE_VERSION=$1
TARGET_FILE_OR_DIR=("Firebase.h" "module.modulemap" "FirebaseCrashlytics" "FirebaseAnalytics")

remove_all_files() {
    rm -r RettyProxyModule/XCFrameworks/Firebase/*
}

install_sdks() {
    curl -OL https://github.com/firebase/firebase-ios-sdk/releases/download/${FIREBASE_VERSION}/Firebase.zip
    unzip -o Firebase.zip -d MutaroModule/XCFrameworks/
    rm -f Firebase.zip
}

remove_not_target_dependencies() {
    for file in $(ls MutaroModule/XCFrameworks/Firebase/)
    do
        if [[ "${TARGET_FILE_OR_DIR[*]}" =~ "${file}" ]]; then
            echo "Include ${file}"
        else
            rm -rf MutaroModule/XCFrameworks/Firebase/${file}
        fi
    done
}

remove_all_files
install_sdks
remove_not_target_dependencies
echo "Install Firebase SDK Completed !"
