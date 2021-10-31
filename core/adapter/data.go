package adapter

type Dirty interface {
	Dirty() bool
}

type KV interface {
	Dirty
	Key() string
	Val() interface{}
}

type Data interface {
	Dirty
	Namespace() string
	KVs() []KV
	Set(key string, val interface{})
	Get(key string) interface{}
}

type Marshaller interface {
	Marshal(data Data) ([]byte, error)
	Unmarshal(src []byte, dst Data) error
}
