From: egor duda <deo@logos-m.ru>
To: cygwin-patches@cygwin.com
Subject: try to enable appropriate privilege before loading user's hive
Date: Tue, 14 Aug 2001 01:23:00 -0000
Message-id: <19956432105.20010814122213@logos-m.ru>
X-SW-Source: 2001-q3/msg00078.html
Content-type: multipart/mixed; boundary="----------=_1583532848-65438-93"

This is a multi-part message in MIME format...

------------=_1583532848-65438-93
Content-length: 301

Hi!

  i've noticed that sshd fails to load user's hive even when run from
LocalSystem account. I wonder if there's somthing wrong in my config
or we should apply this patch?

egor.            mailto:deo@logos-m.ru icq 5165414 fidonet 2:5020/496.19
enable-se-restore.diff
enable-se-restore.ChangeLog


------------=_1583532848-65438-93
Content-Type: text/plain; charset=us-ascii; name="enable-se-restore.ChangeLog"
Content-Disposition: inline; filename="enable-se-restore.ChangeLog"
Content-Transfer-Encoding: base64
Content-Length: 183

MjAwMS0wNy0yNyAgRWdvciBEdWRhICA8ZGVvQGxvZ29zLW0ucnU+CgoJKiBz
cGF3bi5jYyAoc3Bhd25fZ3V0cyk6IEVuYWJsZSBhcHByb3ByaWF0ZSBwcml2
aWxlZ2UgYmVmb3JlCglsb2FkaW5nIHVzZXIncyByZWdpc3RyeSBoaXZlLgo=

------------=_1583532848-65438-93
Content-Type: text/x-diff; charset=us-ascii; name="enable-se-restore.diff"
Content-Disposition: inline; filename="enable-se-restore.diff"
Content-Transfer-Encoding: base64
Content-Length: 761

SW5kZXg6IHNwYXduLmNjCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KUkNTIGZp
bGU6IC9jdnMvdWJlcmJhdW0vd2luc3VwL2N5Z3dpbi9zcGF3bi5jYyx2CnJl
dHJpZXZpbmcgcmV2aXNpb24gMS44MwpkaWZmIC11IC1wIC0yIC1yMS44MyBz
cGF3bi5jYwotLS0gc3Bhd24uY2MJMjAwMS8wNy8yNiAxOToyMjoyNAkxLjgz
CisrKyBzcGF3bi5jYwkyMDAxLzA3LzI3IDEzOjU3OjUxCkBAIC02MzIsNCAr
NjMyLDExIEBAIHNraXBfYXJnX3BhcnNpbmc6CiAJUmV2ZXJ0VG9TZWxmICgp
OwogCisgICAgICBzdGF0aWMgQk9PTCBmaXJzdF90aW1lID0gVFJVRTsKKyAg
ICAgIGlmIChmaXJzdF90aW1lKQorICAgICAgICB7CisgICAgICAgICAgc2V0
X3Byb2Nlc3NfcHJpdmlsZWdlIChTRV9SRVNUT1JFX05BTUUpOworICAgICAg
ICAgIGZpcnN0X3RpbWUgPSBGQUxTRTsKKyAgICAgICAgfQorCiAgICAgICAv
KiBMb2FkIHVzZXJzIHJlZ2lzdHJ5IGhpdmUuICovCiAgICAgICBsb2FkX3Jl
Z2lzdHJ5X2hpdmUgKHNpZCk7Cg==

------------=_1583532848-65438-93--
