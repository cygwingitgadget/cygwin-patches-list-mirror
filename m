Return-Path: <cygwin-patches-return-5563-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26809 invoked by alias); 9 Jul 2005 05:23:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26069 invoked by uid 22791); 9 Jul 2005 05:23:11 -0000
Received: from wproxy.gmail.com (HELO wproxy.gmail.com) (64.233.184.203)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Sat, 09 Jul 2005 05:23:11 +0000
Received: by wproxy.gmail.com with SMTP id 67so601892wri
        for <cygwin-patches@cygwin.com>; Fri, 08 Jul 2005 22:23:10 -0700 (PDT)
Received: by 10.54.25.33 with SMTP id 33mr2228493wry;
        Fri, 08 Jul 2005 22:23:09 -0700 (PDT)
Received: by 10.54.62.17 with HTTP; Fri, 8 Jul 2005 22:23:09 -0700 (PDT)
Message-ID: <cd3b087a05070822235f78def6@mail.gmail.com>
Date: Sat, 09 Jul 2005 05:23:00 -0000
From: Nicholas Wourms <nwourms@gmail.com>
Reply-To: Nicholas Wourms <nwourms@gmail.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH]: Add get{delim,line} symbol alias to avoid autoconf detection failures
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3896_3798287.1120886589917"
X-SW-Source: 2005-q3/txt/msg00018.txt.bz2

------=_Part_3896_3798287.1120886589917
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-length: 689

Hi Corinna,

I saw that you exported __get{delim,line} in the cygwin dll.  I've had
this modification locally for awhile now.  There are a number of
autoconfiscated applications which check for these functions and use
them if present.  Unfortunately, autoconf's AC_CHECK_FUNCS will not
pickup CPP definitions in headers because the test links to the c
library using a phony prototype.  Thus, in order to facilitate
autoconf, I've added the necessary resource aliases.  I've also taken
the liberty of replacing the CPP definitions with actual function
prototypes for  improved clarity.   The patch for doing these
operations is attached.  I hope you find it satisfactory.

Cheers,
Nicholas

------=_Part_3896_3798287.1120886589917
Content-Type: text/plain; name="ChangeLog.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ChangeLog.txt"
Content-length: 497

MjAwNS0wNy0wOSAgTmljaG9sYXMgV291cm1zICA8bndvdXJtc0BnbWFpbC5j
b20+CgoJKiBjeWd3aW4uZGluIChnZXRsaW5lKTogQWRkIHN5bWJvbCBhbGlh
cyB0byBhdm9pZCBwcm9ibGVtcyB3aXRoCglhdXRvY29uZidzIEFDX0NIRUNL
X0ZVTkNTIG1hY3JvLgoJKGdldGRlbGltKTogTGlrZXdpc2UuCgkqIGluY2x1
ZGUvc3lzL3N0ZGlvLmggKGdldGxpbmUpOiBJbXByb3ZlIGNsYXJpdHkgYnkg
cmVwbGFjaW5nIHRoZSBjcHAKCWRlZmluaXRpb24gd2l0aCBhIHByb3BlciBm
dW5jdGlvbiBwcm90b3R5cGUuCgkoZ2V0ZGVsaW0pOiAgTGlrZXdpc2UuCgkq
IGluY2x1ZGUvY3lnd2luL3ZlcnNpb24uaDogQnVtcCBBUEkgbWlub3IgbnVt
YmVyLg==

------=_Part_3896_3798287.1120886589917
Content-Type: application/octet-stream; name="getdelim-getline-autoconf-fix.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="getdelim-getline-autoconf-fix.patch"
Content-length: 3262

