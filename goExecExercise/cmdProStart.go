package main

import (
	"fmt"
	"os/exec"
)

func main() {
	cmd := exec.Command("cmd", "/C", "notepad.exe")
	err := cmd.Start()
	if err != nil {
		fmt.Println(err)
		return
	}

}
