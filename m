From: egor duda <deo@logos-m.ru>
To: cygwin-patches@cygwin.com
Subject: no passwd in /etc/group
Date: Wed, 18 Apr 2001 07:36:00 -0000
Message-id: <125340835285.20010418183539@logos-m.ru>
X-SW-Source: 2001-q2/msg00109.html
Content-type: multipart/mixed; boundary="----------=_1583532847-65438-46"

This is a multi-part message in MIME format...

------------=_1583532847-65438-46
Content-length: 229

Hi!

  if passwd field in any line of /etc/group is empty, getgroups causes
SIGSEGV. fix attached.

egor.            mailto:deo@logos-m.ru icq 5165414 fidonet 2:5020/496.19
no-grp-passwd-crash.ChangeLog
no-grp-passwd-crash.diff


------------=_1583532847-65438-46
Content-Type: text/plain; charset=us-ascii;
 name="no-grp-passwd-crash.ChangeLog"
Content-Disposition: inline; filename="no-grp-passwd-crash.ChangeLog"
Content-Transfer-Encoding: base64
Content-Length: 163

MjAwMS0wNC0xOCAgRWdvciBEdWRhICA8ZGVvQGxvZ29zLW0ucnU+CgoJKiBn
cnAuY2MgKGdldGdyb3Vwcyk6IEF2b2lkIGNyYXNoIGlmIHBhc3N3ZCBmaWVs
ZCBpZiAvZXRjL2dyb3VwIGlzIAoJZW1wdHkuCg==

------------=_1583532847-65438-46
Content-Type: text/x-diff; charset=us-ascii; name="no-grp-passwd-crash.diff"
Content-Disposition: inline; filename="no-grp-passwd-crash.diff"
Content-Transfer-Encoding: base64
Content-Length: 761

SW5kZXg6IGdycC5jYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBmaWxl
OiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dpbi9ncnAuY2MsdgpyZXRyaWV2
aW5nIHJldmlzaW9uIDEuMTQKZGlmZiAtdSAtcCAtMiAtcjEuMTQgZ3JwLmNj
Ci0tLSBncnAuY2MJMjAwMS8wNC8xNiAxNDowMjo0MgkxLjE0CisrKyBncnAu
Y2MJMjAwMS8wNC8xOCAxNDozMDowNwpAQCAtMjYxLDUgKzI2MSw2IEBAIGdl
dGdyb3VwcyAoaW50IGdpZHNldHNpemUsIGdpZF90ICpncm91cGwKICAgICAg
ICAgICBmb3IgKGludCBnZyA9IDA7IGdnIDwgY3Vycl9saW5lczsgKytnZykK
IAkgICAgewotCSAgICAgIGlmICghc3RyY21wIChncm91cF9idWZbZ2ddLmdy
X3Bhc3N3ZCwgc3NpZCkpCisJICAgICAgaWYgKGdyb3VwX2J1ZltnZ10uZ3Jf
cGFzc3dkICYmCisgICAgICAgICAgICAgICAgICAhc3RyY21wIChncm91cF9i
dWZbZ2ddLmdyX3Bhc3N3ZCwgc3NpZCkpCiAJICAgICAgICB7CiAJCSAgaWYg
KGNudCA8IGdpZHNldHNpemUpCg==

------------=_1583532847-65438-46--
