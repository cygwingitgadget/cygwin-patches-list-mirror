From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
Subject: fix dlclose()
Date: Sun, 03 Jun 2001 00:20:00 -0000
Message-id: <015901c0ebfd$8fb5e650$0200a8c0@lifelesswks>
X-SW-Source: 2001-q2/msg00273.html
Content-type: multipart/mixed; boundary="----------=_1583532848-65438-62"

This is a multi-part message in MIME format...

------------=_1583532848-65438-62
Content-length: 183

Sun Jun  3 17:17:00 2001  Robert Collins <rbtcollins@hotmail.com>

    * dlfcn.cc (dlclose): If the symbol to close was obtained by
dlopen(NULL,...)
    do not call FreeLibrary.

Rob

------------=_1583532848-65438-62
Content-Type: text/x-diff; charset=us-ascii; name="fixdlclose.patch"
Content-Disposition: inline; filename="fixdlclose.patch"
Content-Transfer-Encoding: base64
Content-Length: 989

SW5kZXg6IGRsZmNuLmNjCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KUkNTIGZp
bGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL2RsZmNuLmNjLHYKcmV0
cmlldmluZyByZXZpc2lvbiAxLjEyCmRpZmYgLXUgLXAgLXIxLjEyIGRsZmNu
LmNjCi0tLSBkbGZjbi5jYwkyMDAxLzAzLzI2IDAxOjE2OjExCTEuMTIKKysr
IGRsZmNuLmNjCTIwMDEvMDYvMDMgMDc6MTc6MDMKQEAgLTEyOSwxMCArMTI5
LDEyIEBAIGRsY2xvc2UgKHZvaWQgKmhhbmRsZSkKICAgU2V0UmVzb3VyY2VM
b2NrKExPQ0tfRExMX0xJU1QsUkVBRF9MT0NLfFdSSVRFX0xPQ0ssIiBkbGNs
b3NlIik7CiAKICAgaW50IHJldCA9IC0xOwotICBpZiAoRnJlZUxpYnJhcnkg
KChITU9EVUxFKSBoYW5kbGUpKQorICB2b2lkICp0ZW1waGFuZGxlID0gKHZv
aWQgKikgR2V0TW9kdWxlSGFuZGxlIChOVUxMKTsKKyAgaWYgKHRlbXBoYW5k
bGUgPT0gaGFuZGxlIHx8IEZyZWVMaWJyYXJ5ICgoSE1PRFVMRSkgaGFuZGxl
KSkKICAgICByZXQgPSAwOwogICBpZiAocmV0KQogICAgIHNldF9kbF9lcnJv
ciAoImRsY2xvc2UiKTsKKyAgQ2xvc2VIYW5kbGUgKChITU9EVUxFKSB0ZW1w
aGFuZGxlKTsKIAogICBSZWxlYXNlUmVzb3VyY2VMb2NrKExPQ0tfRExMX0xJ
U1QsUkVBRF9MT0NLfFdSSVRFX0xPQ0ssIiBkbGNsb3NlIik7CiAgIHJldHVy
biByZXQ7Cg==

------------=_1583532848-65438-62--
