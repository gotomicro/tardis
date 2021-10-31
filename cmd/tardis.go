package cmd

import (
	"tardis/cmd/admin"
	"tardis/cmd/agent"

	"github.com/gotomicro/ego/core/elog"
	"go.uber.org/zap"

	"github.com/gotomicro/ego"
	"github.com/gotomicro/ego/core/econf"
	"github.com/gotomicro/ego/server/egin"
)

func Run() error {
	e := ego.New()
	var server *egin.Component
	var mode = econf.GetString("app.mode")
	elog.Info("run", zap.String("mode", mode))
	if mode == "agent" {
		server = agent.New()
	} else {
		server = admin.New()
	}
	return e.Serve(server).Run()
}
