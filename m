From: Egor Duda <deo@logos-m.ru>
To: cygwin-patches@sourceware.cygnus.com
Subject: readlink() patch
Date: Sun, 03 Sep 2000 10:34:00 -0000
Message-id: <119170270886.20000903213328@logos-m.ru>
X-SW-Source: 2000-q3/msg00050.html
Content-type: multipart/mixed; boundary="----------=_1583532846-65437-5"

This is a multi-part message in MIME format...

------------=_1583532846-65437-5
Content-length: 829

Hi!

  linux man says about readlink():

========================================================================
readlink  places  the contents of the symbolic link path in the buffer
buf,  which  has size bufsiz. readlink does not append a NUL character
to   buf.   It   will  truncate  the  contents  (to a length of bufsiz
characters),  in  case  the  buffer  is  too  small to hold all of the 
contents.
========================================================================

susv2  is  rather  vague  on  this subject, but there's no "buffer too
small"  in  its  list  of  error  conditions.  i don't know what other
standards  say  about  readlink. this patch is to make cygwin readlink
behaving like linux one.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
readlink.ChangeLog
readlink.diff


------------=_1583532846-65437-5
Content-Type: text/plain; charset=us-ascii; name="readlink.ChangeLog"
Content-Disposition: inline; filename="readlink.ChangeLog"
Content-Transfer-Encoding: base64
Content-Length: 232

MjAwMC0wOS0wMyAgRWdvciBEdWRhICA8ZGVvQGxvZ29zLW0ucnU+CgoJKiBw
YXRoLmNjIChyZWFkbGluayk6IENoZWNrIGlmIGJ1ZmZlciBsZW5ndGggaXMg
cG9zaXRpdmUuCglUcnVuY2F0ZSBvdXRwdXQgdG8gYnVmZmVyIGxlbmd0aC4g
RG9uJ3QgdGVybWluYXRlIGJ1ZmZlcgoJd2l0aCAnXDAnLgo=

------------=_1583532846-65437-5
Content-Type: text/x-diff; charset=us-ascii; name="readlink.diff"
Content-Disposition: inline; filename="readlink.diff"
Content-Transfer-Encoding: base64
Content-Length: 1220

SW5kZXg6IHdpbnN1cC9jeWd3aW4vcGF0aC5jYwo9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09ClJDUyBmaWxlOiAvaG9tZS9kdWRhX2FkbWluL2N2cy1taXJyb3Iv
c3JjL3dpbnN1cC9jeWd3aW4vcGF0aC5jYyx2CnJldHJpZXZpbmcgcmV2aXNp
b24gMS40NQpkaWZmIC1jIC0yIC1yMS40NSBwYXRoLmNjCioqKiB3aW5zdXAv
Y3lnd2luL3BhdGguY2MJMjAwMC8wOC8yMiAxNzo1OTo1MwkxLjQ1Ci0tLSB3
aW5zdXAvY3lnd2luL3BhdGguY2MJMjAwMC8wOS8wMyAxNjozMToyMQoqKioq
KioqKioqKioqKioKKioqIDIzOTQsMjQwNSAqKioqCiAgICAgIH0KICAKISAg
IGludCBsZW4gPSBzdHJsZW4gKHBhdGhidWYuZ2V0X3dpbjMyICgpKTsKISAg
IGlmIChsZW4gPiAoYnVmbGVuIC0gMSkpCiAgICAgIHsKISAgICAgICBzZXRf
ZXJybm8gKEVOQU1FVE9PTE9ORyk7CiAgICAgICAgcmV0dXJuIC0xOwogICAg
ICB9CiEgICBtZW1jcHkgKGJ1ZiwgcGF0aGJ1Zi5nZXRfd2luMzIgKCksIGxl
bik7CiEgICBidWZbbGVuXSA9ICdcMCc7CiAgCiAgICAvKiBlcnJubyBzZXQg
Ynkgc3ltbGluay5jaGVjayBpZiBlcnJvciAqLwotLS0gMjM5NCwyNDA1IC0t
LS0KICAgICAgfQogIAohICAgaWYgKCBidWZsZW4gPCAwICkKICAgICAgewoh
ICAgICAgIHNldF9lcnJubyAoIEVJTlZBTCApOwogICAgICAgIHJldHVybiAt
MTsKICAgICAgfQohIAohICAgaW50IGxlbiA9IG1heCAoIGJ1ZmxlbiwgKGlu
dCkgc3RybGVuICggcGF0aGJ1Zi5nZXRfd2luMzIgKCkgKSApOwohICAgbWVt
Y3B5IChidWYsIHBhdGhidWYuZ2V0X3dpbjMyICgpLCBsZW4gKTsKICAKICAg
IC8qIGVycm5vIHNldCBieSBzeW1saW5rLmNoZWNrIGlmIGVycm9yICovCg==

------------=_1583532846-65437-5--
