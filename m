From: Egor Duda <deo@logos-m.ru>
To: cygwin-patches@sources.redhat.com
Subject: memory leaks in cygheap
Date: Wed, 13 Sep 2000 10:47:00 -0000
Message-id: <19119861671.20000913214625@logos-m.ru>
X-SW-Source: 2000-q3/msg00082.html
Content-type: multipart/mixed; boundary="----------=_1583532846-65437-11"

This is a multi-part message in MIME format...

------------=_1583532846-65437-11
Content-length: 327

Hi!

  running  "gcc -c *.c" in dir with lots of *.c files causes
api_fatal ("couldn't commit memory for cygwin heap")

looks  like  not  all  memory allocated on cygheap got freed. attached
patch fixes this.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
cygheap-leaks.diff
cygheap-leaks.ChangeLog


------------=_1583532846-65437-11
Content-Type: text/plain; charset=us-ascii; name="cygheap-leaks.ChangeLog"
Content-Disposition: inline; filename="cygheap-leaks.ChangeLog"
Content-Transfer-Encoding: base64
Content-Length: 220

MjAwMC0wOS0xMyAgRWdvciBEdWRhICA8ZGVvQGxvZ29zLW0ucnU+CgoJKiBj
aGlsZF9pbmZvLmggKGNoaWxkX2luZm9fc3Bhd246On5jaGlsZF9pbmZvX3Nw
YXduKTogQXZvaWQKCW1lbW9yeSBsZWFrcyBpbiBjeWdoZWFwLgoJKiBzcGF3
bi5jYyAoc3Bhd25fZ3V0cyk6IERpdHRvLgo=

------------=_1583532846-65437-11
Content-Type: text/x-diff; charset=us-ascii; name="cygheap-leaks.diff"
Content-Disposition: inline; filename="cygheap-leaks.diff"
Content-Transfer-Encoding: base64
Content-Length: 2131

SW5kZXg6IHdpbnN1cC9jeWd3aW4vY2hpbGRfaW5mby5oCj09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0KUkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3ln
d2luL2NoaWxkX2luZm8uaCx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS4zCmRp
ZmYgLXUgLXIxLjMgY2hpbGRfaW5mby5oCi0tLSBjaGlsZF9pbmZvLmgJMjAw
MC8wOS8wOCAwMjo1Njo1NAkxLjMKKysrIGNoaWxkX2luZm8uaAkyMDAwLzA5
LzEzIDE3OjI4OjExCkBAIC04Nyw2ICs4NywxMCBAQAogICAgICAgewogCWlm
IChtb3JlaW5mby0+b2xkX3RpdGxlKQogCSAgY2ZyZWUgKG1vcmVpbmZvLT5v
bGRfdGl0bGUpOworICAgICAgICBpZiAobW9yZWluZm8tPmN3ZF9wb3NpeCkK
KyAgICAgICAgICBjZnJlZSAobW9yZWluZm8tPmN3ZF9wb3NpeCk7CisgICAg
ICAgIGlmIChtb3JlaW5mby0+Y3dkX3dpbjMyKQorICAgICAgICAgIGNmcmVl
IChtb3JlaW5mby0+Y3dkX3dpbjMyKTsKIAlpZiAobW9yZWluZm8tPmVudmly
b24pCiAJICB7CiAJICAgIGZvciAoY2hhciAqKmUgPSBtb3JlaW5mby0+ZW52
aXJvbjsgKmU7IGUrKykKSW5kZXg6IHdpbnN1cC9jeWd3aW4vc3Bhd24uY2MK
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2N2cy9zcmMvc3Jj
L3dpbnN1cC9jeWd3aW4vc3Bhd24uY2MsdgpyZXRyaWV2aW5nIHJldmlzaW9u
IDEuMzgKZGlmZiAtdSAtcjEuMzggc3Bhd24uY2MKLS0tIHNwYXduLmNjCTIw
MDAvMDkvMDggMDI6NTY6NTUJMS4zOAorKysgc3Bhd24uY2MJMjAwMC8wOS8x
MyAxNzoyODoxMgpAQCAtNDY2LDggKzQ2NiwxMSBAQAogICAgIH0KIAogICBp
ZiAocmVhbF9wYXRoLmlzY3lnZXhlYyAoKSkKLSAgICBmb3IgKGludCBpID0g
bmV3YXJndi5jYWxsb2NlZDsgaSA8IG5ld2FyZ3YuYXJnYzsgaSsrKQotICAg
ICAgbmV3YXJndltpXSA9IGNzdHJkdXAgKG5ld2FyZ3ZbaV0pOworICAgIHsK
KyAgICAgIGZvciAoaW50IGkgPSBuZXdhcmd2LmNhbGxvY2VkOyBpIDwgbmV3
YXJndi5hcmdjOyBpKyspCisgICAgICAgIG5ld2FyZ3ZbaV0gPSBjc3RyZHVw
IChuZXdhcmd2W2ldKTsKKyAgICAgIG5ld2FyZ3YuY2FsbG9jZWQgPSBuZXdh
cmd2LmFyZ2M7CisgICAgfQogICBlbHNlCiAgICAgewogICAgICAgZm9yIChp
bnQgaSA9IDA7IGkgPCBuZXdhcmd2LmFyZ2M7IGkrKykKQEAgLTQ3Niw3ICs0
NzksMTAgQEAKIAkgIGNvbnN0IGNoYXIgKmE7CiAKIAkgIGlmIChpID49IG5l
d2FyZ3YuY2FsbG9jZWQpCi0JICAgIG5ld2FyZ3ZbaV0gPSBjc3RyZHVwIChu
ZXdhcmd2W2ldKTsKKyAgICAgICAgICAgIHsKKyAgCSAgICAgIG5ld2FyZ3Zb
aV0gPSBjc3RyZHVwIChuZXdhcmd2W2ldKTsKKyAgICAgICAgICAgICAgbmV3
YXJndi5jYWxsb2NlZCA9IGkgKyAxOworICAgICAgICAgICAgfQogCSAgYSA9
IG5ld2FyZ3ZbaV07CiAJICBpbnQgbGVuID0gc3RybGVuIChhKTsKIAkgIGlm
IChsZW4gIT0gMCAmJiAhc3RycGJyayAoYSwgIiBcdFxuXHJcIiIpKQo=

------------=_1583532846-65437-11--
