package admin

import (
	"tardis/api/admin"

	"github.com/gotomicro/ego/server/egin"
)

func New() *egin.Component {
	server := egin.Load("server.admin").Build()
	admin.Init(server)
	return server
}
