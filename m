From: "Michael A. Chase" <mchase@ix.netcom.com>
To: <cygwin-patches@cygwin.com>
Subject: [PATCH]Sample setup.ini
Date: Sat, 30 Jun 2001 16:52:00 -0000
Message-id: <01a301c101bf$61839840$6464648a@ca.boeing.com>
References: <000201c1014a$19cf53b0$6464648a@ca.boeing.com> <04c901c10160$4005e1a0$806410ac@local> <20010630120243.D12695@redhat.com> <20010630153329.A16134@redhat.com>
X-SW-Source: 2001-q2/msg00390.html
Content-type: multipart/mixed; boundary="----------=_1583532848-65438-88"

This is a multi-part message in MIME format...

------------=_1583532848-65438-88
Content-length: 766

The precinstall version doesn't have the rule necessary to accept multiple
categories for a package.  I think that is one of the desired features the
upcoming version will provide.

The interim version seems to have forgotten how to handle locally available
source archives, but that should be acceptable pending the new setup.exe.
It handles source archives fine when installing from the net.
--
Mac :})
** I normally forward private questions to the appropriate mail list. **
Give a hobbit a fish and he eats fish for a day.
Give a hobbit a ring and he eats fish for an age.

ChangeLog

Sat Jun 30 16:42:50  2001  Michael A Chase  <mchase@ix.netcom.com>

    * ini.h: Define add_category().
    * iniparse.y: Add rules and dummy function for multiple categories.


------------=_1583532848-65438-88
Content-Type: text/x-diff; charset=us-ascii; name="ini.h-pre-patch"
Content-Disposition: inline; filename="ini.h-pre-patch"
Content-Transfer-Encoding: base64
Content-Length: 476

LS0tIGluaS0yLjc4LjIuMS5oCVNhdCBKdW4gMzAgMTY6MzU6MzEgMjAwMQor
KysgaW5pLmgJU2F0IEp1biAzMCAxNjoyMDo0OSAyMDAxCkBAIC0xNDQsNiAr
MTQ0LDcgQEAgUGFja2FnZSAqbmV3X3BhY2thZ2UgKGNoYXIgKm5hbWUpOwog
dm9pZAlpbmlfaW5pdCAoY2hhciAqc3RyaW5nKTsKIFBhY2thZ2UgKmdldHBr
Z2J5bmFtZSAoY29uc3QgY2hhciAqcGtnbmFtZSk7CiB2b2lkICAgIG5ld19y
ZXF1aXJlbWVudCAoUGFja2FnZSAqcGFja2FnZSwgY2hhciAqZGVwZW5kc29u
KTsKK3ZvaWQgICAgYWRkX2NhdGVnb3J5IChQYWNrYWdlICpwYWNrYWdlLCBj
aGFyICpjYXQpOwogCiAjaWZkZWYgX19jcGx1c3BsdXMKIH0K

------------=_1583532848-65438-88
Content-Type: text/x-diff; charset=us-ascii; name="iniparse.y-pre-patch"
Content-Disposition: inline; filename="iniparse.y-pre-patch"
Content-Transfer-Encoding: base64
Content-Length: 1168

LS0tIGluaXBhcnNlLTIuNzguMi4xLnkJU2F0IEp1biAzMCAxNTozMDozNiAy
MDAxCisrKyBpbmlwYXJzZS55CVNhdCBKdW4gMzAgMTY6MDg6MjEgMjAwMQpA
QCAtODYsNyArODYsNyBAQCBzaW1wbGVfbGluZQogIDogVkVSU0lPTiBTVFJJ
TkcJCXsgY3B0LT52ZXJzaW9uID0gJDI7IH0KICB8IFNERVNDIFNUUklORwkJ
CXsgY3AtPnNkZXNjID0gJDI7IH0KICB8IExERVNDIFNUUklORwkJCXsgY3At
PmxkZXNjID0gJDI7IH0KLSB8IENBVEVHT1JZIFNUUklORwkJeyBjcC0+Y2F0
ZWdvcnkgPSAkMjsgfQorIHwgQ0FURUdPUlkgY2F0ZWdvcmllcwogIHwgUkVR
VUlSRVMgcmVxdWlyZXMKICB8IElOU1RBTEwgU1RSSU5HIFNUUklORwl7IGNw
dC0+aW5zdGFsbCA9ICQyOwogCQkJCSAgY3B0LT5pbnN0YWxsX3NpemUgPSBh
dG9pKCQzKTsKQEAgLTExNiw2ICsxMTYsMTIgQEAgcmVxdWlyZXMKICB8IFNU
UklORwkJCXsgbmV3X3JlcXVpcmVtZW50KGNwLCAkMSk7IH0KICA7CiAKK2Nh
dGVnb3JpZXMKKyA6IFNUUklORwkJCXsgYWRkX2NhdGVnb3J5IChjcCwgJDEp
OworIAkJCQl9IGNhdGVnb3JpZXMKKyB8IFNUUklORwkJCXsgYWRkX2NhdGVn
b3J5IChjcCwgJDEpOyB9CisgOworCiAlJQogCiBQYWNrYWdlICpwYWNrYWdl
ID0gTlVMTDsKQEAgLTE1OCw0ICsxNjQsMTAgQEAgbmV3X3JlcXVpcmVtZW50
KFBhY2thZ2UgKnBhY2thZ2UsIGNoYXIgKgogICBkcC0+bmV4dCA9IGNwLT5y
ZXF1aXJlZDsKICAgZHAtPnBhY2thZ2UgPSBkZXBlbmRzb247CiAgIGNwLT5y
ZXF1aXJlZCA9IGRwOworfQorCit2b2lkCithZGRfY2F0ZWdvcnkgKFBhY2th
Z2UgKnBhY2thZ2UsIGNoYXIgKmNhdCkKK3sKKyAgLyogcGxhY2Vob2xkZXIg
Ki8KIH0K

------------=_1583532848-65438-88--
