Return-Path: <cygwin-patches-return-7196-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22504 invoked by alias); 11 Feb 2011 21:38:07 -0000
Received: (qmail 22490 invoked by uid 22791); 11 Feb 2011 21:38:07 -0000
X-SWARE-Spam-Status: Yes, hits=6.5 required=5.0	tests=AWL,BAYES_00,BOTNET,RFC_ABUSE_POST,SPF_NEUTRAL
X-Spam-Check-By: sourceware.org
Received: from nd216.dnsexit.com (HELO box7.911domain.com) (64.182.102.216)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 11 Feb 2011 21:38:03 +0000
Received: from server.foleyremote.com (pool-108-28-47-43.washdc.fios.verizon.net [108.28.47.43])	(authenticated bits=0)	by box7.911domain.com (8.13.8/8.13.8) with ESMTP id p1BLc71i016704	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)	for <cygwin-patches@cygwin.com>; Fri, 11 Feb 2011 16:38:08 -0500
Received: from SERVER.foleyremote.com ([fe80::b82f:dcd6:c011:915b]) by SERVER.foleyremote.com ([fe80::b82f:dcd6:c011:915b%13]) with mapi id 14.01.0270.001; Fri, 11 Feb 2011 16:37:58 -0500
From: Peter Foley <pefoley2@verizon.net>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: FW: [PATCH] Crosscompiling configure fix
Date: Fri, 11 Feb 2011 21:38:00 -0000
Message-ID: <7630E3AFCCB3F84AB86B9B1EBF730D536AD09289@SERVER.foleyremote.com>
Content-Type: multipart/mixed;	boundary="_002_7630E3AFCCB3F84AB86B9B1EBF730D536AD09289SERVERfoleyremo_"
MIME-Version: 1.0
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
X-SW-Source: 2011-q1/txt/msg00051.txt.bz2


--_002_7630E3AFCCB3F84AB86B9B1EBF730D536AD09289SERVERfoleyremo_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-length: 982

I've submitted a fix for a problem I came across while trying to build a Li=
nux-hosted Cygwin cross compiler. Autoconf fails in the cygwin and cygserve=
r directories because the bootstrap compiler cannot link. This patch works =
around this by defining GCC_NO_EXECUTABLES, which causes autoconf to skip t=
ests that involve linking.

Note: I submitted a previous patch that included this change, however only =
part of that patch was applied (the removal of AC_ALLOCA) so I am resubmitt=
ing the GCC_NO_EXECUTABLES part of the patch.

Thanks,

Peter Foley

winsup/cygserver/ChangeLog:

2011-02-11 Peter Foley <pefoley2@verizon.net>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * configure.in: define GCC_NO_EXECUTABLES.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * configure: Regenerate.

winsup/cygwin/ChangeLog:

2011-02-11 Peter Foley <pefoley2@verizon.net>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * configure.in: define GCC_NO_EXECUTABLES.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * configure: Regenerate.


--_002_7630E3AFCCB3F84AB86B9B1EBF730D536AD09289SERVERfoleyremo_
Content-Type: application/octet-stream; name="cross.patch"
Content-Description: cross.patch
Content-Disposition: attachment; filename="cross.patch"; size=1011;
	creation-date="Mon, 07 Feb 2011 22:20:43 GMT";
	modification-date="Thu, 10 Feb 2011 22:03:21 GMT"
Content-Transfer-Encoding: base64
Content-length: 1371

SW5kZXg6IGN5Z3NlcnZlci9jb25maWd1cmUuaW4KPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQpSQ1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWdzZXJ2
ZXIvY29uZmlndXJlLmluLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjUKZGlm
ZiAtdSAtcCAtcjEuNSBjb25maWd1cmUuaW4KLS0tIGN5Z3NlcnZlci9jb25m
aWd1cmUuaW4JNyBGZWIgMjAxMSAxNjoyMjowMiAtMDAwMAkxLjUKKysrIGN5
Z3NlcnZlci9jb25maWd1cmUuaW4JMTAgRmViIDIwMTEgMjI6MDM6MDIgLTAw
MDAKQEAgLTE5LDYgKzE5LDkgQEAgSU5TVEFMTD1gY2QgJHNyY2Rpci8uLi8u
LjsgZWNobyAkKHB3ZCkvaQogQUNfUFJPR19JTlNUQUxMCiBBQ19DQU5PTklD
QUxfU1lTVEVNCiAKK200X2luY2x1ZGUoLi4vLi4vY29uZmlnL25vLWV4ZWN1
dGFibGVzLm00KQorR0NDX05PX0VYRUNVVEFCTEVTCisKIExJQl9BQ19QUk9H
X0NDCiBMSUJfQUNfUFJPR19DWFgKIApJbmRleDogY3lnd2luL2NvbmZpZ3Vy
ZS5pbgo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBmaWxlOiAvY3ZzL3Ny
Yy9zcmMvd2luc3VwL2N5Z3dpbi9jb25maWd1cmUuaW4sdgpyZXRyaWV2aW5n
IHJldmlzaW9uIDEuMzUKZGlmZiAtdSAtcCAtcjEuMzUgY29uZmlndXJlLmlu
Ci0tLSBjeWd3aW4vY29uZmlndXJlLmluCTcgRmViIDIwMTEgMTY6MjE6MDgg
LTAwMDAJMS4zNQorKysgY3lnd2luL2NvbmZpZ3VyZS5pbgkxMCBGZWIgMjAx
MSAyMjowMzowMiAtMDAwMApAQCAtMTgsNiArMTgsOSBAQCBBQ19DT05GSUdf
QVVYX0RJUiguLi8uLikKIEFDX1BST0dfSU5TVEFMTAogQUNfQ0FOT05JQ0FM
X1NZU1RFTQogCittNF9pbmNsdWRlKC4uLy4uL2NvbmZpZy9uby1leGVjdXRh
Ymxlcy5tNCkKK0dDQ19OT19FWEVDVVRBQkxFUworCiBMSUJfQUNfUFJPR19D
QwogTElCX0FDX1BST0dfQ1hYCiAK

--_002_7630E3AFCCB3F84AB86B9B1EBF730D536AD09289SERVERfoleyremo_--
