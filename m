Return-Path: <cygwin-patches-return-2462-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 2611 invoked by alias); 19 Jun 2002 01:19:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2241 invoked from network); 19 Jun 2002 01:18:44 -0000
Date: Tue, 18 Jun 2002 18:19:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
X-X-Sender: joshua@iocc.com
To: cygwin-patches@cygwin.com
Subject: cygpath costmetics
Message-ID: <Pine.CYG.4.44.0206182016330.1256-200000@iocc.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1114366478-1024449440=:1256"
X-SW-Source: 2002-q2/txt/msg00445.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1114366478-1024449440=:1256
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 1047

Here is a mostly cosmetic change for cygpath. I organized the usage
output so that it is more clear (to me) that the -ADHPSW options do
not require an argument. I also changed the desciption for --help
to 'output usage' from 'print this help' since the latter looks mighty
silly on the web or man page.

The only non-cosmetic part is an attempted fix for the new
'--type mixed' option. I have to confess that I don't understand how the
'--type dos' option is different from --windows, or why '--type mixed'
is a better solution than a --mixed option. I'm CC'ing the author of
that patch so perhaps he can enlighten us if not already reading this
mailing list. In any case, however,
the -ADHPSW options should respect the new option and I think these
two lines of code will do it. I'm still not able to compile the utils
right now, though, so that code is untested.

ChangeLog:

2002-06-18  Joshua Daniel Franklin <joshuadfranklin@yahoo.com>

	* cygpath.cc (usage): Clean up usage output.
	(dowin): Correct output of -t mixed for -ADHPSW options.


---559023410-1114366478-1024449440=:1256
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="cygpath.cc-patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.CYG.4.44.0206182017200.1256@iocc.com>
Content-Description: 
Content-Disposition: attachment; filename="cygpath.cc-patch"
Content-length: 3795

