package solutions

import (
	"fmt"
	"math"
	"strconv"
	"strings"
)

func Run5() {
	data, err := textFileToStringArray("../Inputs/day5.txt")

	if err != nil {
		fmt.Println("Error reading input file.")
	}

	result := part2(data)

	fmt.Printf("Part 2: %v\n", result)
}

type MappingRange struct {
	low  int
	high int
	diff int
}

func part2(data []string) int {
	parts := split(data)
	seeds := getSeeds(data[0])
	mappings := [][]*MappingRange{}
	for _, mappingConfig := range parts[1:] {
		mappingRanges := createMappingRanges(mappingConfig)
		mappings = append(mappings, mappingRanges)
	}

	minValue := math.MaxInt
	for seedIndex := 0; seedIndex < len(seeds); seedIndex += 2 {
		fmt.Printf("Seed range %v\n", seedIndex)
		seed := seeds[seedIndex]
		seedMax := seed + seeds[seedIndex+1]
		for seedValue := seed; seedValue <= seedMax; seedValue++ {
			currentValue := seedValue
			for _, mapping := range mappings {
				for _, mappingRange := range mapping {
					if mappingRange.low < currentValue && mappingRange.high > currentValue {
						currentValue += mappingRange.diff
						break
					}
				}
			}
			if currentValue < minValue {
				minValue = currentValue
			}
		}
	}

	return minValue
}

func createMappingRanges(mappingConfig []string) []*MappingRange {
	result := []*MappingRange{}
	for _, line := range mappingConfig[1:] {
		values := strings.Split(line, " ")
		dest, _ := strconv.Atoi(values[0])
		src, _ := strconv.Atoi(values[1])
		rangeLength, _ := strconv.Atoi(values[2])
		low := src
		high := src + rangeLength - 1
		diff := dest - src
		result = append(result, &MappingRange{
			low:  low,
			high: high,
			diff: diff,
		})
	}

	return result
}

func split(lines []string) [][]string {
	result := [][]string{}
	next := []string{}
	for _, line := range lines {
		if line != "" {
			next = append(next, line)
		} else {
			result = append(result, next)
			next = []string{}
		}
	}
	result = append(result, next)

	return result
}

func getSeeds(line string) []int {
	rightSegment := strings.Split(line, ": ")[1]
	seedNrs := strings.Split(rightSegment, " ")
	ints := make([]int, len(seedNrs))
	for i, s := range seedNrs {
		ints[i], _ = strconv.Atoi(s)
	}
	return ints
}
