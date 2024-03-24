package main

import (
	"fmt"
	"os/exec"
	"strings"
)

func main() {
	cmd := exec.Command("cmd", "/C", "netstat -f -o")
	output, err := cmd.Output()
	if err != nil {
		fmt.Println("Error executing command:", err)
		return
	}
	var netstatResponse string = string(output)
	netstatRecord := strings.Split(netstatResponse, "\n")
	for index := range netstatRecord {
		if index > 3 {
			fmt.Println(netstatRecord[index])
		}
	}
	fmt.Println("----------------------------------------------------------------------------")
	s := strings.Fields(netstatRecord[4])
	killPID := (s[4])
	fmt.Println(killPID)
	fmt.Println("----------------------------------------------------------------------------")

	cmd1 := exec.Command("cmd", "/C", "taskkill /F /PID", killPID)
	output1, err := cmd1.Output()
	if err != nil {
		fmt.Println("Error executing command:", err)
		return
	}
	fmt.Println(string(output1))
}
