From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Jeff Waller" <jeffw@141monkeys.org>, <cygwin-developers@cygwin.com>, <cygwin-patches@cygwin.com>
Subject: Re: pthread_cond_timedwait, etc
Date: Mon, 04 Jun 2001 03:42:00 -0000
Message-id: <012601c0ece3$120f5560$0200a8c0@lifelesswks>
References: <3B1B504C.8090808@141monkeys.org> <010201c0ecda$526e7450$0200a8c0@lifelesswks>
X-SW-Source: 2001-q2/msg00277.html
Content-type: multipart/mixed; boundary="----------=_1583532848-65438-63"

This is a multi-part message in MIME format...

------------=_1583532848-65438-63
Content-length: 1240

----- Original Message -----
From: "Robert Collins" <robert.collins@itdomain.com.au>

> this may be an artifact of a particularly horrendous patch I had to
> generate at one point. That does look buggy to me. Patch coming
shortly.

Patch attached at the end of the email. Thanks for catching that.
pthread_cond_wait was also bust.

> We could ignore it and return.. I'll try and get time to
> check the spec and see if that's the expected behaviour. If it is,
> consider that error a useful diagnostic for your code :].

pthread_cond_broadcast is meant to never have an error, except when the
condvariable is invalid. The attached patch fixs that little bit of
bitrot as well. It snuck in from my test _verbose_ test code, and should
have been trimmed back a little :]. You probably have code calling
pthread_cond_broadcast to ensure that no threads are waiting when you
exit the program.


Changelog
Mon Jun  4 20:39:00 2001  Robert Collins <rbtcollins@hotmail.com>

 * thread.cc (pthread_cond::Broadcast): Don't print error messages
 on invalid mutexs - user programs are allowed to call
 pthread_cond_broadcast like that.
 __pthread_cond_timedwait: Initialise themutex properly.
 __pthread_cond_wait: Initialise themutex properly.


Rob

------------=_1583532848-65438-63
Content-Type: text/x-diff; charset=us-ascii;
 name="pthread_cond_broadcast_fix.patch"
Content-Disposition: inline; filename="pthread_cond_broadcast_fix.patch"
Content-Transfer-Encoding: base64
Content-Length: 1965

SW5kZXg6IHRocmVhZC5jYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBm
aWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dpbi90aHJlYWQuY2Msdgpy
ZXRyaWV2aW5nIHJldmlzaW9uIDEuMzIKZGlmZiAtdSAtcCAtcjEuMzIgdGhy
ZWFkLmNjCi0tLSB0aHJlYWQuY2MJMjAwMS8wNS8wNiAyMjoyMzo0MwkxLjMy
CisrKyB0aHJlYWQuY2MJMjAwMS8wNi8wNCAxMDozNDo1OApAQCAtNDI0LDcg
KzQyNCwxMCBAQCBwdGhyZWFkX2NvbmQ6OkJyb2FkQ2FzdCAoKQogICAgIHsK
ICAgICAgIGlmIChwdGhyZWFkX211dGV4X3VubG9jayAoJmNvbmRfYWNjZXNz
KSkKICAgICAgICAgc3lzdGVtX3ByaW50ZiAoIkZhaWxlZCB0byB1bmxvY2sg
Y29uZGl0aW9uIHZhcmlhYmxlIGFjY2VzcyBtdXRleCwgdGhpcyAlMHBcbiIs
IHRoaXMpOwotICAgICAgc3lzdGVtX3ByaW50ZiAoIkJyb2FkY2FzdCBjYWxs
ZWQgd2l0aCBpbnZhbGlkIG11dGV4XG4iKTsKKyAgICAgIC8qIFRoaXMgaXNu
J3QgYW5kIEFQSSBlcnJvciAtIHVzZXJzIGFyZSBhbGxvd2VkIHRvIGNhbGwg
dGhpcyB3aGVuIG5vIHRocmVhZHMgCisJIGFyZSB3YWl0aW5nIAorCSBzeXN0
ZW1fcHJpbnRmICgiQnJvYWRjYXN0IGNhbGxlZCB3aXRoIGludmFsaWQgbXV0
ZXhcbiIpOworICAgICAgKi8KICAgICAgIHJldHVybjsKICAgICB9CiAgIHdo
aWxlIChjb3VudC0tKQpAQCAtMTYzOSw2ICsxNjQyLDggQEAgX19wdGhyZWFk
X2NvbmRfdGltZWR3YWl0IChwdGhyZWFkX2NvbmRfdAogICBpZiAoKCgocHNo
YXJlZF9tdXRleCAqKShtdXRleCkpLT5mbGFncyAmIFNZU19CQVNFID09IFNZ
U19CQVNFKSkKICAgICAvLyBhIHBzaGFyZWQgbXV0ZXgKICAgICB0aGVtdXRl
eCA9IF9fcHRocmVhZF9tdXRleF9nZXRwc2hhcmVkIChtdXRleCk7CisgIGVs
c2UKKyAgICB0aGVtdXRleCA9IG11dGV4OwogCiAgIGlmICghdmVyaWZ5YWJs
ZV9vYmplY3RfaXN2YWxpZCAoKnRoZW11dGV4LCBQVEhSRUFEX01VVEVYX01B
R0lDKSkKICAgICByZXR1cm4gRUlOVkFMOwpAQCAtMTY4NSw2ICsxNjkwLDgg
QEAgX19wdGhyZWFkX2NvbmRfd2FpdCAocHRocmVhZF9jb25kX3QgKiBjbwog
ICBpZiAoKCgocHNoYXJlZF9tdXRleCAqKShtdXRleCkpLT5mbGFncyAmIFNZ
U19CQVNFID09IFNZU19CQVNFKSkKICAgICAvLyBhIHBzaGFyZWQgbXV0ZXgK
ICAgICB0aGVtdXRleCA9IF9fcHRocmVhZF9tdXRleF9nZXRwc2hhcmVkICht
dXRleCk7CisgIGVsc2UKKyAgICB0aGVtdXRleCA9IG11dGV4OwogICBpZiAo
IXZlcmlmeWFibGVfb2JqZWN0X2lzdmFsaWQgKCp0aGVtdXRleCwgUFRIUkVB
RF9NVVRFWF9NQUdJQykpCiAgICAgcmV0dXJuIEVJTlZBTDsKICAgaWYgKCF2
ZXJpZnlhYmxlX29iamVjdF9pc3ZhbGlkICgqY29uZCwgUFRIUkVBRF9DT05E
X01BR0lDKSkK

------------=_1583532848-65438-63--
