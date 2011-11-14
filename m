Return-Path: <cygwin-patches-return-7547-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26112 invoked by alias); 14 Nov 2011 11:16:55 -0000
Received: (qmail 26101 invoked by uid 22791); 14 Nov 2011 11:16:54 -0000
X-SWARE-Spam-Status: No, hits=3.2 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-wy0-f171.google.com (HELO mail-wy0-f171.google.com) (74.125.82.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 14 Nov 2011 11:16:40 +0000
Received: by wyh11 with SMTP id 11so7205620wyh.2        for <cygwin-patches@cygwin.com>; Mon, 14 Nov 2011 03:16:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.227.203.148 with SMTP id fi20mr1642590wbb.27.1321269399523; Mon, 14 Nov 2011 03:16:39 -0800 (PST)
Received: by 10.216.179.17 with HTTP; Mon, 14 Nov 2011 03:16:39 -0800 (PST)
In-Reply-To: <CALqHt2A7o1oDwxooQwAskeviUqFYGbb3KKCPeczSkvppy1wOsw@mail.gmail.com>
References: <CALqHt2A7o1oDwxooQwAskeviUqFYGbb3KKCPeczSkvppy1wOsw@mail.gmail.com>
Date: Mon, 14 Nov 2011 11:16:00 -0000
Message-ID: <CALqHt2BecaAQ6VrRFLEPgZSOu8C+E8qgAmG1SXDYVonkfwGyWA@mail.gmail.com>
Subject: Fwd: Newlib's implementation of isalnum() is causing compiler warnings
From: Rafal Zwierz <rzwierz@googlemail.com>
To: cygwin-patches@cygwin.com
Content-Type: multipart/mixed; boundary=0015174794ac36125f04b1b0013b
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q4/txt/msg00037.txt.bz2


--0015174794ac36125f04b1b0013b
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Content-length: 592

Hi,

First of all apologies if it is not the right place to submit patches
for newlib/libc used by cygwin. If it's not then I would appreciate if
you could point me to the right place for submitting such patches.

If it is the right place then please read on.

main.c (attached) is a simple app which, when compiled with under Cygwin

gcc -Wall -Werror main.c

shows the following problem:

cc1: warnings being treated as errors
main.c: In function =91main=92:
main.c:6:4: error: array subscript has type =91char=92

The fix is quite simple and is contained in patch.txt.

Best wishes,
Rafal

--0015174794ac36125f04b1b0013b
Content-Type: text/plain; charset=US-ASCII; name="patch.txt"
Content-Disposition: attachment; filename="patch.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_guzdkhy80
Content-length: 850

LS0tIGN0eXBlX29yaWcuaAkyMDA5LTExLTA3IDE1OjI1OjIwLjAwMDAwMDAw
MCArMDAwMAorKysgY3R5cGUuaAkyMDExLTExLTE0IDEwOjU4OjM5LjEwODg5
OTUwMCArMDAwMApAQCAtNTQsNyArNTQsNyBAQCBleHRlcm4JX19JTVBPUlQg
Y2hhcgkqX19jdHlwZV9wdHJfXzsKICAgIE1lYW53aGlsZSwgdGhlIHJlYWwg
aW5kZXggdG8gX19jdHlwZV9wdHJfXysxIG11c3QgYmUgY2FzdCB0byBpbnQs
CiAgICBzaW5jZSBpc2FscGhhKDB4MTAwMDAwMDAxTEwpIG11c3QgZXF1YWwg
aXNhbHBoYSgxKSwgcmF0aGVyIHRoYW4gYmVpbmcKICAgIGFuIG91dC1vZi1i
b3VuZHMgcmVmZXJlbmNlIG9uIGEgNjQtYml0IG1hY2hpbmUuICAqLwotI2Rl
ZmluZSBfX2N0eXBlX2xvb2t1cChfX2MpICgoX19jdHlwZV9wdHJfXytzaXpl
b2YoIiJbX19jXSkpWyhpbnQpKF9fYyldKQorI2RlZmluZSBfX2N0eXBlX2xv
b2t1cChfX2MpICgoX19jdHlwZV9wdHJfXytzaXplb2YoIiJbKGludCkoX19j
KV0pKVsoaW50KShfX2MpXSkKIAogI2RlZmluZQlpc2FscGhhKF9fYykJKF9f
Y3R5cGVfbG9va3VwKF9fYykmKF9VfF9MKSkKICNkZWZpbmUJaXN1cHBlcihf
X2MpCSgoX19jdHlwZV9sb29rdXAoX19jKSYoX1V8X0wpKT09X1UpCg==

--0015174794ac36125f04b1b0013b
Content-Type: text/x-csrc; charset=US-ASCII; name="main.c"
Content-Disposition: attachment; filename="main.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_guzdl2dj1
Content-length: 102

I2luY2x1ZGUgPGN0eXBlLmg+CgppbnQgbWFpbigpCnsKICAgY2hhciBjID0g
JyAnOwogICByZXR1cm4gaXNhbG51bShjKTsKfQo=

--0015174794ac36125f04b1b0013b--
