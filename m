From: Egor Duda <deo@logos-m.ru>
To: cygwin-patches@cygwin.com
Subject: race in tty handling code
Date: Thu, 22 Feb 2001 03:05:00 -0000
Message-id: <2170208116.20010222140316@logos-m.ru>
X-SW-Source: 2001-q1/msg00106.html
Content-type: multipart/mixed; boundary="----------=_1583532846-65438-11"

This is a multi-part message in MIME format...

------------=_1583532846-65438-11
Content-length: 634

Hi!

  if  application performs write to tty with ONLCR flag turned off and
  then    immediately    calls    tcsetattr    to    turn    it    on,
fhandler_pty_master::process_slave_output     gets    confused.   it
calculates rlen according to old tty settings and signals output_done
event.  then  it process the buffer according to new tty settings, and
stumbles  over  internal  error  message. Patch attached  (well,  this
time  i  triple-checked  that  it does contain changelog entry :)

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
tty-write-tcsetattr-race.ChangeLog
tty-write-tcsetattr-race.diff


------------=_1583532846-65438-11
Content-Type: text/plain; charset=us-ascii;
 name="tty-write-tcsetattr-race.ChangeLog"
Content-Disposition: inline; filename="tty-write-tcsetattr-race.ChangeLog"
Content-Transfer-Encoding: base64
Content-Length: 244

MjAwMS0wMi0yMiAgRWdvciBEdWRhICA8ZGVvQGxvZ29zLW0ucnU+CgoJKiBm
aGFuZGxlcl90dHkuY2MgKGZoYW5kbGVyX3B0eV9tYXN0ZXI6OnByb2Nlc3Nf
c2xhdmVfb3V0cHV0KToKCVNpZ25hbCB0aGF0IG91dHB1dCBpcyBkb25lIG9u
bHkgYWZ0ZXIgYnVmZmVyIGNvbnZlcnNpb24gdG8gYXZvaWQKCXJhY2UuCg==

------------=_1583532846-65438-11
Content-Type: text/x-diff; charset=us-ascii;
 name="tty-write-tcsetattr-race.diff"
Content-Disposition: inline; filename="tty-write-tcsetattr-race.diff"
Content-Transfer-Encoding: base64
Content-Length: 2009

SW5kZXg6IGZoYW5kbGVyX3R0eS5jYwo9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
ClJDUyBmaWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dpbi9maGFuZGxl
cl90dHkuY2MsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMjMKZGlmZiAtdSAt
cCAtMiAtcjEuMjMgZmhhbmRsZXJfdHR5LmNjCi0tLSBmaGFuZGxlcl90dHku
Y2MJMjAwMC8xMC8xNyAwMTo0MjowNAkxLjIzCisrKyBmaGFuZGxlcl90dHku
Y2MJMjAwMS8wMi8yMiAxMDo1MzoyNApAQCAtMjg4LDkgKzI4OCwxMSBAQCBm
aGFuZGxlcl9wdHlfbWFzdGVyOjpwcm9jZXNzX3NsYXZlX291dHB1CiAgICAg
ICB0ZXJtaW9zX3ByaW50ZiAoImJ5dGVzIHJlYWQgJXUiLCBuKTsKICAgICAg
IGdldF90dHlwICgpLT53cml0ZV9lcnJvciA9IDA7Ci0gICAgICBpZiAob3V0
cHV0X2RvbmVfZXZlbnQgIT0gTlVMTCkKLQlTZXRFdmVudCAob3V0cHV0X2Rv
bmVfZXZlbnQpOwogCiAgICAgICBpZiAoZ2V0X3R0eXAgKCktPnRpLmNfbGZs
YWcgJiBGTFVTSE8pCi0JY29udGludWU7CisgICAgICAgIHsKKyAgICAgICAg
ICBpZiAob3V0cHV0X2RvbmVfZXZlbnQgIT0gTlVMTCkKKyAgICAgICAgICAg
IFNldEV2ZW50IChvdXRwdXRfZG9uZV9ldmVudCk7CisgICAgICAgICAgY29u
dGludWU7CisgICAgICAgIH0KIAogICAgICAgY2hhciAqb3B0cjsKQEAgLTM0
Miw2ICszNDQsMTEgQEAgZmhhbmRsZXJfcHR5X21hc3Rlcjo6cHJvY2Vzc19z
bGF2ZV9vdXRwdQogCSAgICAgIGlmIChvcHRyIC0gYnVmID49IChpbnQpIGxl
bikKIAkJeworICAgICAgICAgICAgICAgICAgLyogRklYTUU6IHdlIHNob3Vs
ZCBzaG93ICJpbnRlcm5hbCBlcnJvciIgbWVzc2FnZSB0byB0aGUKKyAgICAg
ICAgICAgICAgICAgICAgIHVzZXIsIGJ1dCBzeXN0ZW1fcHJpbnRmKCkgZG9l
c24ndCB3b3JrIGhlcmUsIGJlY2F1c2UKKyAgICAgICAgICAgICAgICAgICAg
IGl0IHdyaXRlcyB0byBTVERfRVJSX0hBTkRMRSwgd2hpY2ggaXMgYSBwaXBl
IHdlJ3JlCisgICAgICAgICAgICAgICAgICAgICBjdXJyZW50bHkgcmVhZGlu
ZyBmcm9tISAqLwogCQkgIGlmICgqaXB0ciAhPSAnXG4nIHx8IG4gIT0gMCkK
LQkJICAgIHN5c3RlbV9wcmludGYgKCJpbnRlcm5hbCBlcnJvcjogJWQgdW5l
eHBlY3RlZCBjaGFyYWN0ZXJzIiwgbik7CisJCSAgICB0ZXJtaW9zX3ByaW50
ZiAoImludGVybmFsIGVycm9yOiAlZCB1bmV4cGVjdGVkIGNoYXJhY3RlcnMi
LCBuKTsKKwogCQkgIG5lZWRfbmwgPSAxOwogCQkgIGJyZWFrOwpAQCAtMzUy
LDQgKzM1OSw2IEBAIGZoYW5kbGVyX3B0eV9tYXN0ZXI6OnByb2Nlc3Nfc2xh
dmVfb3V0cHUKIAl9CiAgICAgICByYyA9IG9wdHIgLSBidWY7CisgICAgICBp
ZiAob3V0cHV0X2RvbmVfZXZlbnQgIT0gTlVMTCkKKyAgICAgICAgU2V0RXZl
bnQgKG91dHB1dF9kb25lX2V2ZW50KTsKICAgICAgIGJyZWFrOwogCg==

------------=_1583532846-65438-11--
