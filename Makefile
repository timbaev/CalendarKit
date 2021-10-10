push:
	pod repo push softam-specs SoftamUI.podspec

lint:
	pod spec lint SoftamUI.podspec --sources='https://Timur-Shafigullin@bitbucket.org/Timur-Shafigullin/softam-specs.git,https://github.com/CocoaPods/Specs.git'

build-framework:
	carthage build --platform iOS --cache-builds --use-xcframeworks --no-use-binaries --no-skip-current