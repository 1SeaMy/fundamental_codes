package main

import (
	"fmt"
	"os/exec"
)

func main() {
	cmd := exec.Command("cmd", "/C", "taskkill /F /PID 12864")
	err := cmd.Run()
	if err != nil {
		fmt.Printf("err: %v\n", err)
	}
}
