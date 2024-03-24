package main

import (
	"fmt"
	"os/exec"
	"time"
)

func main() {
	cmd := exec.Command("cmd", "/C", "pause")
	err := cmd.Start()
	if err != nil {
		fmt.Println(err)
		return
	}
	fmt.Println(cmd.Process.Pid)

	<-time.After(5 * time.Second)
	err = cmd.Process.Kill()
	if err != nil {
		fmt.Println(err)
	}
	fmt.Println("Process killed with PID:", cmd.Process.Pid)
}
