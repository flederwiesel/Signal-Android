.PHONY:	all clean cleanBuildCache help

all:
	./gradlew assembleWebsiteProdRelease | tr -d $$'\r'

clean cleanBuildCache:
	./gradlew $@ | tr -d $$'\r'

help:
	@echo
	@echo "Makefile wrapper for gradle"
	@echo
	@echo "Build targets:"
	@echo
	@echo "    all             - Build 'assembleWebsiteProdRelease'"
	@echo "    clean           - Delete the build directory."
	@echo "    cleanBuildCache - Delete the build cache directory."
	@echo "    help            - Show this text"
