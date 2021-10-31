package agent

import (
	"github.com/gotomicro/ego/server/egin"
)

func New() *egin.Component {
	server := egin.Load("server.agent").Build()
	return server
}
