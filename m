Return-Path: <cygwin-patches-return-2302-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 14523 invoked by alias); 4 Jun 2002 13:32:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14465 invoked from network); 4 Jun 2002 13:32:42 -0000
Date: Tue, 04 Jun 2002 06:32:00 -0000
From: Pavel Tsekov <ptsekov@syntrex.com>
Reply-To: Pavel Tsekov <ptsekov@syntrex.com>
Organization: Syntrex, Inc.
X-Priority: 3 (Normal)
Message-ID: <14818587827.20020604153231@syntrex.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] _unlink() & rmdir() on /proc/*
In-Reply-To: <11415277457.20020604143720@syntrex.com>
References: <11415277457.20020604143720@syntrex.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----------9414DCC10D071C2"
X-SW-Source: 2002-q2/txt/msg00285.txt.bz2

------------9414DCC10D071C2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 199

The attached dir.cc.diff in the original mail was wrong. Please, find attached the proper
fix for dir.cc.

Sorry for the inconvenience :(

PT> The attached patches fix this problem by returning EROFS
------------9414DCC10D071C2
Content-Type: application/octet-stream; name="dir.cc.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dir.cc.diff"
Content-length: 647

LS0tIGRpci5jYwkyMDAyLTA2LTAyIDA4OjA3OjU5LjAwMDAwMDAwMCArMDIw
MAorKysgZGlyLmNjLnBhdGNoZWQJMjAwMi0wNi0wNCAxNToyNDoyMC4wMDAw
MDAwMDAgKzAyMDAKQEAgLTI3NCw5ICsyNzQsMTcgQEAgZXh0ZXJuICJDIiBp
bnQKIHJtZGlyIChjb25zdCBjaGFyICpkaXIpCiB7CiAgIGludCByZXMgPSAt
MTsKKyAgRFdPUkQgZGV2bjsKIAogICBwYXRoX2NvbnYgcmVhbF9kaXIgKGRp
ciwgUENfU1lNX05PRk9MTE9XKTsKIAorICBpZiAoKGRldm4gPSByZWFsX2Rp
ci5nZXRfZGV2biAoKSkgPT0gRkhfUFJPQyB8fCBkZXZuID09IEZIX1JFR0lT
VFJZIHx8CisgICAgICBkZXZuID09IEZIX1BST0NFU1MpCisgICAgeworICAg
ICAgc2V0X2Vycm5vIChFUk9GUyk7CisgICAgICByZXR1cm4gcmVzOyAKKyAg
ICB9CisKICAgaWYgKHJlYWxfZGlyLmVycm9yKQogICAgIHsKICAgICAgIHNl
dF9lcnJubyAocmVhbF9kaXIuZXJyb3IpOwo=

------------9414DCC10D071C2--
