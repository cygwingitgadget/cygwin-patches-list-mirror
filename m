From: Mark Paulus <mark.paulus@wcom.com>
To: "cygwin-patches@sources.redhat.com" <cygwin-patches@sources.redhat.com>
Subject: Patch to syscalls.cc for statfs/df problem
Date: Fri, 09 Mar 2001 12:55:00 -0000
Message-id: <0G9Y00NJI7BV1O@dgismtp04.wcomnet.com>
X-SW-Source: 2001-q1/msg00161.html
Content-type: multipart/mixed; boundary="----------=_1583532846-65438-18"

This is a multi-part message in MIME format...

------------=_1583532846-65438-18
Content-length: 687

Enclosed is a patch to syscalls.cc which enables the use of
the GetDiskFreeSpaceEx call in statfs().  It seems to work
in my environment, except for one small problem.  It appears 
that under WinME, it does not recognize the free space of 
network mounted drives that have over 2GB of free space:
e.g.

in dos:
net use j: \\server\use

in cygwin:
mount j:/ /jdrive

if you then do a df, and J: has more than 2GB free, then 
it will show:
Filesystem           1k-blocks      Used Available Use% Mounted on
j:                     2097120         0   2097120   0% /jdrive

However, from the testing I have been able to do, it appears
this is a failure of the GetDiskFreeSpaceEx call...





------------=_1583532846-65438-18
Content-Type: text/plain; charset=us-ascii; name="ChangeLog"
Content-Disposition: inline; filename="ChangeLog"
Content-Transfer-Encoding: base64
Content-Length: 220

RnJpIE1hciAwOSAxMzozNjowMCAyMDAxICBNYXJrIFBhdWx1cyA8bWFyay5w
YXVsdXNAd2NvbS5jb20+CgoJKiBzeXNjYWxscy5jYyAoc3RhdGZzKTogYWRk
ZWQgY2FsbCB0byBHZXREaXNrRnJlZVNwYWNlRXgoKS4KCgkqIHN5c2NhbGxz
LmNjIDogYWRkZWQgQ1ZTIEtleXdvcmRzLgoK

------------=_1583532846-65438-18
Content-Type: text/x-diff; charset=us-ascii; name="syscalls.cc-patch"
Content-Disposition: inline; filename="syscalls.cc-patch"
Content-Transfer-Encoding: base64
Content-Length: 2892

