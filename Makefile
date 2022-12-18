.PHONY:	all clean cleanBuildCache

all:
	./gradlew assembleWebsiteProdRelease | tr -d $$'\r'

# clean           - Deletes the build directory.
# cleanBuildCache - Deletes the build cache directory.
clean cleanBuildCache:
	./gradlew $@ | tr -d $$'\r'
