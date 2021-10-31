package admin

import (
	"tardis/api/admin/controller"

	"github.com/gotomicro/ego/server/egin"
)

func Init(e *egin.Component) {
	v1 := e.Group("/v1")

	snapshot := controller.Snapshot{}
	g := v1.Group("/snapshot")
	g.GET("/", snapshot.List)
	g.GET("/:id", snapshot.Get)
	g.POST("/:id", snapshot.Save)
}
