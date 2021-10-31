package adapter

type Provider interface {
	Load(params ...KV) ([]Data, error)
	Save(data ...Data) error
	Delete(data Data) error
}
