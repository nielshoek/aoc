package solutions

import (
	"os"
	"strings"
)

func textFileToStringArray(path string) ([]string, error) {
	data, err := textFileToString(path)

	if err != nil {
		return make([]string, 0), err
	}

	return strings.Split(data, "\n"), nil
}

func textFileToString(path string) (string, error) {
	data, err := os.ReadFile(path)

	if err != nil {
		return "", err
	}

	return string(data), nil
}