SW5kZXg6IGN5Z3dpbi5kaW4KPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1Mg
ZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3aW4vY3lnd2luLmRpbix2
CnJldHJpZXZpbmcgcmV2aXNpb24gMS4xNDEKZGlmZiAtdSAtcCAtcjEuMTQx
IGN5Z3dpbi5kaW4KLS0tIGN5Z3dpbi5kaW4JOCBKdWwgMjAwNSAwODoyNDox
MiAtMDAwMAkxLjE0MQorKysgY3lnd2luLmRpbgk5IEp1bCAyMDA1IDA1OjIy
OjE2IC0wMDAwCkBAIC0zNSw4ICszNSw2IEBAIF9fZXByaW50ZiBTSUdGRQog
X19lcnJubyBOT1NJR0ZFCiBfX2ZwY2xhc3NpZnlkIE5PU0lHRkUKIF9fZnBj
bGFzc2lmeWYgTk9TSUdGRQotX19nZXRsaW5lIE5PU0lHRkUKLV9fZ2V0ZGVs
aW0gTk9TSUdGRQogX19nZXRyZWVudCBOT1NJR0ZFCiBfX2luZmluaXR5IE5P
U0lHRkUKIF9fbWFpbiBOT1NJR0ZFCkBAIC02MTMsNiArNjExLDggQEAgZ2V0
Y2hhcl91bmxvY2tlZCBTSUdGRQogX2dldGNoYXJfdW5sb2NrZWQgPSBnZXRj
aGFyX3VubG9ja2VkIFNJR0ZFCiBnZXRjd2QgU0lHRkUKIF9nZXRjd2QgPSBn
ZXRjd2QgU0lHRkUKK19fZ2V0ZGVsaW0gTk9TSUdGRQorZ2V0ZGVsaW0gPSBf
X2dldGRlbGltIE5PU0lHRkUKIGdldGRvbWFpbm5hbWUgU0lHRkUKIF9nZXRk
b21haW5uYW1lID0gZ2V0ZG9tYWlubmFtZSBTSUdGRQogZ2V0ZHRhYmxlc2l6
ZSBOT1NJR0ZFCkBAIC02NDQsNiArNjQ0LDggQEAgX2dldGdyb3VwcyA9IGdl
dGdyb3VwcyBTSUdGRQogX2dldGdyb3VwczMyID0gZ2V0Z3JvdXBzMzIgU0lH
RkUKIGdldGhvc3RpZCBTSUdGRQogZ2V0aXRpbWVyIFNJR0ZFCitfX2dldGxp
bmUgTk9TSUdGRQorZ2V0bGluZSA9IF9fZ2V0bGluZSBOT1NJR0ZFCiBnZXRs
b2dpbl9yIE5PU0lHRkUKIGdldGxvZ2luIE5PU0lHRkUKIF9nZXRsb2dpbiA9
IGdldGxvZ2luIE5PU0lHRkUKSW5kZXg6IGluY2x1ZGUvY3lnd2luL3ZlcnNp
b24uaAo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBmaWxlOiAvY3ZzL3Ny
Yy9zcmMvd2luc3VwL2N5Z3dpbi9pbmNsdWRlL2N5Z3dpbi92ZXJzaW9uLmgs
dgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMTk3CmRpZmYgLXUgLXAgLXIxLjE5
NyB2ZXJzaW9uLmgKLS0tIGluY2x1ZGUvY3lnd2luL3ZlcnNpb24uaAk4IEp1
bCAyMDA1IDA4OjI0OjEyIC0wMDAwCTEuMTk3CisrKyBpbmNsdWRlL2N5Z3dp
bi92ZXJzaW9uLmgJOSBKdWwgMjAwNSAwNToyMjoxNiAtMDAwMApAQCAtMjYw
LDEyICsyNjAsMTMgQEAgZGV0YWlscy4gKi8KICAgICAgIDEzMTogRXhwb3J0
IGluZXRfbnRvcCwgaW5ldF9wdG9uLgogICAgICAgMTMyOiBBZGQgR0xPQl9M
SU1JVCBmbGFnIHRvIGdsb2IuCiAgICAgICAxMzM6IEV4cG9ydCBfX2dldGxp
bmUsIF9fZ2V0ZGVsaW0uCisgICAgICAxMzQ6IEV4cG9ydCBnZXRsaW5lLCBn
ZXRkZWxpbS4KICAgICAgKi8KIAogICAgICAvKiBOb3RlIHRoYXQgd2UgZm9y
Z290IHRvIGJ1bXAgdGhlIGFwaSBmb3IgdWFsYXJtLCBzdHJ0b2xsLCBzdHJ0
b3VsbCAqLwogCiAjZGVmaW5lIENZR1dJTl9WRVJTSU9OX0FQSV9NQUpPUiAw
Ci0jZGVmaW5lIENZR1dJTl9WRVJTSU9OX0FQSV9NSU5PUiAxMzMKKyNkZWZp
bmUgQ1lHV0lOX1ZFUlNJT05fQVBJX01JTk9SIDEzNAogCiAgICAgIC8qIFRo
ZXJlIGlzIGFsc28gYSBjb21wYXRpYml0eSB2ZXJzaW9uIG51bWJlciBhc3Nv
Y2lhdGVkIHdpdGggdGhlCiAJc2hhcmVkIG1lbW9yeSByZWdpb25zLiAgSXQg
aXMgaW5jcmVtZW50ZWQgd2hlbiBpbmNvbXBhdGlibGUKSW5kZXg6IGluY2x1
ZGUvc3lzL3N0ZGlvLmgKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmls
ZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3aW4vaW5jbHVkZS9zeXMvc3Rk
aW8uaCx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS40CmRpZmYgLXUgLXAgLXIx
LjQgc3RkaW8uaAotLS0gaW5jbHVkZS9zeXMvc3RkaW8uaAk4IEp1bCAyMDA1
IDA4OjI0OjEzIC0wMDAwCTEuNAorKysgaW5jbHVkZS9zeXMvc3RkaW8uaAk5
IEp1bCAyMDA1IDA1OjIyOjE2IC0wMDAwCkBAIC0yNSw3ICsyNSwxMSBAQCBk
ZXRhaWxzLiAqLwogIyAgZW5kaWYKICNlbmRpZgogCi0jZGVmaW5lIGdldGxp
bmUgX19nZXRsaW5lCi0jZGVmaW5lIGdldGRlbGltIF9fZ2V0ZGVsaW0KK19f
QkVHSU5fREVDTFMKKworc3NpemVfdAlfRVhGVU4oZ2V0bGluZSwgKGNoYXIg
KiosIHNpemVfdCAqLCBGSUxFICopKTsKK3NzaXplX3QJX0VYRlVOKGdldGRl
bGltLCAoY2hhciAqKiwgc2l6ZV90ICosIGludCwgRklMRSAqKSk7CisKK19f
RU5EX0RFQ0xTCiAKICNlbmRpZgo=

------=_Part_3896_3798287.1120886589917--