LS0tIHN5c2NhbGxzLmNjLm9sZAlGcmkgTWFyICA5IDEzOjM0OjU2IDIwMDEK
KysrIHN5c2NhbGxzLmNjCUZyaSBNYXIgIDkgMTM6Mjk6MTQgMjAwMQpAQCAt
OCw2ICs4LDggQEAgVGhpcyBzb2Z0d2FyZSBpcyBhIGNvcHlyaWdodGVkIHdv
cmsgbGljZQogQ3lnd2luIGxpY2Vuc2UuICBQbGVhc2UgY29uc3VsdCB0aGUg
ZmlsZSAiQ1lHV0lOX0xJQ0VOU0UiIGZvcgogZGV0YWlscy4gKi8KIAorc3Rh
dGljIGNoYXIgKmN2c2lkID0gIiRSQ1NGaWxlJCAkUmV2aXNpb24kICREYXRl
JCI7CisKICNpbmNsdWRlICJ3aW5zdXAuaCIKICNpbmNsdWRlIDxzeXMvc3Rh
dC5oPgogI2luY2x1ZGUgPHN5cy92ZnMuaD4gLyogbmVlZGVkIGZvciBzdGF0
ZnMgKi8KQEAgLTE2ODEsNyArMTY4Myw4IEBAIHN0YXRmcyAoY29uc3QgY2hh
ciAqZm5hbWUsIHN0cnVjdCBzdGF0ZnMKICAgY2hhciAqcm9vdCA9IHJvb3Rk
aXIgKGZ1bGxfcGF0aCk7CiAKICAgc3lzY2FsbF9wcmludGYgKCJzdGF0ZnMg
JXMiLCByb290KTsKLQorICAKKyAgLy8gIE5lZWQgdG8gZG8gdGhlIEdldERp
c2tGcmVlU3BhY2UoKSBpbiBvcmRlciB0byBnZXQgdGhlIGJsb2NrIHNpemUK
ICAgRFdPUkQgc3BjLCBicHMsIGZyZWVjLCB0b3RhbGM7CiAKICAgaWYgKCFH
ZXREaXNrRnJlZVNwYWNlIChyb290LCAmc3BjLCAmYnBzLCAmZnJlZWMsICZ0
b3RhbGMpKQpAQCAtMTY5MCw2ICsxNjkzLDM3IEBAIHN0YXRmcyAoY29uc3Qg
Y2hhciAqZm5hbWUsIHN0cnVjdCBzdGF0ZnMKICAgICAgIHJldHVybiAtMTsK
ICAgICB9CiAKKyAgc2ZzLT5mX2JzaXplID0gc3BjKmJwczsKKworICAvLyAg
Q2hlY2sgdG8gc2VlIGlmIHRoZSBHZXREaXNrRnJlZVNwYWNlRXggbWV0aG9k
IGlzIGF2YWlsYWJsZSB0byB1cworICBGQVJQUk9DIHBHZXREaXNrRnJlZVNw
YWNlRXg7CisgIHBHZXREaXNrRnJlZVNwYWNlRXggPSBHZXRQcm9jQWRkcmVz
cyggR2V0TW9kdWxlSGFuZGxlKCJrZXJuZWwzMi5kbGwiKSwKKwkgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICJHZXREaXNrRnJlZVNwYWNlRXhB
Iik7CisKKyAgaWYgKHBHZXREaXNrRnJlZVNwYWNlRXgpCisgIHsKKyAgICBV
TEFSR0VfSU5URUdFUiBmcmVlU2l6ZSwgdG90RGlzaywgdG90RnJlZTsKKwor
ICAgIGlmICghcEdldERpc2tGcmVlU3BhY2VFeCAocm9vdCwKKyAgICAgICAg
ICAgICAgICAgICAgIAkgICAgICAoUFVMQVJHRV9JTlRFR0VSKSZmcmVlU2l6
ZSwKKwkJCSAgICAgIChQVUxBUkdFX0lOVEVHRVIpJnRvdERpc2ssCisJCQkg
ICAgICAoUFVMQVJHRV9JTlRFR0VSKSZ0b3RGcmVlKSkKKyAgICB7CisgICAg
ICBfX3NldGVycm5vICgpOworICAgICAgcmV0dXJuIC0xOworICAgIH0KKyAg
ICAKKyAgICAvLyAgQ2FsY3VsYXRlIHRoZSBzdGF0cyBiYXNlZCB1cG9uIHRo
ZSBhYm92ZSBnZW5lcmF0ZWQgYmxvY2sgc2l6ZQorICAgIHNmcy0+Zl9ibG9j
a3MgPSAobG9uZykgKHRvdERpc2suUXVhZFBhcnQgLyBzZnMtPmZfYnNpemUp
OworICAgIHNmcy0+Zl9iYXZhaWwgPSAobG9uZykgKGZyZWVTaXplLlF1YWRQ
YXJ0IC8gc2ZzLT5mX2JzaXplKTsKKyAgICBzZnMtPmZfYmZyZWUgPSAobG9u
ZykgKHRvdEZyZWUuUXVhZFBhcnQgLyBzZnMtPmZfYnNpemUpOworICB9IC8v
IFByb2Nlc3MgR2V0RGlza0ZyZWVTcGFjZUV4IHJlc3VsdHMuCisgIGVsc2Ug
CisgIHsKKyAgICBzZnMtPmZfYmxvY2tzID0gdG90YWxjOworICAgIHNmcy0+
Zl9iZnJlZSA9IHNmcy0+Zl9iYXZhaWwgPSBmcmVlYzsKKyAgfQorCiAgIERX
T1JEIHZzbiwgbWF4bGVuLCBmbGFnczsKIAogICBpZiAoIUdldFZvbHVtZUlu
Zm9ybWF0aW9uIChyb290LCBOVUxMLCAwLCAmdnNuLCAmbWF4bGVuLCAmZmxh
Z3MsIE5VTEwsIDApKQpAQCAtMTY5OCw5ICsxNzMyLDYgQEAgc3RhdGZzIChj
b25zdCBjaGFyICpmbmFtZSwgc3RydWN0IHN0YXRmcwogICAgICAgcmV0dXJu
IC0xOwogICAgIH0KICAgc2ZzLT5mX3R5cGUgPSBmbGFnczsKLSAgc2ZzLT5m
X2JzaXplID0gc3BjKmJwczsKLSAgc2ZzLT5mX2Jsb2NrcyA9IHRvdGFsYzsK
LSAgc2ZzLT5mX2JmcmVlID0gc2ZzLT5mX2JhdmFpbCA9IGZyZWVjOwogICBz
ZnMtPmZfZmlsZXMgPSAtMTsKICAgc2ZzLT5mX2ZmcmVlID0gLTE7CiAgIHNm
cy0+Zl9mc2lkID0gdnNuOwo=

------------=_1583532846-65438-18--
