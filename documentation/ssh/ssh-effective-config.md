# SSH Effective Configuration

## Configuration Source
- Main file: /etc/ssh/sshd_config
- Additional configuration: /etc/ssh/sshd_config.d/

## Effective Settings

| Setting | Value |
|---|---|
| Port | 22 |
| PermitRootLogin | prohibit-password |
| PubkeyAuthentication | yes |
| PasswordAuthentication | yes |
| KbdInteractiveAuthentication | no |

## Verification Command

sudo sshd -T

## Security Notes
- SSH listens on port 22.
- Public-key authentication is enabled.
- Password authentication is enabled in this lab.
- Root password login is prohibited.

## Learning Outcome
Understand the difference between the SSH configuration file and effective SSH daemon settings.
