package main

import (
	"fmt"
	"os/exec"
)

func main() {
	cmd := exec.Command("taskkill", "/f", "/im", "20024")
	err := cmd.Run()
	if err != nil {
		fmt.Printf("err: %v\n", err)
	}
}
