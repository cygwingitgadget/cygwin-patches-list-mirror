From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
Subject: tzname
Date: Mon, 26 Mar 2001 22:13:00 -0000
Message-id: <EA18B9FA0FE4194AA2B4CDB91F73C0EF02E2B2@itdomain002.itdomain.net.au>
X-SW-Source: 2001-q1/msg00248.html
Content-type: multipart/mixed; boundary="----------=_1583532846-65438-32"

This is a multi-part message in MIME format...

------------=_1583532846-65438-32
Content-length: 153

http://www.opengroup.org/onlinepubs/7908799/xsh/tzset.html
specifies tzname, not _tzname. Also attached is a little test program
written from the specs.

------------=_1583532846-65438-32
Content-Type: text/plain; charset=us-ascii; name="tz.changelog"
Content-Disposition: inline; filename="tz.changelog"
Content-Transfer-Encoding: base64
Content-Length: 265

MjAwMS0wMy0yMSAgUm9iZXJ0IENvbGxpbnMgIDxyYnRjb2xsaW5zQGhvdG1h
aWwuY29tPgoKCWh0dHA6Ly93d3cub3Blbmdyb3VwLm9yZy9vbmxpbmVwdWJz
Lzc5MDg3OTkveHNoL3R6c2V0Lmh0bWwgCglzcGVjaWZpZXMgdHpuYW1lLCBu
b3QgX3R6bmFtZS4gRGVmaW5lIHR6bmFtZSB0byBfdHpuYW1lIGlmIGl0IGlz
IG5vdCBkZWZpbmVkLgo=

------------=_1583532846-65438-32
Content-Type: text/x-diff; charset=us-ascii; name="tz.patch"
Content-Disposition: inline; filename="tz.patch"
Content-Transfer-Encoding: base64
Content-Length: 720

SW5kZXg6IGluY2x1ZGUvdGltZS5oCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0K
UkNTIGZpbGU6IC9jdnMvc3JjL3NyYy9uZXdsaWIvbGliYy9pbmNsdWRlL3Rp
bWUuaCx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS40CmRpZmYgLXUgLXAgLXIx
LjQgdGltZS5oCi0tLSB0aW1lLmgJMjAwMC8xMi8xMiAwMToyNDowOAkxLjQK
KysrIHRpbWUuaAkyMDAxLzAzLzI3IDA2OjA5OjUzCkBAIC02Niw2ICs2Niw5
IEBAIHN0cnVjdCB0bSAqX0VYRlVOKGxvY2FsdGltZV9yLAkoY29uc3QgdGkK
IGV4dGVybiBfX0lNUE9SVCB0aW1lX3QgX3RpbWV6b25lOwogZXh0ZXJuIF9f
SU1QT1JUIGludCBfZGF5bGlnaHQ7CiBleHRlcm4gX19JTVBPUlQgY2hhciAq
X3R6bmFtZVsyXTsKKyNpZm5kZWYgdHpuYW1lCisjZGVmaW5lIHR6bmFtZSBf
dHpuYW1lCisjZW5kaWYKIAogY2hhciAqX0VYRlVOKHRpbWV6b25lLCAodm9p
ZCkpOwogdm9pZCBfRVhGVU4odHpzZXQsICh2b2lkKSk7Cg==

------------=_1583532846-65438-32
Content-Type: text/x-c; charset=us-ascii; name="tztest.c"
Content-Disposition: inline; filename="tztest.c"
Content-Transfer-Encoding: base64
Content-Length: 151

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDx0aW1lLmg+CgptYWluICgp
CnsKICB0enNldCgpOwogIHByaW50Zigic3RkOiVzXG5kc3Q6JXNcbiIsdHpu
YW1lWzBdLHR6bmFtZVsxXSk7Cn0K

------------=_1583532846-65438-32--
