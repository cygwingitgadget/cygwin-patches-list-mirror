From: egor duda <deo@logos-m.ru>
To: Christopher Faylor <cygwin-patches@cygwin.com>
Subject: Re: src/winsup/cygwin ChangeLog autoload.cc autolo ...
Date: Fri, 04 May 2001 00:03:00 -0000
Message-id: <96322539597.20010504110148@logos-m.ru>
References: <20010503093508.13491.qmail@sourceware.cygnus.com> <132246850181.20010503140017@logos-m.ru> <20010503130608.B24200@cygbert.vinschen.de> <20010503131328.C24200@cygbert.vinschen.de> <9258490099.20010503171417@logos-m.ru> <20010503110333.A4579@redhat.com> <20010503110454.B4579@redhat.com> <177268099516.20010503195427@logos-m.ru> <20010503131150.C4579@redhat.com>
X-SW-Source: 2001-q2/msg00189.html
Content-type: multipart/mixed; boundary="----------=_1583532847-65438-56"

This is a multi-part message in MIME format...

------------=_1583532847-65438-56
Content-length: 1249

Hi!

Thursday, 03 May, 2001 Christopher Faylor cgf@redhat.com wrote:

>>>>>2001-05-03  Egor Duda  <deo@logos-m.ru>
>>>>>
>>>>>        * fhandler_socket.cc (set_connect_secret): Use /dev/random to
>>>>>        generate secret cookie.
>>>>
>>>>What happens to the buf that you allocate here?  It looks like a memory
>>>>leak.
>>
>>CF> Just to be a little clearer:  It looks like a memory leak in execed proceses.
>>CF> ccalloced memory is copied to execed processes.
>>
>>ok. take 2.

CF> That looks better but I would prefer malloc/free rather than
CF> malloc/delete.

malloc/new/delete, not malloc/delete. delete assures that destructor
(if any) is called for entropy_source.

CF> Alternatively, you could make entropy_source part of fhandler_socket,
CF> ccalloc it, and cfree it in fhandler_socket destruction.  I guess this
CF> isn't right, though, since that would end up performing this operation
CF> once per every socket.

i think it's enough to have one entropy_source per process. i've also
removed calls to random(), since it's not good if random sequence is
changed when application calls bind(). Take 3.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
af_unix-crypto-random.diff
af_unix-crypto-random.ChangeLog


------------=_1583532847-65438-56
Content-Type: text/plain; charset=us-ascii;
 name="af_unix-crypto-random.ChangeLog"
Content-Disposition: inline; filename="af_unix-crypto-random.ChangeLog"
Content-Transfer-Encoding: base64
Content-Length: 175

MjAwMS0wNS0wMyAgRWdvciBEdWRhICA8ZGVvQGxvZ29zLW0ucnU+CgoJKiBm
aGFuZGxlcl9zb2NrZXQuY2MgKHNldF9jb25uZWN0X3NlY3JldCk6IFVzZSAv
ZGV2L3JhbmRvbSB0bwoJZ2VuZXJhdGUgc2VjcmV0IGNvb2tpZS4K

------------=_1583532847-65438-56
Content-Type: text/x-diff; charset=us-ascii; name="af_unix-crypto-random.diff"
Content-Disposition: inline; filename="af_unix-crypto-random.diff"
Content-Transfer-Encoding: base64
Content-Length: 1818

SW5kZXg6IGZoYW5kbGVyX3NvY2tldC5jYwo9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09ClJDUyBmaWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dpbi9maGFu
ZGxlcl9zb2NrZXQuY2MsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuNwpkaWZm
IC11IC1wIC0yIC1yMS43IGZoYW5kbGVyX3NvY2tldC5jYwotLS0gZmhhbmRs
ZXJfc29ja2V0LmNjCTIwMDEvMDQvMTggMjE6MTA6MTIJMS43CisrKyBmaGFu
ZGxlcl9zb2NrZXQuY2MJMjAwMS8wNS8wNCAwNjo1NDo0NwpAQCAtMjksNSAr
MjksOSBAQAogCiAjZGVmaW5lIFNFQ1JFVF9FVkVOVF9OQU1FICJjeWd3aW4u
bG9jYWxfc29ja2V0LnNlY3JldC4lZC4lMDh4LSUwOHgtJTA4eC0lMDh4Igor
I2RlZmluZSBFTlRST1BZX1NPVVJDRV9OQU1FICIvZGV2L3VyYW5kb20iCisj
ZGVmaW5lIEVOVFJPUFlfU09VUkNFX0RFVl9VTklUIDkKIAorZmhhbmRsZXJf
ZGV2X3JhbmRvbSogZW50cm9weV9zb3VyY2UgPSBOVUxMOworCiAvKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKi8KIC8qIGZoYW5kbGVyX3NvY2tldCAqLwpA
QCAtNTEsNiArNTUsMjAgQEAgdm9pZAogZmhhbmRsZXJfc29ja2V0OjpzZXRf
Y29ubmVjdF9zZWNyZXQgKCkKIHsKLSAgZm9yIChpbnQgaSA9IDA7IGkgPCA0
OyBpKyspCi0gICAgY29ubmVjdF9zZWNyZXQgW2ldID0gcmFuZG9tICgpOwor
ICBpZiAoIWVudHJvcHlfc291cmNlKQorICAgIHsKKyAgICAgIHZvaWQgKmJ1
ZiA9IG1hbGxvYyAoc2l6ZW9mIChmaGFuZGxlcl9kZXZfcmFuZG9tKSk7Cisg
ICAgICBlbnRyb3B5X3NvdXJjZSA9IG5ldyAoYnVmKSBmaGFuZGxlcl9kZXZf
cmFuZG9tIChFTlRST1BZX1NPVVJDRV9OQU1FLAorCQkJCQkJICAgICAgRU5U
Uk9QWV9TT1VSQ0VfREVWX1VOSVQpOworICAgIH0KKyAgaWYgKGVudHJvcHlf
c291cmNlICYmCisgICAgICAhZW50cm9weV9zb3VyY2UtPm9wZW4gKEVOVFJP
UFlfU09VUkNFX05BTUUsIE9fUkRPTkxZKSkKKyAgICB7CisgICAgICBkZWxl
dGUgZW50cm9weV9zb3VyY2U7CisgICAgICBlbnRyb3B5X3NvdXJjZSA9IE5V
TEw7CisgICAgfQorICBpZiAoIWVudHJvcHlfc291cmNlIHx8CisgICAgICAo
ZW50cm9weV9zb3VyY2UtPnJlYWQgKGNvbm5lY3Rfc2VjcmV0LCBzaXplb2Yg
KGNvbm5lY3Rfc2VjcmV0KSkgIT0KKwkJCQkJICAgICBzaXplb2YgKGNvbm5l
Y3Rfc2VjcmV0KSkpCisgICAgYnplcm8gKChjaGFyKikgY29ubmVjdF9zZWNy
ZXQsIHNpemVvZiAoY29ubmVjdF9zZWNyZXQpKTsKIH0KIAo=

------------=_1583532847-65438-56--
