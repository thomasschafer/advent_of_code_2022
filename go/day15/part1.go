package day15

import "github.com/thomasschafer/advent_of_code_2022/utils"

func Part1(filePath string) int {
	rows := utils.RowsFromFile(filePath)
	return len(rows)
}
