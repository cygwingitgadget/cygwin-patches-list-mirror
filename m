Return-Path: <cygwin-patches-return-1998-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 22428 invoked by alias); 26 Mar 2002 10:14:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22414 invoked from network); 26 Mar 2002 10:14:12 -0000
Date: Tue, 26 Mar 2002 02:30:00 -0000
From: Pavel Tsekov <ptsekov@syntrex.com>
Reply-To: Pavel Tsekov <cygwin@cygwin.com>
Organization: Syntrex, Inc.
X-Priority: 3 (Normal)
Message-ID: <747589232.20020326111351@syntrex.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] setup.exe: mkdir.cc. was: setup.exe crash
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----------297E96210C50F0"
X-SW-Source: 2002-q1/txt/msg00355.txt.bz2

------------297E96210C50F0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 1353

Here is a solution for this problem. Please, review.

To reproduce the crash write manually a path with non-existent drive
in the local package directory edit control.

The reason for this crash is that mkdir_p tries to create the path
recursevly and does not care if its actually a path component or a
drive spec.

I've tried a setup.exe with this patch applied and with very long path
and it works just fine.

This is a forwarded message
From: Colman Curtin <colman.curtin@trintech.com>
To: cygwin@cygwin.com
Date: Monday, March 25, 2002, 11:46:56 PM
Subject: setup.exe crash

===8<==============Original message text===============
Hi
I have setup.exe point to a local network mapping for its local Package
directory.
I noticed when I rebooted, not having the mapping set up to reconnect, that
setup.exe crashed when it tried to move on from that screen with the
following error;
"The exception unknown software exception (0xc00000fd) occurred in the
application at location 0x77f7f12a.
That was the only trouble its given me.

setup.exe version 2.194.2.15
Wint4 sp6a

-Coley.

--
Unsubscribe info:      http://cygwin.com/ml/#unsubscribe-simple
Bug reporting:         http://cygwin.com/bugs.html
Documentation:         http://cygwin.com/docs.html
FAQ:                   http://cygwin.com/faq/


===8<===========End of original message text===========
------------297E96210C50F0
Content-Type: application/octet-stream; name="mkdir.cc.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="mkdir.cc.patch"
Content-length: 972

LS0tIC4uLy4uLy4uLy4uL3NyYy93aW5zdXAvY2luc3RhbGwvbWtkaXIuY2MJ
VHVlIE5vdiAxMyAwMTo0OTozMiAyMDAxCisrKyAuLi8uLi8uLi8uLi9jeWd3
aW4tc25hcHNob3Qvd2luc3VwL2NpbnN0YWxsL21rZGlyLmNjCVR1ZSBNYXIg
MjYgMTA6MDQ6MDggMjAwMgpAQCAtNjksMTMgKzY5LDIyIEBAIG1rZGlyX3Ag
KGludCBpc2FkaXIsIGNvbnN0IGNoYXIgKmluX3BhdGgKICAgaWYgKCFzbGFz
aCkKICAgICByZXR1cm4gMDsKIAorICAvLyBUcnlpbmcgdG8gY3JlYXRlIGEg
ZHJpdmUuLi4gSXQncyB0aW1lIHRvIGdpdmUgdXAuCisgIGlmICgoKHNsYXNo
IC0gcGF0aCkgPT0gMikgJiYgKHBhdGhbMV0gPT0gJzonKSkKKyAgICByZXR1
cm4gLTE7CisKICAgc2F2ZWRfY2hhciA9ICpzbGFzaDsKICAgKnNsYXNoID0g
MDsKLSAgaWYgKG1rZGlyX3AgKDEsIHBhdGgpKQorICBzd2l0Y2ggKG1rZGly
X3AgKDEsIHBhdGgpKQogICAgIHsKLSAgICAgICpzbGFzaCA9IHNhdmVkX2No
YXI7Ci0gICAgICByZXR1cm4gMTsKKyAgICAgIGNhc2UgMToKKyAgICAgICAg
KnNsYXNoID0gc2F2ZWRfY2hhcjsKKyAgICAgICAgcmV0dXJuIDE7CisgICAg
ICBjYXNlIC0xOgorICAgICAgICAvLyBCb3VuY2UgdGhlIGVycm9yIHVwIHRv
IHRoZSBjaGFpbi4uLgorICAgICAgICByZXR1cm4gLTE7CiAgICAgfQorICAK
ICAgKnNsYXNoID0gc2F2ZWRfY2hhcjsKIAogICBpZiAoIWlzYWRpcikK

------------297E96210C50F0--
