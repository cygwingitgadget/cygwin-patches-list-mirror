Return-Path: <cygwin-patches-return-2300-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 21764 invoked by alias); 4 Jun 2002 09:51:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21704 invoked from network); 4 Jun 2002 09:51:09 -0000
Date: Tue, 04 Jun 2002 02:51:00 -0000
From: Pavel Tsekov <ptsekov@syntrex.com>
Reply-To: Pavel Tsekov <ptsekov@syntrex.com>
Organization: Syntrex, Inc.
X-Priority: 3 (Normal)
Message-ID: <415287753.20020604115051@syntrex.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] path_conv::check - Do not check if a directory is executable
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----------A4182B92269E556"
X-SW-Source: 2002-q2/txt/msg00283.txt.bz2

------------A4182B92269E556
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 456

Hello,

While I was browsing the fhandler_registry code and the *stat()
stuff it occured to me that this patch may be useful. I don't know
how it improves the speed of the path_conv::check (I don't think it
is a noticable improvement), but for sure it saves some cpu cycles.

2002-06-04  Pavel Tsekov  <ptsekov@gmx.net>

            * path.cc (path_conv::check): Do not check a directory
            path against a known list of executable file extensions.
------------A4182B92269E556
Content-Type: application/octet-stream; name="path.cc.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="path.cc.diff"
Content-length: 545

LS0tIHBhdGguY2MJMjAwMi0wNi0wMiAwNToxNDo0Ny4wMDAwMDAwMDAgKzAy
MDAKKysrIHBhdGguY2MucGF0Y2hlZAkyMDAyLTA2LTA0IDExOjM0OjQ5LjAw
MDAwMDAwMCArMDIwMApAQCAtODAzLDcgKzgwMyw4IEBAIG91dDoKICAgaWYg
KHNhd19zeW1saW5rcykKICAgICBzZXRfaGFzX3N5bWxpbmtzICgpOwogCi0g
IGlmICghZXJyb3IgJiYgIShwYXRoX2ZsYWdzICYgUEFUSF9BTExfRVhFQykp
CisgIGlmICghZXJyb3IgJiYgIShwYXRoX2ZsYWdzICYgUEFUSF9BTExfRVhF
QykgJiYKKyAgICAgICEoZmlsZWF0dHIgJiBGSUxFX0FUVFJJQlVURV9ESVJF
Q1RPUlkpKQogICAgIHsKICAgICAgIGNvbnN0IGNoYXIgKnAgPSBzdHJjaHIg
KHBhdGgsICdcMCcpIC0gNDsKICAgICAgIGlmIChwID49IHBhdGggJiYK

------------A4182B92269E556--
