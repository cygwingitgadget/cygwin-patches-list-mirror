From: egor duda <deo@logos-m.ru>
To: cygwin-patches@cygwin.com
Subject: Export asctime_r, ctime_r, gmtime_r, localtime_r
Date: Wed, 25 Apr 2001 05:53:00 -0000
Message-id: <138104313044.20010425165309@logos-m.ru>
X-SW-Source: 2001-q2/msg00159.html
Content-type: multipart/mixed; boundary="----------=_1583532847-65438-51"

This is a multi-part message in MIME format...

------------=_1583532847-65438-51
Content-length: 311

Hi!

2001-04-25  Egor Duda  <deo@logos-m.ru>

        * cygwin.din: Export asctime_r, ctime_r, gmtime_r, localtime_r
        * include/cygwin/version.h: Bump CYGWIN_VERSION_API_MINOR to 39  

egor.            mailto:deo@logos-m.ru icq 5165414 fidonet 2:5020/496.19
time_r-exports.diff
time_r-exports.ChangeLog


------------=_1583532847-65438-51
Content-Type: text/plain; charset=us-ascii; name="time_r-exports.ChangeLog"
Content-Disposition: inline; filename="time_r-exports.ChangeLog"
Content-Transfer-Encoding: base64
Content-Length: 232

MjAwMS0wNC0yNSAgRWdvciBEdWRhICA8ZGVvQGxvZ29zLW0ucnU+CgoJKiBj
eWd3aW4uZGluOiBFeHBvcnQgYXNjdGltZV9yLCBjdGltZV9yLCBnbXRpbWVf
ciwgbG9jYWx0aW1lX3IKCSogaW5jbHVkZS9jeWd3aW4vdmVyc2lvbi5oOiBC
dW1wIENZR1dJTl9WRVJTSU9OX0FQSV9NSU5PUiB0byAzOQo=

------------=_1583532847-65438-51
Content-Type: text/x-diff; charset=us-ascii; name="time_r-exports.diff"
Content-Disposition: inline; filename="time_r-exports.diff"
Content-Transfer-Encoding: base64
Content-Length: 1997

SW5kZXg6IGN5Z3dpbi5kaW4KPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1Mg
ZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3aW4vY3lnd2luLmRpbix2
CnJldHJpZXZpbmcgcmV2aXNpb24gMS4yOApkaWZmIC11IC1wIC0yIC1yMS4y
OCBjeWd3aW4uZGluCi0tLSBjeWd3aW4uZGluCTIwMDEvMDQvMjAgMjM6Mzg6
NDMJMS4yOAorKysgY3lnd2luLmRpbgkyMDAxLzA0LzI1IDEyOjQ4OjU3CkBA
IC0zMyw0ICszMyw2IEBAIF9hbHBoYXNvcnQgPSBhbHBoYXNvcnQKIGFzY3Rp
bWUKIF9hc2N0aW1lID0gYXNjdGltZQorYXNjdGltZV9yCitfYXNjdGltZV9y
ID0gYXNjdGltZV9yCiBhc2luCiBfYXNpbiA9IGFzaW4KQEAgLTEyMCw0ICsx
MjIsNiBAQCBfY3JlYXQgPSBjcmVhdAogY3RpbWUKIF9jdGltZSA9IGN0aW1l
CitjdGltZV9yCitfY3RpbWVfciA9IGN0aW1lX3IKIGN3YWl0CiBfY3dhaXQg
PSBjd2FpdApAQCAtMzY3LDQgKzM3MSw2IEBAIF9nbG9iZnJlZSA9IGdsb2Jm
cmVlCiBnbXRpbWUKIF9nbXRpbWUgPSBnbXRpbWUKK2dtdGltZV9yCitfZ210
aW1lX3IgPSBnbXRpbWVfcgogaF9lcnJubyBEQVRBCiBoeXBvdApAQCAtNDU1
LDQgKzQ2MSw2IEBAIF9sb2NhbGVjb252ID0gbG9jYWxlY29udgogbG9jYWx0
aW1lCiBfbG9jYWx0aW1lID0gbG9jYWx0aW1lCitsb2NhbHRpbWVfcgorX2xv
Y2FsdGltZV9yID0gbG9jYWx0aW1lX3IKIGxvZwogX2xvZyA9IGxvZwpJbmRl
eDogaW5jbHVkZS9jeWd3aW4vdmVyc2lvbi5oCj09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0KUkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL2lu
Y2x1ZGUvY3lnd2luL3ZlcnNpb24uaCx2CnJldHJpZXZpbmcgcmV2aXNpb24g
MS4zNApkaWZmIC11IC1wIC0yIC1yMS4zNCB2ZXJzaW9uLmgKLS0tIHZlcnNp
b24uaAkyMDAxLzA0LzIzIDAwOjQ4OjIzCTEuMzQKKysrIHZlcnNpb24uaAky
MDAxLzA0LzI1IDEyOjQ4OjU4CkBAIC0xMzMsOCArMTMzLDkgQEAgZGV0YWls
cy4gKi8KICAgICAgICAzNzogW2ZdcGF0aGNvbnYgc3VwcG9ydCBfUENfUE9T
SVhfUEVSTUlTU0lPTlMgYW5kIF9QQ19QT1NJWF9TRUNVUklUWQogICAgICAg
IDM4OiB2c2NhbmYsIHZzY2FuZl9yLCBhbmQgcmFuZG9tIHB0aHJlYWQgZnVu
Y3Rpb25zCisgICAgICAgMzk6IGFzY3RpbWVfciwgY3RpbWVfciwgZ210aW1l
X3IsIGxvY2FsdGltZV9yCiAgICAgICovCiAKICNkZWZpbmUgQ1lHV0lOX1ZF
UlNJT05fQVBJX01BSk9SIDAKLSNkZWZpbmUgQ1lHV0lOX1ZFUlNJT05fQVBJ
X01JTk9SIDM4CisjZGVmaW5lIENZR1dJTl9WRVJTSU9OX0FQSV9NSU5PUiAz
OQogCiAgICAgIC8qIFRoZXJlIGlzIGFsc28gYSBjb21wYXRpYml0eSB2ZXJz
aW9uIG51bWJlciBhc3NvY2lhdGVkIHdpdGggdGhlCg==

------------=_1583532847-65438-51--
