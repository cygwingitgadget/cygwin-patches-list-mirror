From: egor duda <deo@logos-m.ru>
To: cygwin-patches@cygwin.com
Subject: mkdir ((char*) -1, 0777) returns ECASECLASH
Date: Thu, 19 Apr 2001 05:22:00 -0000
Message-id: <122419105832.20010419162011@logos-m.ru>
X-SW-Source: 2001-q2/msg00121.html
Content-type: multipart/mixed; boundary="----------=_1583532847-65438-49"

This is a multi-part message in MIME format...

------------=_1583532847-65438-49
Content-length: 160

Hi!

  instead of EFAULT. Fix attached.

egor.            mailto:deo@logos-m.ru icq 5165414 fidonet 2:5020/496.19
path-conv-init.diff
path-conv-init.ChangeLog


------------=_1583532847-65438-49
Content-Type: text/plain; charset=us-ascii; name="path-conv-init.ChangeLog"
Content-Disposition: inline; filename="path-conv-init.ChangeLog"
Content-Transfer-Encoding: base64
Content-Length: 147

MjAwMS0wNC0xOSAgRWdvciBEdWRhICA8ZGVvQGxvZ29zLW0ucnU+CgoJKiBw
YXRoLmNjIChwYXRoX2NvbnY6OmNoZWNrKTogQWx3YXlzIGluaXRpYWxpemUg
bWVtYmVyIHZhcmlhYmxlcy4K

------------=_1583532847-65438-49
Content-Type: text/x-diff; charset=us-ascii; name="path-conv-init.diff"
Content-Disposition: inline; filename="path-conv-init.diff"
Content-Transfer-Encoding: base64
Content-Length: 1013

SW5kZXg6IHBhdGguY2MKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmls
ZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3aW4vcGF0aC5jYyx2CnJldHJp
ZXZpbmcgcmV2aXNpb24gMS4xMjYKZGlmZiAtdSAtcCAtMiAtcjEuMTI2IHBh
dGguY2MKLS0tIHBhdGguY2MJMjAwMS8wNC8xOCAyMToxMDoxMgkxLjEyNgor
KysgcGF0aC5jYwkyMDAxLzA0LzE5IDEyOjE2OjI2CkBAIC0yMzAsNCArMjMw
LDEwIEBAIHBhdGhfY29udjo6Y2hlY2sgKGNvbnN0IGNoYXIgKnNyYywgdW5z
aWcKICAgY2hhciAqcmVsX3BhdGgsICpmdWxsX3BhdGg7CiAKKyAgY2FzZV9j
bGFzaCA9IEZBTFNFOworICBwYXRoX2ZsYWdzID0gMDsKKyAga25vd25fc3Vm
Zml4ID0gTlVMTDsKKyAgZGV2biA9IHVuaXQgPSAwOworICBmaWxlYXR0ciA9
IChEV09SRCkgLTE7CisKICAgaWYgKCEob3B0ICYgUENfTlVMTEVNUFRZKSkK
ICAgICBlcnJvciA9IDA7CkBAIC0yNDIsOCArMjQ4LDQgQEAgcGF0aF9jb252
OjpjaGVjayAoY29uc3QgY2hhciAqc3JjLCB1bnNpZwogICAvKiBUaGlzIGxv
b3AgaGFuZGxlcyBzeW1saW5rIGV4cGFuc2lvbi4gICovCiAgIGludCBsb29w
ID0gMDsKLSAgcGF0aF9mbGFncyA9IDA7Ci0gIGtub3duX3N1ZmZpeCA9IE5V
TEw7Ci0gIGZpbGVhdHRyID0gKERXT1JEKSAtMTsKLSAgY2FzZV9jbGFzaCA9
IEZBTFNFOwogICBmb3IgKDs7KQogICAgIHsK

------------=_1583532847-65438-49--
