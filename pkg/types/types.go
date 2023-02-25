package types

import "github.com/projectdiscovery/goflags"

type Message struct {
    Domain       string
    Domains      []string
    Aggregated   string
    CaIssuer     string
    Source       string
    SubjectAltName string
}

type Protocols struct {
    DNS         string
    SSL         string
}

type Options struct {
    Templates      goflags.StringSlice
    Validate       bool
    Headless       bool
    PageTimeout    int
    PageScreenShot bool
    Verbose        bool
    Debug          bool
    Version        bool
    Retries        int
    Timeout        int
}

func DefaultOptions() *Options {
    return &Options{
        Timeout: 5,
        Retries: 1,
    }
}
