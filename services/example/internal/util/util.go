package util

import (
	"fmt"
	"math/rand"
)

func Name() string {
	return fmt.Sprintf("%s %d", "example", rand.Intn(1000))
}
