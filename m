From: Egor Duda <deo@logos-m.ru>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: link(existing_file_1,existing_file_2) return 0 and actually doing the link
Date: Tue, 29 Aug 2000 01:29:00 -0000
Message-id: <4585031418.20000829122541@logos-m.ru>
X-SW-Source: 2000-q3/msg00043.html
Content-type: multipart/mixed; boundary="----------=_1583532846-65437-2"

This is a multi-part message in MIME format...

------------=_1583532846-65437-2
Content-length: 235

Hi!

  link(existing_file_1,existing_file_2)  returns 0 and actually doing the
link, but should not.

Egor.          mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
link-destination-exist.diff
link-destination-exist.ChangeLog


------------=_1583532846-65437-2
Content-Type: text/plain; charset=us-ascii;
 name="link-destination-exist.ChangeLog"
Content-Disposition: inline; filename="link-destination-exist.ChangeLog"
Content-Transfer-Encoding: base64
Content-Length: 139

MjAwMC0wOC0yOSAgRWdvciBEdWRhICA8ZGVvQGxvZ29zLW0ucnU+CgoJKiBz
eXNjYWxscy5jYyAoX2xpbmspOiBGYWlsIGlmIGRlc3RpbmF0aW9uIGFscmVh
ZHkgZXhpc3RzCg==

------------=_1583532846-65437-2
Content-Type: text/x-diff; charset=us-ascii;
 name="link-destination-exist.diff"
Content-Disposition: inline; filename="link-destination-exist.diff"
Content-Transfer-Encoding: base64
Content-Length: 1452

SW5kZXg6IHdpbnN1cC9jeWd3aW4vc3lzY2FsbHMuY2MKPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQpSQ1MgZmlsZTogL2hvbWUvZHVkYV9hZG1pbi9jdnMtbWly
cm9yL3NyYy93aW5zdXAvY3lnd2luL3N5c2NhbGxzLmNjLHYKcmV0cmlldmlu
ZyByZXZpc2lvbiAxLjUwCmRpZmYgLWMgLTIgLXIxLjUwIHN5c2NhbGxzLmNj
CioqKiB3aW5zdXAvY3lnd2luL3N5c2NhbGxzLmNjCTIwMDAvMDgvMjIgMDU6
MTA6MjAJMS41MAotLS0gd2luc3VwL2N5Z3dpbi9zeXNjYWxscy5jYwkyMDAw
LzA4LzI5IDA3OjIxOjAyCioqKioqKioqKioqKioqKgoqKiogNTI4LDUzMSAq
KioqCi0tLSA1MjgsNTMyIC0tLS0KICAgICAgewogICAgICAgIEhBTkRMRSBo
RmlsZVNvdXJjZTsKKyAgICAgICBIQU5ETEUgaEZpbGVEZXN0aW5hdGlvbjsK
ICAKICAgICAgICBXSU4zMl9TVFJFQU1fSUQgU3RyZWFtSWQ7CioqKioqKioq
KioqKioqKgoqKiogNTUzLDU1NiAqKioqCi0tLSA1NTQsNTc1IC0tLS0KICAJ
ICBnb3RvIGRvY29weTsKICAJfQorIAorICAgICAgIGhGaWxlRGVzdGluYXRp
b24gPSBDcmVhdGVGaWxlICgKKyAgICAgICAgIHJlYWxfYi5nZXRfd2luMzIg
KCksCisgICAgICAgICBGSUxFX1dSSVRFX0FUVFJJQlVURVMsCisgICAgICAg
ICAwLCAvKiBubyBzaGFyaW5nICovCisgICAgICAgICAmc2VjX25vbmVfbmlo
LCAvLyBzYQorICAgICAgICAgQ1JFQVRFX05FVywKKyAgICAgICAgIDAsCisg
ICAgICAgICBOVUxMCisgICAgICAgICApOworIAorICAgICAgIGlmIChoRmls
ZURlc3RpbmF0aW9uID09IElOVkFMSURfSEFORExFX1ZBTFVFKQorICAgICAg
ICAgeworICAgICAgICAgICBDbG9zZUhhbmRsZSAoIGhGaWxlU291cmNlICk7
CisgICAgICAgICAgIHN5c2NhbGxfcHJpbnRmICgiY2Fubm90IGNyZWF0ZSBk
ZXN0aW5hdGlvbiwgJUUiKTsKKyAgICAgICAgICAgZ290byBkb2NvcHk7Cisg
ICAgICAgICB9CisgICAgICAgQ2xvc2VIYW5kbGUgKGhGaWxlRGVzdGluYXRp
b24pOwogIAogICAgICAgIGxwQ29udGV4dCA9IE5VTEw7Cg==

------------=_1583532846-65437-2--
