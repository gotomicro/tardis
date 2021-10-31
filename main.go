package main

import (
	"tardis/cmd"

	"github.com/gotomicro/ego/core/elog"
)

//  export EGO_DEBUG=true && go run main.go --config=config.toml
func main() {
	if err := cmd.Run(); err != nil {
		elog.Panic("startup", elog.FieldErr(err))
	}
}