LS0tIGN5Z3BhdGguY2Mtb3JpZwlUdWUgSnVuIDE4IDE5OjMzOjIyIDIwMDIN
CisrKyBjeWdwYXRoLmNjCVR1ZSBKdW4gMTggMjA6MDA6NDMgMjAwMg0KQEAg
LTYwLDI5ICs2MCwzMyBAQCB1c2FnZSAoRklMRSAqIHN0cmVhbSwgaW50IHN0
YXR1cykNCiB7DQogICBpZiAoIWlnbm9yZV9mbGFnIHx8ICFzdGF0dXMpDQog
ICAgIGZwcmludGYgKHN0cmVhbSwgIlwNCi1Vc2FnZTogJXMgKC11fC0tdW5p
eCl8KC13fC0td2luZG93cykgW29wdGlvbnNdIGZpbGVuYW1lXG5cblwNCi0g
IC11fC0tdW5peAkJcHJpbnQgVW5peCBmb3JtIG9mIGZpbGVuYW1lXG5cDQot
ICAtd3wtLXdpbmRvd3MJCXByaW50IFdpbmRvd3MgZm9ybSBvZiBmaWxlbmFt
ZVxuXG5cDQotT3RoZXIgb3B0aW9uczpcblwNCi0gIC1hfC0tYWJzb2x1dGUJ
CW91dHB1dCBhYnNvbHV0ZSBwYXRoXG5cDQotICAtY3wtLWNsb3NlIGhhbmRs
ZQljbG9zZSBoYW5kbGUgKGZvciB1c2UgaW4gY2FwdHVyZWQgcHJvY2Vzcylc
blwNCi0gIC1mfC0tZmlsZSBmaWxlCXJlYWQgZmlsZSBmb3IgaW5wdXQgcGF0
aCBpbmZvcm1hdGlvblxuXA0KLSAgLWl8LS1pZ25vcmUJCWlnbm9yZSBtaXNz
aW5nIGFyZ3VtZW50XG5cDQotICAtbHwtLWxvbmctbmFtZQlwcmludCBXaW5k
b3dzIGxvbmcgZm9ybSBvZiBmaWxlbmFtZSAod2l0aCAtdyBvbmx5KVxuXA0K
LSAgLXB8LS1wYXRoCQlmaWxlbmFtZSBhcmd1bWVudCBpcyBhIHBhdGhcblwN
Ci0gIC1zfC0tc2hvcnQtbmFtZQlwcmludCBXaW5kb3dzIHNob3J0IGZvcm0g
b2YgZmlsZW5hbWUgKHdpdGggLXcgb25seSlcblwNCi0gIC10fC0tdHlwZSAg
ICAgICAgICAgICBwcmludCBXaW5kb3dzIGZvcm0gb2YgZmlsZW5hbWUgd2l0
aCBzcGVjaWZpZWRcblwNCitVc2FnZTogJXMgKC11fC13fC10IFRZUEUpIFst
YyBIQU5ETEVdIFstZiBGSUxFXSBbb3B0aW9uc10gTkFNRVxuXG5cDQorICAg
ICAgICVzIFstQURIUFNXXSBcblxuXA0KK091dHB1dCB0eXBlIG9wdGlvbnMg
KHJlcXVpcmVkKTpcblwNCisgIC11fC0tdW5peAkJcHJpbnQgVW5peCBmb3Jt
IG9mIE5BTUUgKGRlZmF1bHQpXG5cDQorICAtd3wtLXdpbmRvd3MJCXByaW50
IFdpbmRvd3MgZm9ybSBvZiBOQU1FIFxuXG5cDQorICAtdHwtLXR5cGUgICAg
ICAgICAgICAgcHJpbnQgV2luZG93cyBmb3JtIG9mIE5BTUUgd2l0aCBUWVBF
IG9uZSBvZlxuXA0KICAgICAgZG9zICAgICAgICAgICAgICAgIGRyaXZlIGxl
dHRlciB3aXRoIGJhY2tzbGFzaGVzIChDOlxcV0lOTlQpXG5cDQogICAgICBt
aXhlZCAgICAgICAgICAgICAgZHJpdmUgbGV0dGVyIHdpdGggcmVndWxhciBz
bGFzaGVzIChDOi9XSU5OVClcblwNCitQYXRoIGNvbnZlcnNpb24gb3B0aW9u
czpcblwNCisgIC1hfC0tYWJzb2x1dGUJCW91dHB1dCBhYnNvbHV0ZSBwYXRo
XG5cDQorICAtY3wtLWNsb3NlIEhBTkRMRSAgICAgY2xvc2UgSEFORExFIChm
b3IgdXNlIGluIGNhcHR1cmVkIHByb2Nlc3MpXG5cDQorICAtZnwtLWZpbGUg
RklMRSAgICAgICAgcmVhZCBGSUxFIGZvciBpbnB1dDsgdXNlIC0gdG8gcmVh
ZCBmcm9tIFNURElOXG5cDQorICAtaXwtLWlnbm9yZQkJaWdub3JlIG1pc3Np
bmcgYXJndW1lbnRcblwNCisgIC1sfC0tbG9uZy1uYW1lCXByaW50IFdpbmRv
d3MgbG9uZyBmb3JtIG9mIE5BTUUgKHdpdGggLXcgb25seSlcblwNCisgIC1w
fC0tcGF0aAkJTkFNRSBpcyBhIFBBVEggbGlzdCAoaS5lLiwgJy9iaW46L3Vz
ci9iaW4nKVxuXA0KKyAgLXN8LS1zaG9ydC1uYW1lCXByaW50IFdpbmRvd3Mg
c2hvcnQgZm9ybSBvZiBOQU1FICh3aXRoIC13IG9ubHkpXG5cDQorU3lzdGVt
IGluZm9ybWF0aW9uIG91dHB1dDpcblwNCiAgIC1BfC0tYWxsdXNlcnMJCXVz
ZSBgQWxsIFVzZXJzJyBpbnN0ZWFkIG9mIGN1cnJlbnQgdXNlciBmb3IgLUQs
IC1QXG5cDQogICAtRHwtLWRlc2t0b3AJCW91dHB1dCBgRGVza3RvcCcgZGly
ZWN0b3J5IGFuZCBleGl0XG5cDQogICAtSHwtLWhvbWVyb290CQlvdXRwdXQg
YFByb2ZpbGVzJyBkaXJlY3RvcnkgKGhvbWUgcm9vdCkgYW5kIGV4aXRcblwN
CiAgIC1QfC0tc21wcm9ncmFtcwlvdXRwdXQgU3RhcnQgTWVudSBgUHJvZ3Jh
bXMnIGRpcmVjdG9yeSBhbmQgZXhpdFxuXA0KICAgLVN8LS1zeXNkaXIJCW91
dHB1dCBzeXN0ZW0gZGlyZWN0b3J5IGFuZCBleGl0XG5cDQogICAtV3wtLXdp
bmRpcgkJb3V0cHV0IGBXaW5kb3dzJyBkaXJlY3RvcnkgYW5kIGV4aXRcblxu
XA0KLUluZm9ybWF0aXZlIG91dHB1dDpcblwNCi0gIC1ofC0taGVscCAgICAg
ICAgICAgICBwcmludCB0aGlzIGhlbHAsIHRoZW4gZXhpdFxuXA0KLSAgLXZ8
LS12ZXJzaW9uCQlvdXRwdXQgdmVyc2lvbiBpbmZvcm1hdGlvbiBhbmQgZXhp
dFxuIiwgcHJvZ19uYW1lKTsNCitPdGhlciBvcHRpb25zOlxuXA0KKyAgLWh8
LS1oZWxwICAgICAgICAgICAgIG91dHB1dCB1c2FnZSBpbmZvcm1hdGlvbiBh
bmQgZXhpdFxuXA0KKyAgLXZ8LS12ZXJzaW9uCQlvdXRwdXQgdmVyc2lvbiBp
bmZvcm1hdGlvbiBhbmQgZXhpdFxuXA0KKyAgIiwgcHJvZ19uYW1lLCBwcm9n
X25hbWUpOw0KICAgZXhpdCAoaWdub3JlX2ZsYWcgPyAwIDogc3RhdHVzKTsN
CiB9DQogDQpAQCAtMzczLDYgKzM3Nyw4IEBAIGRvd2luIChjaGFyIG9wdGlv
bikNCiAgICAgew0KICAgICAgIGlmIChzaG9ydG5hbWVfZmxhZykNCiAgICAg
ICAgIGJ1ZiA9IGdldF9zaG9ydF9uYW1lIChidWYpOw0KKyAgICAgIGlmICht
aXhlZF9mbGFnKQ0KKyAgICAgICAgYnVmID0gZ2V0X21peGVkX25hbWUgKGJ1
Zik7DQogICAgIH0NCiAgIHByaW50ZiAoIiVzXG4iLCBidWYpOw0KICAgZXhp
dCAoMCk7DQo=

---559023410-1114366478-1024449440=:1256--
