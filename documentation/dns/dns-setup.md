
# DNS Configuration and Management Using BIND9

## 1. Project Overview

This document describes the installation, configuration, and validation of a local DNS server using BIND9 on Ubuntu running under WSL2.

The lab demonstrates forward DNS resolution, reverse DNS resolution, and commonly used DNS resource records.

### Objectives

- Install and configure BIND9.
- Configure a primary forward lookup zone.
- Configure a reverse lookup zone.
- Create and test A, AAAA, NS, SOA, CNAME, MX, and PTR records.
- Validate DNS configuration and troubleshoot resolution failures.

### Environment

| Component | Configuration |
|---|---|
| Operating System | Ubuntu 26.04.1 LTS |
| Environment | WSL2 |
| DNS Server | BIND9 |
| DNS Server Address | 127.0.0.1 |
| Forward Zone | lab.local |
| Reverse Zone | 0.0.127.in-addr.arpa |
| DNS Port | 53 |

**Note:** This is a local DNS lab. It is not a publicly accessible production DNS server.

---

## 2. Install BIND9

Update the package repository:

```bash
sudo apt update
```

Install BIND9 and DNS utilities:

```bash
sudo apt install bind9 bind9-utils dnsutils -y
```

Check the BIND9 service:

```bash
sudo systemctl status bind9
```

Check the installed version:

```bash
named -v
```

---

## 3. Configure DNS Forwarders

Open the BIND9 options configuration:

```bash
sudo nano /etc/bind/named.conf.options
```

Configure the forwarders in the options section:

```conf
forwarders {
    8.8.8.8;
    1.1.1.1;
};

forward only;

allow-query { localhost; };
```

The forwarders are used for queries that the local DNS server cannot resolve from its own zones.

- 8.8.8.8 – Google Public DNS
- 1.1.1.1 – Cloudflare Public DNS
- forward only – forwards external queries to the configured DNS servers.
- allow-query – restricts queries to localhost.

---

## 4. Configure the Forward Lookup Zone

Open the local BIND9 zone configuration:

```bash
sudo nano /etc/bind/named.conf.local
```

Configure both the forward and reverse zones:

```conf
zone "lab.local" {
    type master;
    file "/etc/bind/db.lab.local";
    allow-update { none; };
};

zone "0.0.127.in-addr.arpa" {
    type master;
    file "/etc/bind/db.127";
};
```

The forward zone resolves domain names into IP addresses.

The reverse zone resolves IP addresses into domain names.

---

## 5. Configure Forward Zone Records

Create or edit the forward zone file:

```bash
sudo nano /etc/bind/db.lab.local
```

Configuration:

```dns
$TTL 86400

@   IN  SOA ns1.lab.local. admin.lab.local. (
        2026111802
        3600
        1800
        604800
        86400
)

@       IN  NS      ns1.lab.local.

; A records
@       IN  A       127.0.0.1
ns1     IN  A       127.0.0.1
www     IN  A       127.0.0.1
mail    IN  A       127.0.0.1

; AAAA records
ns1     IN  AAAA    ::1
www     IN  AAAA    ::1

; CNAME record
ftp     IN  CNAME   www.lab.local.

; MX record
@       IN  MX      10 mail.lab.local.
```

### Explanation of DNS Resource Records

| Record | Purpose | Lab example |
|---|---|---|
| A | Maps a hostname to an IPv4 address | www → 127.0.0.1 |
| AAAA | Maps a hostname to an IPv6 address | www → ::1 |
| NS | Identifies the authoritative name server | ns1.lab.local |
| SOA | Stores zone authority and timing information | ns1.lab.local |
| CNAME | Creates an alias for another hostname | ftp → www.lab.local |
| MX | Identifies a mail exchanger | mail.lab.local |
| PTR | Maps an IP address to a hostname | 127.0.0.1 → ns1.lab.local |

### Understanding IN

IN means Internet. It is the DNS record class, not a resource record type.

For example:

```dns
www IN A 127.0.0.1
```

Here:
- www is the hostname.
- IN is the Internet class.
- A is the record type.
- 127.0.0.1 is the IPv4 address.

---

## 6. Configure Reverse DNS Lookup

Create the reverse zone file:

```bash
sudo nano /etc/bind/db.127
```

Add the following configuration:

```dns
$TTL 86400

@   IN  SOA ns1.lab.local. admin.lab.local. (
        2026111802
        3600
        1800
        604800
        86400
)

@   IN  NS      ns1.lab.local.

1   IN  PTR     ns1.lab.local.
```

### Explanation

A reverse DNS lookup converts an IP address into a hostname.

For this lab:

```text
127.0.0.1 → ns1.lab.local
```

