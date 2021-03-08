package main

import (
	"fmt"
	"log"
	"os"
	"os/exec"

	"net/http"

	"gopkg.in/go-playground/webhooks.v5/github"
)

const (
	path = "/"
)

func main() {
	hook, _ := github.New(github.Options.Secret(os.Getenv("WEBHOOK_SECRET")))

	http.HandleFunc(path, func(w http.ResponseWriter, r *http.Request) {
		payload, err := hook.Parse(r, github.PushEvent)
		if err != nil {
			if err == github.ErrEventNotFound {
				fmt.Printf("got err, %+v\n", err)
			}
		}
		switch payload.(type) {

		case github.PushPayload:
			cmd := exec.Command("sh", "-c", "./start.sh")
			if output, err := cmd.CombinedOutput(); err != nil {
				fmt.Printf("got err, %+v\n", err)
			} else {
				fmt.Println(string(output))
			}
		}
	})
	http.ListenAndServe(":80", nil)
}
