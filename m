From: "Ralf Habacker" <Ralf.Habacker@freenet.de>
To: "cygwin-patches" <cygwin-patches@cygwin.com>
Subject: Patch for ssp on win2k 
Date: Mon, 17 Sep 2001 00:41:00 -0000
Message-id: <000501c13f4c$c0d03720$806707d5@BRAMSCHE>
X-SW-Source: 2001-q3/msg00156.html
Content-type: multipart/mixed; boundary="----------=_1583532849-65438-104"

This is a multi-part message in MIME format...

------------=_1583532849-65438-104
Content-length: 171

Hi,
on win2k ssp crashes sometimes while handling LOAD_DLL_DEBUG_EVENT caused by an
unhandled rv return value of ReadProcessMemory(). The patch fixes this.

Regards

Ralf

------------=_1583532849-65438-104
Content-Type: text/x-diff; charset=us-ascii; name="ssp-win2k-bugfix.patch"
Content-Disposition: inline; filename="ssp-win2k-bugfix.patch"
Content-Transfer-Encoding: base64
Content-Length: 814

LS0tIGJpbnV0aWxzX25ldy9zcmMvd2luc3VwL3V0aWxzL3NzcC5jCVNhdCBP
Y3QgMjggMDU6MDA6MDAgMjAwMAorKysgYmludXRpbHMvc3JjL3dpbnN1cC91
dGlscy9zc3AuYwlNb24gU2VwIDE3IDA3OjAyOjU1IDIwMDEKQEAgLTYxNCw2
ICs2MTQsMTAgQEAKIAkJCQkgICAgKExQVk9JRClkbGxfbmFtZSwKIAkJCQkg
ICAgc2l6ZW9mIChkbGxfbmFtZSksCiAJCQkJICAgICZydik7CisgICAgICAg
ICAgIAorICAgICAgLyogUkg6IHVuZGVyIHdpbjJrIHNvbWV0aW1lcyBydiBz
dGFydHMgd2l0aCAweGZkLi4uLi4uIAorICAgICAgYW5kIHRoaXMgY2F1c2Vz
IGNyYXNoaW5nIGRsbF9uYW1lW3J2XSAqLworICAgICAgaWYgKChydiAmIDB4
ZjAwMDAwMDApID09IDApIHsKIAkJICBkbGxfbmFtZVtydl0gPSAwOwogCQkg
IGRsbF9wdHIgPSBkbGxfbmFtZTsKIAkJICBmb3IgKGNwPWRsbF9uYW1lOyAq
Y3A7IGNwKyspCkBAIC02MjYsNyArNjMwLDcgQEAKIAkJICAgIH0KIAkJfQog
CSAgICB9Ci0KKyAgICB9CiAKIAkgIGRsbF9pbmZvW251bV9kbGxzXS5iYXNl
X2FkZHJlc3MKIAkgICAgPSAodW5zaWduZWQgaW50KWV2ZW50LnUuTG9hZERs
bC5scEJhc2VPZkRsbDsK

------------=_1583532849-65438-104--
