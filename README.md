
# MFA | Tool for generating MFA Tokens on the commandline

`mfa` understands TOTP (Time-based One-Time-Password) and is configured using a standard OTP URL like this: `otpauth://totp/ALICE%40ORGANIZATION.COM?secret=ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEF&digits=6&algorithm=SHA1&issuer=ORGANIZATION&period=30`

## Usage

### Generate a token from URL:

`echo $TOKEN | mfa generate`

### Using macOS Keychain to securely store the TOTP URL

- Save the URL as String in your Keychain as Application Password named `service_name-mfa`.
- `security find-generic-password -l service_name-mfa -w | mfa generate`

### Login to AWS using `saml2aws`

`saml2aws login --skip-prompt --mfa-token=$(security find-generic-password -l service_name-mfa -w | mfa generate)`

## Installation

Install mfa by either fetching the latest release from [Releases](https://github.com/mtrense/mfa/releases) or by building it yourself.

### Building mfa

- `git clone https://github.com/mtrense/mfa`
- `cd mfa`
- `make`
- `cp bin/mfa <to_somewhere_in_your_PATH>`
