From: Egor Duda <deo@logos-m.ru>
To: cygwin-patches@sourceware.cygnus.com
Subject: testsuite signal handling patch
Date: Mon, 04 Sep 2000 02:11:00 -0000
Message-id: <51226485839.20000904131022@logos-m.ru>
X-SW-Source: 2000-q3/msg00054.html
Content-type: multipart/mixed; boundary="----------=_1583532846-65437-7"

This is a multi-part message in MIME format...

------------=_1583532846-65437-7
Content-length: 296

Hi!

  currently,  tests  from  winsup.api/ltp/  can  possibly  catch fatal
signals such as SIGSEGV recursively. attached patch fixes this.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
testsuite-fatal-signals-handling.ChangeLog
testsuite-fatal-signals-handling.diff


------------=_1583532846-65437-7
Content-Type: text/plain; charset=us-ascii;
 name="testsuite-fatal-signals-handling.ChangeLog"
Content-Disposition: inline;
 filename="testsuite-fatal-signals-handling.ChangeLog"
Content-Transfer-Encoding: base64
Content-Length: 163

MjAwMC0wOS0wNCAgRWdvciBEdWRhICA8ZGVvQGxvZ29zLW0ucnU+CgoJKiBs
aWJsdHAvbGliL3RzdF9zaWcuYyAodHN0X3NpZyk6IERvbid0IGF0dGVtcHQg
dG8gY2xlYW51cCBvbgoJZmF0YWwgZXJyb3JzCg==

------------=_1583532846-65437-7
Content-Type: text/x-diff; charset=us-ascii;
 name="testsuite-fatal-signals-handling.diff"
Content-Disposition: inline; filename="testsuite-fatal-signals-handling.diff"
Content-Transfer-Encoding: base64
Content-Length: 1029

SW5kZXg6IHdpbnN1cC90ZXN0c3VpdGUvbGlibHRwL2xpYi90c3Rfc2lnLmMK
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2hvbWUvZHVkYV9h
ZG1pbi9jdnMtbWlycm9yL3NyYy93aW5zdXAvdGVzdHN1aXRlL2xpYmx0cC9s
aWIvdHN0X3NpZy5jLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjEKZGlmZiAt
YyAtMiAtcjEuMSB0c3Rfc2lnLmMKKioqIHdpbnN1cC90ZXN0c3VpdGUvbGli
bHRwL2xpYi90c3Rfc2lnLmMJMjAwMC8wOS8wMyAwMzo1MjozMAkxLjEKLS0t
IHdpbnN1cC90ZXN0c3VpdGUvbGlibHRwL2xpYi90c3Rfc2lnLmMJMjAwMC8w
OS8wNCAwODowNTozOAoqKioqKioqKioqKioqKioKKioqIDE1MSwxNTUgKioq
KgogICAgICAgICAgICAgICAgICBjYXNlIFNJR1BUUkVTQ0hFRDoKICAjZW5k
aWYgLyogU0lHUFRSRVNDSEVEICovCiEgCiAgCSAgICAgICAgICAgIGJyZWFr
OwogIAotLS0gMTUxLDE2MyAtLS0tCiAgICAgICAgICAgICAgICAgIGNhc2Ug
U0lHUFRSRVNDSEVEOgogICNlbmRpZiAvKiBTSUdQVFJFU0NIRUQgKi8KISAj
aWZkZWYgX19DWUdXSU5fXwohIAkJY2FzZSBTSUdTRUdWOgohIAkJY2FzZSBT
SUdJTEw6CiEgCQljYXNlIFNJR1RSQVA6CiEgCQljYXNlIFNJR0FCUlQ6CiEg
CQljYXNlIFNJR0VNVDoKISAJCWNhc2UgU0lHRlBFOgohIAkJY2FzZSBTSUdC
VVM6CiEgI2VuZGlmCiAgCSAgICAgICAgICAgIGJyZWFrOwogIAo=

------------=_1583532846-65437-7--
