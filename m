From: egor duda <deo@logos-m.ru>
To: Christopher Faylor <cygwin-patches@cygwin.com>
Subject: Re: src/winsup/cygwin ChangeLog autoload.cc autolo ...
Date: Thu, 03 May 2001 08:55:00 -0000
Message-id: <177268099516.20010503195427@logos-m.ru>
References: <20010503093508.13491.qmail@sourceware.cygnus.com> <132246850181.20010503140017@logos-m.ru> <20010503130608.B24200@cygbert.vinschen.de> <20010503131328.C24200@cygbert.vinschen.de> <9258490099.20010503171417@logos-m.ru> <20010503110333.A4579@redhat.com> <20010503110454.B4579@redhat.com>
X-SW-Source: 2001-q2/msg00185.html
Content-type: multipart/mixed; boundary="----------=_1583532847-65438-55"

This is a multi-part message in MIME format...

------------=_1583532847-65438-55
Content-length: 592

Hi!

Thursday, 03 May, 2001 Christopher Faylor cgf@redhat.com wrote:

>>>2001-05-03  Egor Duda  <deo@logos-m.ru>
>>>
>>>        * fhandler_socket.cc (set_connect_secret): Use /dev/random to
>>>        generate secret cookie.
>>
>>What happens to the buf that you allocate here?  It looks like a memory
>>leak.

CF> Just to be a little clearer:  It looks like a memory leak in execed proceses.
CF> ccalloced memory is copied to execed processes.

ok. take 2.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
af_unix-crypto-random.diff
af_unix-crypto-random.ChangeLog


------------=_1583532847-65438-55
Content-Type: text/plain; charset=us-ascii;
 name="af_unix-crypto-random.ChangeLog"
Content-Disposition: inline; filename="af_unix-crypto-random.ChangeLog"
Content-Transfer-Encoding: base64
Content-Length: 175

MjAwMS0wNS0wMyAgRWdvciBEdWRhICA8ZGVvQGxvZ29zLW0ucnU+CgoJKiBm
aGFuZGxlcl9zb2NrZXQuY2MgKHNldF9jb25uZWN0X3NlY3JldCk6IFVzZSAv
ZGV2L3JhbmRvbSB0bwoJZ2VuZXJhdGUgc2VjcmV0IGNvb2tpZS4K

------------=_1583532847-65438-55
Content-Type: text/x-diff; charset=us-ascii; name="af_unix-crypto-random.diff"
Content-Disposition: inline; filename="af_unix-crypto-random.diff"
Content-Transfer-Encoding: base64
Content-Length: 1672

SW5kZXg6IGZoYW5kbGVyX3NvY2tldC5jYwo9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09ClJDUyBmaWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dpbi9maGFu
ZGxlcl9zb2NrZXQuY2MsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuNwpkaWZm
IC11IC1wIC0yIC1yMS43IGZoYW5kbGVyX3NvY2tldC5jYwotLS0gZmhhbmRs
ZXJfc29ja2V0LmNjCTIwMDEvMDQvMTggMjE6MTA6MTIJMS43CisrKyBmaGFu
ZGxlcl9zb2NrZXQuY2MJMjAwMS8wNS8wMyAxNTo1MjozOQpAQCAtMzAsNCAr
MzAsNiBAQAogI2RlZmluZSBTRUNSRVRfRVZFTlRfTkFNRSAiY3lnd2luLmxv
Y2FsX3NvY2tldC5zZWNyZXQuJWQuJTA4eC0lMDh4LSUwOHgtJTA4eCIKIAor
ZmhhbmRsZXJfZGV2X3JhbmRvbSogZW50cm9weV9zb3VyY2UgPSBOVUxMOwor
CiAvKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKi8KIC8qIGZoYW5kbGVyX3Nv
Y2tldCAqLwpAQCAtNTEsNiArNTMsMjIgQEAgdm9pZAogZmhhbmRsZXJfc29j
a2V0OjpzZXRfY29ubmVjdF9zZWNyZXQgKCkKIHsKLSAgZm9yIChpbnQgaSA9
IDA7IGkgPCA0OyBpKyspCi0gICAgY29ubmVjdF9zZWNyZXQgW2ldID0gcmFu
ZG9tICgpOworICBpZiAoIWVudHJvcHlfc291cmNlKQorICAgIHsKKyAgICAg
IHZvaWQgKmJ1ZiA9IG1hbGxvYyAoc2l6ZW9mIChmaGFuZGxlcl9kZXZfcmFu
ZG9tKSk7CisgICAgICBlbnRyb3B5X3NvdXJjZSA9IG5ldyAoYnVmKSBmaGFu
ZGxlcl9kZXZfcmFuZG9tICgiL2Rldi9yYW5kb20iLCA4KTsKKyAgICB9Cisg
IGlmIChlbnRyb3B5X3NvdXJjZSAmJgorICAgICAgIWVudHJvcHlfc291cmNl
LT5vcGVuICgiL2Rldi9yYW5kb20iLCBPX1JET05MWSkpCisgICAgeworICAg
ICAgZGVsZXRlIGVudHJvcHlfc291cmNlOworICAgICAgZW50cm9weV9zb3Vy
Y2UgPSBOVUxMOworICAgIH0KKyAgaWYgKCFlbnRyb3B5X3NvdXJjZSB8fAor
ICAgICAgKGVudHJvcHlfc291cmNlLT5yZWFkIChjb25uZWN0X3NlY3JldCwg
c2l6ZW9mIChjb25uZWN0X3NlY3JldCkpICE9CisJCQkJCSAgICAgc2l6ZW9m
IChjb25uZWN0X3NlY3JldCkpKQorICAgIHsKKyAgICAgIGZvciAoaW50IGkg
PSAwOyBpIDwgNDsgaSsrKQorCWNvbm5lY3Rfc2VjcmV0IFtpXSA9IHJhbmRv
bSAoKTsKKyAgICB9CiB9CiAK

------------=_1583532847-65438-55--
