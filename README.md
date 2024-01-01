# Retroshare-Autologin

This technique allows us to unfuck retroshare-gui so it can actually work as server-node and autologin on launch (or relogin on crashes) without recompilation so that you can actually update from repos


## Prerequsi... uno that word
`apt install wmctrl xdotool -y`


## We need to remove password from private key
WARNING: Removing password from key is VERY INSECURE in fact its so insecure that you might actually die in the process but you have no other option to get retroshare to autologin anyways so it doesnt matter then.
```
gpg --import ~/.retroshare/retroshare_secret_keyring.gpg
gpg --list-secret-keys --keyid-format=long
gpg --edit-key YOURKEYID
passwd
```
Then set it to empty password.

Now we need to export it
```
gpg --export-secret-key -a > new.key
```
And now we need to dearmor it because retroshare uses binary format
```
gpg --dearmor < new.key > retroshare_secret_keyring.gpg
```
You might as well remove this private key from your PGP keychain if you are concerned

## Now we ready

```
./start-retroshare.sh
```

## How it works

- Bash script starts perl script in another thread then starts retroshare.
- Perl script waits for specific window title which appears only at the start by using wmctrl
- Perl script executes xdotool that sends Return to that window handle (works even when not in focus because its not fukin windows)
- Perl script waits for specific splash window title and exits or if it didnt worked then sends Return again or times out on 100th counter
- Whole bash script loops so that this process starts again when retroshare crashes. You can quit with ctrl+c

## Tested on

Debian 10, Retroshare 0.6.7

## TODO
Test how it behaves with screen locked




