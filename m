From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>, <cygwin-developers@cygwin.com>
Subject: Re: Default chooser view?
Date: Fri, 29 Jun 2001 20:37:00 -0000
Message-id: <041201c10116$5ab675e0$806410ac@local>
References: <032001c100fe$d62310c0$806410ac@local> <20010629205735.K9607@redhat.com> <034701c10106$34f6b6e0$806410ac@local> <036501c10108$b55383c0$806410ac@local> <20010629221309.A11334@redhat.com> <038301c1010a$bab7e840$806410ac@local> <039201c1010b$856f0c80$806410ac@local> <20010629223227.C11334@redhat.com> <03cb01c1010e$6d809dc0$806410ac@local> <20010629231541.A12500@redhat.com> <20010629231957.A12552@redhat.com>
X-SW-Source: 2001-q2/msg00384.html
Content-type: multipart/mixed; boundary="----------=_1583532848-65438-86"

This is a multi-part message in MIME format...

------------=_1583532848-65438-86
Content-length: 563

ChangeLog
Sat Jun 30 2001 13:39:00 Robert Collins rbtcollins@hotmail.com

    * choose.cc (create_listview): Call set_view_mode with VIEW_CATEGORY.
    (do_choose): Log the first category name.

Rob
----- Original Message ----- 
From: "Christopher Faylor" <cgf@redhat.com>
To: <cygwin-developers@cygwin.com>; <cygwin-patches@cygwin.com>
Sent: Saturday, June 30, 2001 1:19 PM
Subject: Default chooser view?


> Btw, Robert, I see that the default view is still Partial.
> Didn't you say that you changed it to Category?  Or did I
> screw something up?
> 
> cgf
> 

------------=_1583532848-65438-86
Content-Type: text/x-diff; charset=us-ascii; name="defaultnlog.patch"
Content-Disposition: inline; filename="defaultnlog.patch"
Content-Transfer-Encoding: base64
Content-Length: 1464

SW5kZXg6IGNob29zZS5jYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBm
aWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2NpbnN0YWxsL2Nob29zZS5jYyx2
CnJldHJpZXZpbmcgcmV2aXNpb24gMi4zNwpkaWZmIC11IC1wIC1yMi4zNyBj
aG9vc2UuY2MKLS0tIGNob29zZS5jYwkyMDAxLzA2LzMwIDAzOjExOjQ2CTIu
MzcKKysrIGNob29zZS5jYwkyMDAxLzA2LzMwIDAzOjM1OjQ4CkBAIC0xMDYx
LDcgKzEwNjEsNyBAQCBjcmVhdGVfbGlzdHZpZXcgKEhXTkQgZGxnLCBSRUNU
ICpyKQogICBjaG9vc2VyID0gbmV3ICh2aWV3KSAoVklFV19DQVRFR09SWSwg
ZGMpOwogCiAgIGRlZmF1bHRfdHJ1c3QgKGx2LCBUUlVTVF9DVVJSKTsKLSAg
c2V0X3ZpZXdfbW9kZSAobHYsIFZJRVdfUEFDS0FHRSk7CisgIHNldF92aWV3
X21vZGUgKGx2LCBWSUVXX0NBVEVHT1JZKTsKICAgaWYgKCFTZXREbGdJdGVt
VGV4dCAoZGxnLCBJRENfQ0hPT1NFX1ZJRVdDQVBUSU9OLCBjaG9vc2VyLT5t
b2RlX2NhcHRpb24oKSkpCiAgICAgbG9nIChMT0dfQkFCQkxFLCAiRmFpbGVk
IHRvIHNldCBWaWV3IGJ1dHRvbiBjYXB0aW9uICVkIiwgR2V0TGFzdEVycm9y
KCkgKTsKICAgZm9yIChQYWNrYWdlICpmb28gPSBwYWNrYWdlOyBmb28tPm5h
bWU7IGZvbysrKQpAQCAtMTQ4Myw3ICsxNDgzLDcgQEAgZG9fY2hvb3NlIChI
SU5TVEFOQ0UgaCkKIAogICAgICAgbG9nIChMT0dfQkFCQkxFLCAiWyVzXSBh
Y3Rpb249JXMgdHJ1c3Q9JXMgaW5zdGFsbGVkPSVzIGV4Y2x1ZGVkPSVzIHNy
Yz89JXMiCiAJICAgIiBjYXRlZ29yeT0lcyIsIHBrZy0+bmFtZSwgYWN0aW9u
LCB0cnVzdCwgaW5zdGFsbGVkLAotCSAgIGV4Y2x1ZGVkLCBwa2ctPnNyY3Bp
Y2tlZCA/ICJ5ZXMiIDogIm5vIiwgcGtnLT5jYXRlZ29yeSk7CisJICAgZXhj
bHVkZWQsIHBrZy0+c3JjcGlja2VkID8gInllcyIgOiAibm8iLCBwa2ctPmNh
dGVnb3J5LT5uYW1lKTsKICAgICAgIGZvciAoaW50IHQgPSAxOyB0IDwgTlRS
VVNUOyB0KyspCiAJewogCSAgaWYgKHBrZy0+aW5mb1t0XS5pbnN0YWxsKQo=

------------=_1583532848-65438-86--
