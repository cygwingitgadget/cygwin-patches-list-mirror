From: egor duda <deo@LOGOS-M.RU>
To: cygwin-patches@cygwin.com
Subject: case-sensitiveness of environment problem
Date: Sun, 15 Apr 2001 23:20:00 -0000
Message-id: <27138147024.20010416101728@logos-m.ru>
X-SW-Source: 2001-q2/msg00071.html
Content-type: multipart/mixed; boundary="----------=_1583532847-65438-44"

This is a multi-part message in MIME format...

------------=_1583532847-65438-44
Content-length: 429

Hi!

  if cygwin environment contains both 'Path' and 'PATH', creating
windows environment from it causes crash due to reallocating memory
object which is externally referenced. this patch fixes that.

i feel that we need a bit more tweaking with environment to deal with
it case-insensitiveness under win32.

egor.            mailto:deo@logos-m.ru icq 5165414 fidonet 2:5020/496.19
env-case-crash.diff
env-case-crash.ChangeLog


------------=_1583532847-65438-44
Content-Type: text/plain; charset=us-ascii; name="env-case-crash.ChangeLog"
Content-Disposition: inline; filename="env-case-crash.ChangeLog"
Content-Transfer-Encoding: base64
Content-Length: 236

MjAwMS0wNC0xNSAgRWdvciBEdWRhICA8ZGVvQGxvZ29zLW0ucnU+CgoJKiBl
bnZpcm9uLmNjICh3aW5lbnYpOiBSZW1vdmUgZXh0ZXJuYWwgcmVmZXJlbmNl
IHRvIGVudmlyb25tZW50CgljYWNoZSB0byBhdm9pZCBjcmFzaCB3aGVuIGVu
dmlyb25tZW50IGNvbnRhaW5zICdQYXRoJyBhbmQgJ1BBVEgnLgo=

------------=_1583532847-65438-44
Content-Type: text/x-diff; charset=us-ascii; name="env-case-crash.diff"
Content-Disposition: inline; filename="env-case-crash.diff"
Content-Transfer-Encoding: base64
Content-Length: 765

SW5kZXg6IGVudmlyb24uY2MKPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1Mg
ZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3aW4vZW52aXJvbi5jYyx2
CnJldHJpZXZpbmcgcmV2aXNpb24gMS40NgpkaWZmIC11IC1wIC0yIC1yMS40
NiBlbnZpcm9uLmNjCi0tLSBlbnZpcm9uLmNjCTIwMDEvMDQvMTIgMjE6MjE6
MzcJMS40NgorKysgZW52aXJvbi5jYwkyMDAxLzA0LzE1IDEzOjMwOjM1CkBA
IC03MzcsNSArNzM3LDkgQEAgd2luZW52IChjb25zdCBjaGFyICogY29uc3Qg
KmVudnAsIGludCBrZQogCiAgICAgICBpZiAoIWtlZXBfcG9zaXggJiYgKGNv
bnYgPSBnZXR3aW5lbnYgKCpzcmNwLCAqc3JjcCArIGxlbikpKQotCSpkc3Rw
ID0gY29udi0+bmF0aXZlOworCXsKKwkgIGNoYXIgKnAgPSAoY2hhciAqKSBh
bGxvY2EgKHN0cmxlbiAoY29udi0+bmF0aXZlKSArIDEpOworCSAgc3RyY3B5
IChwLCBjb252LT5uYXRpdmUpOworCSAgKmRzdHAgPSBwOworCX0KICAgICAg
IGVsc2UKIAkqZHN0cCA9ICpzcmNwOwo=

------------=_1583532847-65438-44--
