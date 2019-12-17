package mfa

import (
	"time"

	"github.com/pquerna/otp"
	"github.com/pquerna/otp/totp"
)

func GenerateToken(url string) string {
	key, err := otp.NewKeyFromURL(url)
	if err != nil {
		panic(err)
	}
	token, err := totp.GenerateCodeCustom(key.Secret(), time.Now(), totp.ValidateOpts{
		Period: 30,
		Digits: otp.DigitsSix,
	})
	if err != nil {
		panic(err)
	}
	return token
}
