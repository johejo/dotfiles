package main

import (
	"log"
	"os"
	"os/signal"
	"syscall"
	"time"
)

func main() {
	go func() {
		sig := make(chan os.Signal, 1)
		signal.Notify(sig, syscall.SIGINT, syscall.SIGQUIT, syscall.SIGKILL)
		log.Fatalf("caught signal: %v", <-sig)
	}()

	log.Printf("pid: %d", os.Getpid())
	i := 0
	for {
		time.Sleep(3 * time.Second)
		log.Printf("loop: %d", i)
		i++
	}
}
