From: egor duda <deo@logos-m.ru>
To: cygwin-patches@cygwin.com
Subject: Re: close-on-exec handles are left open by exec parent
Date: Sat, 04 Aug 2001 11:04:00 -0000
Message-id: <47119421729.20010804220219@logos-m.ru>
References: <71194343130.20010802183838@logos-m.ru> <20010803113109.D26623@redhat.com> <34115428587.20010804205546@logos-m.ru>
X-SW-Source: 2001-q3/msg00049.html
Content-type: multipart/mixed; boundary="----------=_1583532848-65438-92"

This is a multi-part message in MIME format...

------------=_1583532848-65438-92
Content-length: 546

Hi!

Saturday, 04 August, 2001 egor duda deo@logos-m.ru wrote:

ed> without synchronization i got all kinds of strange lockups and
ed> crashes, which disappear when synchronization is added. i didn't
ed> investigate those crashes, but they probably do need some closer
ed> investigation. i'll try to look at them.

well, i think i've found a reason for at least one of them. the fix
looks almost obvious. ok to apply?

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
wrong-free-console.diff
wrong-free-console.ChangeLog


------------=_1583532848-65438-92
Content-Type: text/plain; charset=us-ascii;
 name="wrong-free-console.ChangeLog"
Content-Disposition: inline; filename="wrong-free-console.ChangeLog"
Content-Transfer-Encoding: base64
Content-Length: 167

MjAwMS0wOC0wNCAgRWdvciBEdWRhICA8ZGVvQGxvZ29zLW0ucnU+CgoJKiBk
dGFibGUuY2MgKGR0YWJsZTo6cmVsZWFzZSk6IEF2b2lkIG1lc3Npbmcgd2l0
aCBjb25zb2xlIHdoZW4KCWNsb3Npbmcgc29ja2V0Lgo=

------------=_1583532848-65438-92
Content-Type: text/x-diff; charset=us-ascii; name="wrong-free-console.diff"
Content-Disposition: inline; filename="wrong-free-console.diff"
Content-Transfer-Encoding: base64
Content-Length: 610

SW5kZXg6IGR0YWJsZS5jYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBm
aWxlOiAvY3ZzL3ViZXJiYXVtL3dpbnN1cC9jeWd3aW4vZHRhYmxlLmNjLHYK
cmV0cmlldmluZyByZXZpc2lvbiAxLjQzCmRpZmYgLXUgLXAgLTIgLXIxLjQz
IGR0YWJsZS5jYwotLS0gZHRhYmxlLmNjCTIwMDEvMDcvMjYgMTk6MjI6MjMJ
MS40MworKysgZHRhYmxlLmNjCTIwMDEvMDgvMDQgMTc6NTc6MTkKQEAgLTE1
OSw2ICsxNTksOCBAQCBkdGFibGU6OnJlbGVhc2UgKGludCBmZCkKIAljYXNl
IEZIX1NPQ0tFVDoKIAkgIGRlY19uZWVkX2ZpeHVwX2JlZm9yZSAoKTsKKwkg
IGJyZWFrOwogCWNhc2UgRkhfQ09OU09MRToKIAkgIGRlY19jb25zb2xlX2Zk
cyAoKTsKKwkgIGJyZWFrOwogCX0KICAgICAgIGRlbGV0ZSBmZHNbZmRdOwo=

------------=_1583532848-65438-92--
