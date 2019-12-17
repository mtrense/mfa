package main

import (
	"fmt"
	"io/ioutil"
	"os"

	"github.com/mtrense/mfa"
	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

var (
	version = "none"
	commit  = "none"
	app     = &cobra.Command{
		Use:   "mfa",
		Short: "Handle MFA tokens",
	}
	cmdGenerate = &cobra.Command{
		Use:   "generate",
		Short: "Generate MFA Token",
		Run:   executeGenerate,
	}
	cmdVersion = &cobra.Command{
		Use:   "version",
		Short: "Show mfas version",
		Run: func(cmd *cobra.Command, args []string) {
			fmt.Printf("Version: %s (ref: %s)\n", version, commit)
		},
	}
)

func init() {
	app.AddCommand(cmdVersion, cmdGenerate)
	viper.SetEnvPrefix("MFA")
	viper.AutomaticEnv()
}

func main() {
	if err := app.Execute(); err != nil {
		panic(err)
	}
}

func executeGenerate(cmd *cobra.Command, args []string) {
	data, err := ioutil.ReadAll(os.Stdin)
	if err != nil {
		panic(err)
	}
	fmt.Println(mfa.GenerateToken(string(data)))
}