The reverse zone uses the special DNS namespace:

```text
0.0.127.in-addr.arpa
```

---

## 7. Validate DNS Configuration

Before restarting BIND9, validate the configuration.

### Check the main configuration

```bash
sudo named-checkconf
```

No output indicates that no configuration syntax errors were found.

### Validate the forward zone

```bash
sudo named-checkzone lab.local /etc/bind/db.lab.local
```

Expected result:

```text
zone lab.local/IN: loaded serial 2026111802
OK
```

### Validate the reverse zone

```bash
sudo named-checkzone 0.0.127.in-addr.arpa /etc/bind/db.127
```

Expected result:

```text
zone 0.0.127.in-addr.arpa/IN: loaded serial 2026111802
OK
```

---

## 8. Restart and Verify BIND9

Restart the DNS service:

```bash
sudo systemctl restart bind9
```

Check service status:

```bash
sudo systemctl status bind9 --no-pager
```

Expected service state:

```text
Active: active (running)
```

Check whether DNS is listening on port 53:

```bash
sudo ss -tulnp | grep ':53'
```

---

## 9. Test DNS Resolution

Use the dig command to test the DNS records against the local DNS server.

### Test A record

```bash
dig @127.0.0.1 lab.local A
```

Expected answer:

```text
lab.local. 86400 IN A 127.0.0.1
```

### Test AAAA record

```bash
dig @127.0.0.1 www.lab.local AAAA
```

Expected answer:

```text
www.lab.local. 86400 IN AAAA ::1
```

### Test CNAME record

```bash
dig @127.0.0.1 ftp.lab.local CNAME
```

Expected answer:

```text
ftp.lab.local. 86400 IN CNAME www.lab.local.
```

### Test MX record

```bash
dig @127.0.0.1 lab.local MX
```

Expected answer:

```text
lab.local. 86400 IN MX 10 mail.lab.local.
```

### Test reverse DNS lookup

```bash
dig @127.0.0.1 -x 127.0.0.1
```

Expected answer:

```text
1.0.0.127.in-addr.arpa. 86400 IN PTR ns1.lab.local.
```

### Test NS record

```bash
dig @127.0.0.1 lab.local NS
```

### Test SOA record

```bash
dig @127.0.0.1 lab.local SOA
```

---

## 10. DNS Troubleshooting

| Problem | Possible cause | Troubleshooting |
|---|---|---|
| DNS service fails | Configuration error | named-checkconf |
| Zone fails to load | Incorrect zone file | named-checkzone |
| NXDOMAIN response | Missing DNS record or incorrect zone | Check zone file and named.conf.local |
| DNS query times out | DNS service not listening | Check systemctl and port 53 |
| Incorrect DNS response | Incorrect record or stale zone data | Check zone file and restart BIND9 |
| Reverse lookup fails | Incorrect reverse zone or PTR record | Check db.127 |

Useful troubleshooting commands:

```bash
sudo journalctl -u bind9 -n 50 --no-pager
```

```bash
sudo systemctl restart bind9
```

```bash
sudo named-checkconf
```

```bash
sudo named-checkzone lab.local /etc/bind/db.lab.local
```

---

## 11. Important Lab Limitations

- This DNS server runs locally inside Ubuntu WSL2.
- The A and MX-related address records use 127.0.0.1, which is the IPv4 loopback address.
- The AAAA records use ::1, which is the IPv6 loopback address.
- The PTR record is configured for the loopback address 127.0.0.1.
- The MX record identifies a mail exchanger but does not install or configure a mail server.
- No public domain delegation or publicly accessible DNS hosting is configured.
- The zone uses the .local suffix for this demonstration. .local is reserved for multicast DNS (mDNS), so it is not recommended for general unicast DNS deployments. A future version of this lab should use a reserved testing domain such as lab.test.

---

## 12. Project Outcome

Successfully configured and tested a local DNS server using BIND9.

Completed tasks:

- Installed BIND9 and DNS utilities.
- Configured DNS forwarders.
- Created a forward lookup zone.
- Created a reverse lookup zone.
- Configured A, AAAA, NS, SOA, CNAME, MX, and PTR records.
- Validated DNS configuration using named-checkconf and named-checkzone.
- Restarted and verified the BIND9 service.
- Tested forward and reverse DNS resolution using dig.

**Result:** All five DNS query tests (A, AAAA, CNAME, MX, and PTR) returned successful authoritative responses in the local lab.

---

## References

- BIND 9 Documentation: https://bind9.readthedocs.io/
- Ubuntu Server Documentation: https://documentation.ubuntu.com/server/
- DNS utilities manual: https://bind9.readthedocs.io/en/latest/manpages.html
