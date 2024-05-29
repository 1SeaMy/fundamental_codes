package main

import (
	"crypto/sha256"
	"encoding/hex"
	"fmt"
	"io"
	"io/ioutil"
	"os"
	"path/filepath"
)

func calculateFileHash(filePath string) (string, error) {
	file, err := os.Open(filePath)
	if err != nil {
		return "", err
	}
	defer file.Close()

	hash := sha256.New()
	if _, err := io.Copy(hash, file); err != nil {
		return "", err
	}

	return hex.EncodeToString(hash.Sum(nil)), nil
}

func findAndRemoveDuplicates(dir1, dir2 string) error {
	files1, err := ioutil.ReadDir(dir1)
	if err != nil {
		return err
	}

	files2, err := ioutil.ReadDir(dir2)
	if err != nil {
		return err
	}

	hashMap := make(map[string]string)

	// Process the first directory
	for _, file := range files1 {
		if !file.IsDir() {
			filePath := filepath.Join(dir1, file.Name())
			fileHash, err := calculateFileHash(filePath)
			if err != nil {
				fmt.Printf("Hash hesaplanamadı: %s, hata: %s\n", filePath, err)
				continue
			}

			if _, found := hashMap[fileHash]; found {
				fmt.Printf("Aynı dosya bulundu, siliniyor: %s\n", filePath)
				if err := os.Remove(filePath); err != nil {
					fmt.Printf("Dosya silinemedi: %s, hata: %s\n", filePath, err)
				} else {
					fmt.Printf("Dosya başarıyla silindi: %s\n", filePath)
				}
			} else {
				hashMap[fileHash] = filePath
			}
		}
	}

	// Process the second directory
	for _, file := range files2 {
		if !file.IsDir() {
			filePath := filepath.Join(dir2, file.Name())
			fileHash, err := calculateFileHash(filePath)
			if err != nil {
				fmt.Printf("Hash hesaplanamadı: %s, hata: %s\n", filePath, err)
				continue
			}

			if _, found := hashMap[fileHash]; found {
				fmt.Printf("Aynı dosya bulundu, siliniyor: %s\n", filePath)
				if err := os.Remove(filePath); err != nil {
					fmt.Printf("Dosya silinemedi: %s, hata: %s\n", filePath, err)
				} else {
					fmt.Printf("Dosya başarıyla silindi: %s\n", filePath)
				}
			} else {
				hashMap[fileHash] = filePath
			}
		}
	}

	return nil
}

func main() {
	dir1 := "C:\\Users\\Asus Rog\\go\\getfilehash\\dir1"
	dir2 := "C:\\Users\\Asus Rog\\go\\getfilehash\\dir2"
	if err := findAndRemoveDuplicates(dir1, dir2); err != nil {
		fmt.Printf("Hata: %s\n", err)
	} else {
		fmt.Println("Kopya dosyalar silindi.")
	}
}
