From: Egor Duda <deo@logos-m.ru>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: getgroups() SUSv2 compliance
Date: Tue, 29 Aug 2000 03:05:00 -0000
Message-id: <19790892646.20000829140323@logos-m.ru>
X-SW-Source: 2000-q3/msg00044.html
Content-type: multipart/mixed; boundary="----------=_1583532846-65437-3"

This is a multi-part message in MIME format...

------------=_1583532846-65437-3
Content-length: 505

Hi!

  SUSv2 states that:

==========================================================================
The getgroups() function will fail if:

[EINVAL]
        The gidsetsize argument is non-zero and is less than the number of
        supplementary group IDs. 
==========================================================================

patch attached to accomplish this.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
getgroups-error-patch.ChangeLog
getgroups-error-patch.diff


------------=_1583532846-65437-3
Content-Type: text/plain; charset=us-ascii;
 name="getgroups-error-patch.ChangeLog"
Content-Disposition: inline; filename="getgroups-error-patch.ChangeLog"
Content-Transfer-Encoding: base64
Content-Length: 204

MjAwMC0wOC0yOSAgRWdvciBEdWRhICA8ZGVvQGxvZ29zLW0ucnU+CgoJKiBn
cnAuY2MgKGdldGdyb3Vwcyk6IGZhaWwgd2l0aCBFSU5WQUwgaWYgYXJyYXkg
aXMgbm90IGxhcmdlCgllbm91Z2ggdG8gaG9sZCBhbGwgc3VwcGxlbWVudGFy
eSBncm91cCBJRHMuCg==

------------=_1583532846-65437-3
Content-Type: text/x-diff; charset=us-ascii; name="getgroups-error-patch.diff"
Content-Disposition: inline; filename="getgroups-error-patch.diff"
Content-Transfer-Encoding: base64
Content-Length: 2034

SW5kZXg6IHdpbnN1cC9jeWd3aW4vZ3JwLmNjCj09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0KUkNTIGZpbGU6IC9ob21lL2R1ZGFfYWRtaW4vY3ZzLW1pcnJvci9z
cmMvd2luc3VwL2N5Z3dpbi9ncnAuY2MsdgpyZXRyaWV2aW5nIHJldmlzaW9u
IDEuOApkaWZmIC1jIC0yIC1yMS44IGdycC5jYwoqKiogd2luc3VwL2N5Z3dp
bi9ncnAuY2MJMjAwMC8wOC8yMiAwNToxMDoyMAkxLjgKLS0tIHdpbnN1cC9j
eWd3aW4vZ3JwLmNjCTIwMDAvMDgvMjkgMDg6NTk6MDcKKioqKioqKioqKioq
KioqCioqKiAxNiwyMyAqKioqCi0tLSAxNiwyNSAtLS0tCiAgI2luY2x1ZGUg
PHN0ZGlvLmg+CiAgI2luY2x1ZGUgPHN0ZGxpYi5oPgorICNpbmNsdWRlIDxl
cnJuby5oPgogICNpbmNsdWRlICJ0aHJlYWQuaCIKICAjaW5jbHVkZSAic3lu
Yy5oIgogICNpbmNsdWRlICJzaWdwcm9jLmgiCiAgI2luY2x1ZGUgInBpbmZv
LmgiCisgI2luY2x1ZGUgImN5Z2Vycm5vLmgiCiAgCiAgLyogUmVhZCAvZXRj
L2dyb3VwIG9ubHkgb25jZSBmb3IgYmV0dGVyIHBlcmZvcm1hbmNlLiAgVGhp
cyBpcyBkb25lCioqKioqKioqKioqKioqKgoqKiogMjQ5LDI1NCAqKioqCiAg
ICAgICAgICAgIGdyb3VwbGlzdFtjbnRdID0gZ3JvdXBfYnVmW2ldLmdyX2dp
ZDsKICAgICAgICAgICsrY250OwohICAgICAgICAgaWYgKGdpZHNldHNpemUg
JiYgY250ID49IGdpZHNldHNpemUpCiEgICAgICAgICAgIGdvdG8gb3V0Owog
ICAgICAgIH0KICAgICAgZWxzZSBpZiAoZ3JvdXBfYnVmW2ldLmdyX21lbSkK
LS0tIDI1MSwyNTYgLS0tLQogICAgICAgICAgICBncm91cGxpc3RbY250XSA9
IGdyb3VwX2J1ZltpXS5ncl9naWQ7CiAgICAgICAgICArK2NudDsKISAgICAg
ICAgIGlmIChnaWRzZXRzaXplICYmIGNudCA+IGdpZHNldHNpemUpCiEgICAg
ICAgICAgIGdvdG8gZXJyb3I7CiAgICAgICAgfQogICAgICBlbHNlIGlmIChn
cm91cF9idWZbaV0uZ3JfbWVtKQoqKioqKioqKioqKioqKioKKioqIDI1OSwy
NjcgKioqKgogICAgICAgICAgICAgICAgZ3JvdXBsaXN0W2NudF0gPSBncm91
cF9idWZbaV0uZ3JfZ2lkOwogICAgICAgICAgICAgICsrY250OwohICAgICAg
ICAgICAgIGlmIChnaWRzZXRzaXplICYmIGNudCA+PSBnaWRzZXRzaXplKQoh
ICAgICAgICAgICAgICAgZ290byBvdXQ7CiAgICAgICAgICAgIH0KLSBvdXQ6
CiAgICByZXR1cm4gY250OwogIH0KICAKLS0tIDI2MSwyNzIgLS0tLQogICAg
ICAgICAgICAgICAgZ3JvdXBsaXN0W2NudF0gPSBncm91cF9idWZbaV0uZ3Jf
Z2lkOwogICAgICAgICAgICAgICsrY250OwohICAgICAgICAgICAgIGlmIChn
aWRzZXRzaXplICYmIGNudCA+IGdpZHNldHNpemUpCiEgICAgICAgICAgICAg
ICBnb3RvIGVycm9yOwogICAgICAgICAgICB9CiAgICByZXR1cm4gY250Owor
IAorIGVycm9yOgorICAgc2V0X2Vycm5vICggRUlOVkFMICk7CisgICByZXR1
cm4gLTE7CiAgfQogIAo=

------------=_1583532846-65437-3--
