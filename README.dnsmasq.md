## How to install Dnsmasq

### On OSX

See https://passingcuriosity.com/2013/dnsmasq-dev-osx/

```
# Update your homebrew installation
brew up
# Install dnsmasq
brew install dnsmasq
```

After this, brew will give you instructions of what to do next (copy config files, runtime configuration...). Run those.

Configure Dnsqmasq, the default config file is in ```/usr/local/etc/dnsmasq.conf```, just below the line ```#address=/double-click.net/127.0.0.1``` add the following and save the file.

```
address=/oist.dev/127.0.0.1
address=/dev/127.0.0.1
```

Then, restart dnsmasq:

```
brew services restart dnsmasq
```

After that, query the DNS using ```dig``` to verify the requests are passed to localhost:

```
dig test.oist.dev @127.0.0.1
```

The result should show (among other things) something like:

```
;; ANSWER SECTION:
test.oist.dev.		0	IN	A	127.0.0.1
```

Now we add resolvers to handle the DNS queries.

```
sudo mkdir -p /etc/resolver/

sudo tee /etc/resolver/dev >/dev/null <<EOF
nameserver 127.0.0.1
EOF

sudo tee /etc/resolver/oist.dev >/dev/null <<EOF
nameserver 127.0.0.1
EOF
```

Finally, we test the ping response:

```
ping anything.oist.dev
PING anything.oist.dev (127.0.0.1): 56 data bytes
64 bytes from 127.0.0.1: icmp_seq=0 ttl=64 time=0.037 ms
64 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=0.142 ms
```
