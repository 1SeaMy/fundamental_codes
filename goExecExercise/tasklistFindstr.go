package main

import (
	"fmt"
	"os/exec"
)

func main() {
	exec.Command("cmd", "/C", "notepad.exe").Start()

	cmd := exec.Command("cmd", "/C", "tasklist|findstr "+"Notepad"+"")
	output, err := cmd.Output()
	if err != nil {
		fmt.Println("Error executing command:", err)
		return
	}

	fmt.Println(string(output))
}
