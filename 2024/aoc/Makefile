# Build and run
run:
	swiftc `find ./Sources -name "*.swift" -maxdepth 4` -o main && ./main

runf:
	swiftc -O `find ./Sources -name "*.swift" -maxdepth 4` -o main && ./main

test:
	swift test

swiftf:
	swift run -Xswiftc -O

swiftd:
	swift run

bm:
	time ./.build/debug/aoc