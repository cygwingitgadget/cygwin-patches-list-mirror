Return-Path: <cygwin-patches-return-7133-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29820 invoked by alias); 17 Nov 2010 21:47:06 -0000
Received: (qmail 29806 invoked by uid 22791); 17 Nov 2010 21:47:06 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-yw0-f43.google.com (HELO mail-yw0-f43.google.com) (209.85.213.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 17 Nov 2010 21:46:56 +0000
Received: by ywk9 with SMTP id 9so1713704ywk.2        for <cygwin-patches@cygwin.com>; Wed, 17 Nov 2010 13:46:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.151.85.20 with SMTP id n20mr7435333ybl.94.1290030414630; Wed, 17 Nov 2010 13:46:54 -0800 (PST)
Received: by 10.150.144.13 with HTTP; Wed, 17 Nov 2010 13:46:54 -0800 (PST)
In-Reply-To: <AANLkTimoHk_5Sx7goHFHUsqH3whG=d7Wsav6ig3pn+u=@mail.gmail.com>
References: <AANLkTik5ugUtdbrk351sA2aXaAk4gv+e66ydrjaRAVPG@mail.gmail.com>	<20101116175820.GF32170@calimero.vinschen.de>	<AANLkTimoHk_5Sx7goHFHUsqH3whG=d7Wsav6ig3pn+u=@mail.gmail.com>
Date: Thu, 18 Nov 2010 11:06:00 -0000
Message-ID: <AANLkTikA9p3x_xfQP8fDssKztVOOj70HQwjAM+7i+VpP@mail.gmail.com>
Subject: Re: [PATCH] CJK ambiguous width for non-Unicode charsets
From: Andy Koppe <andy.koppe@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: multipart/mixed; boundary=000e0cd56a0c9d23580495469ca7
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
X-SW-Source: 2010-q4/txt/msg00012.txt.bz2


--000e0cd56a0c9d23580495469ca7
Content-Type: text/plain; charset=UTF-8
Content-length: 379

Documentation change to go with the newlib patch at
http://www.cygwin.com/ml/newlib/2010/msg00604.html:

	* setup2.sgml (setup-locale-ov): Document CJK ambiguous width change
	for non-Unicode charsets.
	* new-features.sgml (ov-new1.7.8): Mention CJK ambiguous width change.

(Btw, "Drop support for Windows NT4 prior to Service Pack 4" appears
twice in new-features.sgml).

Andy

--000e0cd56a0c9d23580495469ca7
Content-Type: application/octet-stream; name="ambiwidth2-doc.patch"
Content-Disposition: attachment; filename="ambiwidth2-doc.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ggmqmhfx1
Content-length: 3514

SW5kZXg6IGRvYy9uZXctZmVhdHVyZXMuc2dtbAo9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09ClJDUyBmaWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2RvYy9uZXct
ZmVhdHVyZXMuc2dtbCx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS42MApkaWZm
IC11IC1yMS42MCBuZXctZmVhdHVyZXMuc2dtbAotLS0gZG9jL25ldy1mZWF0
dXJlcy5zZ21sCTkgT2N0IDIwMTAgMTE6MDA6NDcgLTAwMDAJMS42MAorKysg
ZG9jL25ldy1mZWF0dXJlcy5zZ21sCTE3IE5vdiAyMDEwIDIxOjQxOjA5IC0w
MDAwCkBAIC0zOCw2ICszOCwxMyBAQAogRHJvcCBzdXBwb3J0IGZvciBXaW5k
b3dzIE5UNCBwcmlvciB0byBTZXJ2aWNlIFBhY2sgNC4KIDwvcGFyYT48L2xp
c3RpdGVtPgogCis8bGlzdGl0ZW0+PHBhcmE+CitGaXggdGhlIHdpZHRoIG9m
ICJDSksgQW1iaWd1b3VzIFdpZHRoIiBjaGFyYWN0ZXJzIHRvIDEgZm9yIHNp
bmdsZWJ5dGUgY2hhcnNldHMKK2FuZCAyIGZvciBFYXN0IEFzaWFuIG11bHRp
Ynl0ZSBjaGFyc2V0cy4gKEZvciBVVEYtOCwgaXQgcmVtYWlucyBkZXBlbmRl
bnQgb24KK3RoZSBzcGVjaWZpZWQgbGFuZ3VhZ2UsIGFuZCB0aGUgIkBjamtu
YXJyb3ciIGxvY2FsZSBtb2RpZmllciBjYW4gc3RpbGwgYmUgdXNlZAordG8g
Zm9yY2Ugd2lkdGggMS4pCis8L3BhcmE+PC9saXN0aXRlbT4KKwogPC9pdGVt
aXplZGxpc3Q+CiAKIDwvc2VjdDI+CkluZGV4OiBkb2Mvc2V0dXAyLnNnbWwK
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2N2cy9zcmMvc3Jj
L3dpbnN1cC9kb2Mvc2V0dXAyLnNnbWwsdgpyZXRyaWV2aW5nIHJldmlzaW9u
IDEuNDUKZGlmZiAtdSAtcjEuNDUgc2V0dXAyLnNnbWwKLS0tIGRvYy9zZXR1
cDIuc2dtbAkxOCBTZXAgMjAxMCAxMToyOTowNiAtMDAwMAkxLjQ1CisrKyBk
b2Mvc2V0dXAyLnNnbWwJMTcgTm92IDIwMTAgMjE6NDE6MTAgLTAwMDAKQEAg
LTM1MywxNyArMzUzLDE2IEBACiAKIDxsaXN0aXRlbT48cGFyYT4KIFRoZXJl
J3MgYSBjbGFzcyBvZiBjaGFyYWN0ZXJzIGluIHRoZSBVbmljb2RlIGNoYXJh
Y3RlciBzZXQsIGNhbGxlZCB0aGUKLSJDSksgQW1iaWd1b3VzIFdpZHRoIENo
YXJhY3RlciBzZXQiLiAgRm9yIHRoZXNlIGNoYXJhY3RlcnMgdGhlIHdpZHRo
Ci1yZXR1cm5lZCBieSB0aGUgd2N3aWR0aC93Y3N3aWR0aCBmdW5jdGlvbiBp
cyB1c3VhbGx5IDEuICBUaGlzIGlzIG9mdGVuIGEKLXByb2JsZW0gaW4gRWFz
dC1Bc2lhbiBsYW5ndWFnZXMsIHdoaWNoIGhpc3RvcmljYWxseSB1c2UgY2hh
cmFjdGVyIHNldHMKLWluIHdoaWNoIHRoZXNlIGNoYXJhY3RlcnMgaGF2ZSBh
IHdpZHRoIG9mIDIuICBCeSBkZWZhdWx0LCB0aGUKLXdjd2lkdGgvd2Nzd2lk
dGggZnVuY3Rpb25zIHJldHVybiAxIGFzIHRoZSB3aWR0aCBvZiB0aGVzZSBj
aGFyYWN0ZXJzLAotZXhjZXB0IGlmIHRoZSBsYW5ndWFnZSBpcyBzcGVjaWZl
ZCBhcyAiamEiIChKYXBhbmVzZSksICJrbyIgKEtvcmVhbiksIG9yCi0iemgi
IChDaGluZXNlKS4gIEluIHRoZXNlIGxhbmd1YWdlcyB3Y3dpZHRoIGFuZCB3
Y3N3aWR0aCByZXR1cm4gMiBmb3IKLXRoZXNlIGNoYXJhY3RlcnMuICBUaGlz
IGlzIG5vdCBjb3JyZWN0IGluIGFsbCBjaXJjdW1zdGFuY2VzLCBzbyB0aGUg
dXNlcgotb2Ygb25lIG9mIHRoZXNlIGxhbmd1YWdlcyBjYW4gc3BlY2lmeSB0
aGUgbW9kaWZpZXIgIkBjamtuYXJyb3ciLCB3aGljaAotbW9kaWZpZXMgdGhl
IGJlaGF2aW91ciBvZiB3Y3dpZHRoL3djc3dpZHRoIHRvIHJldHVybiAxIGZv
ciB0aGUgYW1iaWd1b3VzCi13aWR0aCBjaGFyYWN0ZXJzLgorIkNKSyBBbWJp
Z3VvdXMgV2lkdGgiIGNoYXJhY3RlcnMuICBGb3IgdGhlc2UgY2hhcmFjdGVy
cywgdGhlIHdpZHRoCityZXR1cm5lZCBieSB0aGUgd2N3aWR0aC93Y3N3aWR0
aCBmdW5jdGlvbnMgaXMgdXN1YWxseSAxLiAgVGhpcyBjYW4gYmUgYQorcHJv
YmxlbSB3aXRoIEVhc3QtQXNpYW4gbGFuZ3VhZ2VzLCB3aGljaCBoaXN0b3Jp
Y2FsbHkgdXNlIGNoYXJhY3RlciBzZXRzCit3aGVyZSB0aGVzZSBjaGFyYWN0
ZXJzIGhhdmUgYSB3aWR0aCBvZiAyLiAgVGhlcmVmb3JlLCB3Y3dpZHRoL3dj
c3dpZHRoCityZXR1cm4gMiBhcyB0aGUgd2lkdGggb2YgdGhlc2UgY2hhcmFj
dGVycyB3aGVuIGFuIEVhc3QtQXNpYW4gY2hhcnNldCBzdWNoCithcyBHQksg
b3IgU0pJUyBpcyBzZWxlY3RlZCwgb3Igd2hlbiBVVEYtOCBpcyBzZWxlY3Rl
ZCBhbmQgdGhlIGxhbmd1YWdlIGlzCitzcGVjaWZpZWQgYXMgInpoIiAoQ2hp
bmVzZSksICJqYSIgKEphcGFuZXNlKSwgb3IgImtvIiAoS29yZWFuKS4gIFRo
aXMgaXMKK25vdCBjb3JyZWN0IGluIGFsbCBjaXJjdW1zdGFuY2VzLCBoZW5j
ZSB0aGUgbG9jYWxlIG1vZGlmaWVyICJAY2prbmFycm93IgorY2FuIGJlIHVz
ZWQgdG8gZm9yY2Ugd2N3aWR0aC93Y3N3aWR0aCB0byByZXR1cm4gMSBmb3Ig
dGhlIGFtYmlndW91cyB3aWR0aAorY2hhcmFjdGVycy4KIDwvcGFyYT48L2xp
c3RpdGVtPgogCiA8L2l0ZW1pemVkbGlzdD4K

--000e0cd56a0c9d23580495469ca7--
