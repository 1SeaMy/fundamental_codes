package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"net"
	"net/http"
	"os/exec"
	"regexp"
	"strings"
)

type VirusTotalResponse struct {
	Data struct {
		Attributes struct {
			LastAnalysisStats struct {
				Malicious int `json:"malicious"`
			} `json:"last_analysis_stats"`
		} `json:"attributes"`
	} `json:"data"`
}

func checkIP(ip string) (string, error) {
	apiKey := "YOUR_VIRUSTOTAL_API_KEY" // Add your own API key here
	url := fmt.Sprintf("https://www.virustotal.com/api/v3/ip_addresses/%s", ip)
	req, err := http.NewRequest("GET", url, nil)
	if err != nil {
		return "", err
	}
	req.Header.Set("x-apikey", apiKey)

	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		return "", err
	}
	defer resp.Body.Close()

	var vtResponse VirusTotalResponse
	if err := json.NewDecoder(resp.Body).Decode(&vtResponse); err != nil {
		return "", err
	}

	if vtResponse.Data.Attributes.LastAnalysisStats.Malicious > 0 {
		return "Malicious", nil
	} else {
		return "Clean", nil
	}
}

func disconnectIP(ip string) error {
	cmd := exec.Command("iptables", "-A", "INPUT", "-s", ip, "-j", "DROP")
	err := cmd.Run()
	if err != nil {
		return fmt.Errorf("Failed to block IP: %v", err)
	}
	return nil
}

func getHostname(ip string) (string, error) {
	hostnames, err := net.LookupAddr(ip)
	if err != nil {
		return "", err
	}
	if len(hostnames) == 0 {
		return "", fmt.Errorf("No hostname found")
	}
	return hostnames[0], nil
}

func main() {
	cmd := exec.Command("netstat", "-an")
	output, err := cmd.Output()
	if err != nil {
		fmt.Println("Failed to execute command:", err)
		return
	}

	scanner := bufio.NewScanner(strings.NewReader(string(output)))
	ipAddresses := make(map[string]bool)
	re := regexp.MustCompile(`(\d+\.\d+\.\d+\.\d+):\d+`)

	for scanner.Scan() {
		line := scanner.Text()
		matches := re.FindAllStringSubmatch(line, -1)
		for _, match := range matches {
			ip := match[1]
			ipAddresses[ip] = true
		}
	}

	fmt.Println("IP Addresses and Status:")
	fmt.Printf("%-5s %-15s %-15s %-30s %s\n", "No.", "IP Address", "Status", "Hostname", "Domain")

	count := 0
	for ip := range ipAddresses {
		count++
		status, err := checkIP(ip)
		if err != nil {
			fmt.Printf("%-5d %-15s Error: %v\n", count, ip, err)
			continue
		}

		hostname, err := getHostname(ip)
		if err != nil {
			hostname = "N/A"
		}

		fmt.Printf("%-5d %-15s %-15s %-30s\n", count, ip, status, hostname)

		if status == "Malicious" {
			err := disconnectIP(ip)
			if err != nil {
				fmt.Printf("%-5d %-15s Blocking error: %v\n", count, ip, err)
			} else {
				fmt.Printf("%-5d %-15s Blocked.\n", count, ip)
			}
		}
	}

	fmt.Printf("Total records: %d\n", count)

	if err := scanner.Err(); err != nil {
		fmt.Println("Error:", err)
	}
}
