Return-Path: <cygwin-patches-return-2301-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 6727 invoked by alias); 4 Jun 2002 12:37:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6674 invoked from network); 4 Jun 2002 12:37:39 -0000
Date: Tue, 04 Jun 2002 05:37:00 -0000
From: Pavel Tsekov <ptsekov@syntrex.com>
Reply-To: Pavel Tsekov <ptsekov@syntrex.com>
Organization: Syntrex, Inc.
X-Priority: 3 (Normal)
Message-ID: <11415277457.20020604143720@syntrex.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] _unlink() & rmdir() on /proc/*
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----------8011E963BBBA8BB"
X-SW-Source: 2002-q2/txt/msg00284.txt.bz2

------------8011E963BBBA8BB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 1111

Hello,

Currently "rm -rf" on a file or directory under /proc returns
ENOENT. This is not correct and is caused by the fact that
the posix filename for, say, /proc/uptime is translated to
the following win32 name: c:\cygwin\proc\uptime (if c:\cygwin
is mounted on /).

The attached patches fix this problem by returning EROFS
from _unlink() and rmdir() if path_conv::get_devn() returns
any of the following device numbers: FH_PROC, FH_PROCESS, FH_REGISTRY.

P.S. I don't expect this patches to be applied because they may look
like ugly hacks or something like that... I didn't find any more
appropriate way to fix this though without greater modifications to
the code. I see several ways of fixing this in a much better way:

1. unlink () and rmdir () should be made virtual functions in
fhandler_base.

2. mount should support mounting in read, write, read-write mode

But again this will involve greater modification of the code so I
don't want to do anything else before hearing people's opinions :)
I'm sure that this was discussed at least once and there may be
reasons for why the things are as they are.
------------8011E963BBBA8BB
Content-Type: application/octet-stream; name="syscalls.cc.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="syscalls.cc.diff"
Content-length: 745

LS0tIHN5c2NhbGxzLmNjCTIwMDItMDYtMDIgMDU6MTQ6NDcuMDAwMDAwMDAw
ICswMjAwCisrKyBzeXNjYWxscy5jYy5wYXRjaGVkCTIwMDItMDYtMDQgMTQ6
MjE6NTUuMDAwMDAwMDAwICswMjAwCkBAIC05NSwxMCArOTUsMTggQEAgZXh0
ZXJuICJDIiBpbnQKIF91bmxpbmsgKGNvbnN0IGNoYXIgKm91cm5hbWUpCiB7
CiAgIGludCByZXMgPSAtMTsKKyAgRFdPUkQgZGV2bjsKICAgc2lnZnJhbWUg
dGhpc2ZyYW1lIChtYWludGhyZWFkKTsKIAogICBwYXRoX2NvbnYgd2luMzJf
bmFtZSAob3VybmFtZSwgUENfU1lNX05PRk9MTE9XIHwgUENfRlVMTCk7CiAK
KyAgaWYgKChkZXZuID0gd2luMzJfbmFtZS5nZXRfZGV2biAoKSkgPT0gRkhf
UFJPQyB8fCBkZXZuID09IEZIX1JFR0lTVFJZIHx8CisgICAgICBkZXZuID09
IEZIX1BST0NFU1MpCisgICAgeworICAgICAgc2V0X2Vycm5vIChFUk9GUyk7
CisgICAgICBnb3RvIGRvbmU7IAorICAgIH0KKwogICBpZiAod2luMzJfbmFt
ZS5lcnJvcikKICAgICB7CiAgICAgICBzZXRfZXJybm8gKHdpbjMyX25hbWUu
ZXJyb3IpOwo=

------------8011E963BBBA8BB
Content-Type: application/octet-stream; name="dir.cc.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dir.cc.diff"
Content-length: 643

LS0tIGRpci5jYwkyMDAyLTA2LTAyIDA4OjA3OjU5LjAwMDAwMDAwMCArMDIw
MAorKysgZGlyLmNjLnBhdGNoZWQJMjAwMi0wNi0wNCAxNDoyMTo0NC4wMDAw
MDAwMDAgKzAyMDAKQEAgLTI3NCw5ICsyNzQsMTcgQEAgZXh0ZXJuICJDIiBp
bnQKIHJtZGlyIChjb25zdCBjaGFyICpkaXIpCiB7CiAgIGludCByZXMgPSAt
MTsKKyAgRFdPUkQgZGV2bjsKIAogICBwYXRoX2NvbnYgcmVhbF9kaXIgKGRp
ciwgUENfU1lNX05PRk9MTE9XKTsKIAorICBpZiAoKGRldm4gPSByZWFsX2Rp
ci5nZXRfZGV2biAoKSkgPT0gRkhfUFJPQyB8fCBkZXZuID09IEZIX1JFR0lT
VFJZIHx8CisgICAgICBkZXZuID09IEZIX1BST0NFU1MpCisgICAgeworICAg
ICAgc2V0X2Vycm5vIChFUk9GUyk7CisgICAgICByZXMgPSAtMTsgCisgICAg
fQorCiAgIGlmIChyZWFsX2Rpci5lcnJvcikKICAgICB7CiAgICAgICBzZXRf
ZXJybm8gKHJlYWxfZGlyLmVycm9yKTsK

------------8011E963BBBA8BB--
