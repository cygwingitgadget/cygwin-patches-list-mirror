From: egor duda <deo@logos-m.ru>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: src/winsup/cygwin ChangeLog autoload.cc autolo ...
Date: Thu, 03 May 2001 06:15:00 -0000
Message-id: <9258490099.20010503171417@logos-m.ru>
References: <20010503093508.13491.qmail@sourceware.cygnus.com> <132246850181.20010503140017@logos-m.ru> <20010503130608.B24200@cygbert.vinschen.de> <20010503131328.C24200@cygbert.vinschen.de>
X-SW-Source: 2001-q2/msg00180.html
Content-type: multipart/mixed; boundary="----------=_1583532847-65438-54"

This is a multi-part message in MIME format...

------------=_1583532847-65438-54
Content-length: 433

Hi!

Thursday, 03 May, 2001 Corinna Vinschen cygwin-patches@cygwin.com wrote:

CV> Couldn't you use an instance of fhandler_dev_random?

ok, here it goes.

2001-05-03  Egor Duda  <deo@logos-m.ru>

        * fhandler_socket.cc (set_connect_secret): Use /dev/random to
        generate secret cookie.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
af_unix-crypto-random.ChangeLog
af_unix-crypto-random.diff


------------=_1583532847-65438-54
Content-Type: text/plain; charset=us-ascii;
 name="af_unix-crypto-random.ChangeLog"
Content-Disposition: inline; filename="af_unix-crypto-random.ChangeLog"
Content-Transfer-Encoding: base64
Content-Length: 175

MjAwMS0wNS0wMyAgRWdvciBEdWRhICA8ZGVvQGxvZ29zLW0ucnU+CgoJKiBm
aGFuZGxlcl9zb2NrZXQuY2MgKHNldF9jb25uZWN0X3NlY3JldCk6IFVzZSAv
ZGV2L3JhbmRvbSB0bwoJZ2VuZXJhdGUgc2VjcmV0IGNvb2tpZS4K

------------=_1583532847-65438-54
Content-Type: text/x-diff; charset=us-ascii; name="af_unix-crypto-random.diff"
Content-Disposition: inline; filename="af_unix-crypto-random.diff"
Content-Transfer-Encoding: base64
Content-Length: 1489

SW5kZXg6IGZoYW5kbGVyX3NvY2tldC5jYwo9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09ClJDUyBmaWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dpbi9maGFu
ZGxlcl9zb2NrZXQuY2MsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuNwpkaWZm
IC11IC1wIC0yIC1yMS43IGZoYW5kbGVyX3NvY2tldC5jYwotLS0gZmhhbmRs
ZXJfc29ja2V0LmNjCTIwMDEvMDQvMTggMjE6MTA6MTIJMS43CisrKyBmaGFu
ZGxlcl9zb2NrZXQuY2MJMjAwMS8wNS8wMyAxMzoxMjoxMApAQCAtMzAsNCAr
MzAsNiBAQAogI2RlZmluZSBTRUNSRVRfRVZFTlRfTkFNRSAiY3lnd2luLmxv
Y2FsX3NvY2tldC5zZWNyZXQuJWQuJTA4eC0lMDh4LSUwOHgtJTA4eCIKIAor
ZmhhbmRsZXJfZGV2X3JhbmRvbSogZW50cm9weV9zb3VyY2UgPSBOVUxMOwor
CiAvKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKi8KIC8qIGZoYW5kbGVyX3Nv
Y2tldCAqLwpAQCAtNTEsNiArNTMsMTYgQEAgdm9pZAogZmhhbmRsZXJfc29j
a2V0OjpzZXRfY29ubmVjdF9zZWNyZXQgKCkKIHsKLSAgZm9yIChpbnQgaSA9
IDA7IGkgPCA0OyBpKyspCi0gICAgY29ubmVjdF9zZWNyZXQgW2ldID0gcmFu
ZG9tICgpOworICBpZiAoIWVudHJvcHlfc291cmNlKQorICAgIHsKKyAgICAg
IHZvaWQgKmJ1ZiA9IGNjYWxsb2MgKEhFQVBfRkhBTkRMRVIsIDEsIHNpemVv
ZiAoZmhhbmRsZXJfZGV2X3JhbmRvbSkpOworICAgICAgZW50cm9weV9zb3Vy
Y2UgPSBuZXcgKGJ1ZikgZmhhbmRsZXJfZGV2X3JhbmRvbSAoIi9kZXYvcmFu
ZG9tIiwgOCk7CisgICAgfQorICBpZiAoIWVudHJvcHlfc291cmNlIHx8Cisg
ICAgICAoZW50cm9weV9zb3VyY2UtPnJlYWQgKGNvbm5lY3Rfc2VjcmV0LCBz
aXplb2YgKGNvbm5lY3Rfc2VjcmV0KSkgIT0KKwkJCQkJICAgICBzaXplb2Yg
KGNvbm5lY3Rfc2VjcmV0KSkpCisgICAgeworICAgICAgZm9yIChpbnQgaSA9
IDA7IGkgPCA0OyBpKyspCisJY29ubmVjdF9zZWNyZXQgW2ldID0gcmFuZG9t
ICgpOworICAgIH0KIH0KIAo=

------------=_1583532847-65438-54--
