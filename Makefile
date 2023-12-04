# Build and run
run:
	swiftc `find ./Sources -name "*.swift" -maxdepth 4` -o main && ./main

run-fast:
	swiftc -O `find ./Sources -name "*.swift" -maxdepth 4` -o main && ./main

test:
	swift test