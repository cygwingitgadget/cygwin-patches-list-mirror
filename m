Return-Path: <cygwin-patches-return-8913-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 54348 invoked by alias); 8 Nov 2017 17:02:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 53861 invoked by uid 89); 8 Nov 2017 17:02:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: =?ISO-8859-1?Q?No, score=-18.7 required=5.0 tests=AWL,BAYES_00,FORGED_MUA_MOZILLA,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,RP_MATCHES_RCVD,SPF_PASS autolearn=unavailable version=3.3.2 spammy=from, from=c2, Hx-spam-relays-external:sk:sonic31, H*RU:sk:sonic31?=
X-HELO: sonic310-21.consmr.mail.gq1.yahoo.com
Received: from sonic310-21.consmr.mail.gq1.yahoo.com (HELO sonic310-21.consmr.mail.gq1.yahoo.com) (98.137.69.147) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 08 Nov 2017 17:02:04 +0000
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Wed, 8 Nov 2017 17:02:03 +0000
Date: Wed, 08 Nov 2017 17:02:00 -0000
From: "Xiaofeng Liu via cygwin-patches" <cygwin-patches@cygwin.com>
Reply-To: Xiaofeng Liu <liuxf09@yahoo.com>
To: cygwin-patches@cygwin.com, Corinna Vinschen <corinna-cygwin@cygwin.com>
Message-ID: <1399268204.4792627.1510160512818@mail.yahoo.com>
In-Reply-To: <20171108124113.GA14994@calimero.vinschen.de>
References: <1958376489.4046072.1510075992854.ref@mail.yahoo.com> <1958376489.4046072.1510075992854@mail.yahoo.com> <20171108123458.GM18070@calimero.vinschen.de> <20171108124113.GA14994@calimero.vinschen.de>
Subject: Re: [PATCH] pread() returns non-zero if read beyond EOF, because NtReadFile returns  EOF status but doesn't set information to 0. Need reset io status block  before NtReadFile is called, so that pread() will return 0 if read beyond EOF.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00043.txt.bz2

 Hi Corinna,The followup patch is different from=C2=A0=C2=A0https://sourcew=
are.org/git/?p=3Dnewlib-cygwin.git;a=3Dcommitdiff;h=3D46702f92ea49Maybe I m=
issed the submit protocol?ThanksXiaofeng
    On Wednesday, November 8, 2017, 4:41:22 AM PST, Corinna Vinschen <corin=
na-cygwin@cygwin.com> wrote:=20=20
=20
 On Nov=C2=A0 8 13:34, Corinna Vinschen wrote:
> On Nov=C2=A0 7 17:33, Xiaofeng Liu via cygwin-patches wrote:
> > ---=C2=A0winsup/cygwin/fhandler_disk_file.cc |=C2=A0 =C2=A0 1 +=C2=A01 =
files changed, 1 insertions(+), 0 deletions(-)
> > diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandl=
er_disk_file.ccindex bc8fead..525cb32 100644--- a/winsup/cygwin/fhandler_di=
sk_file.cc+++ b/winsup/cygwin/fhandler_disk_file.cc@@ -1525,6 +1525,7 @@ fh=
andler_disk_file::pread (void *buf, size_t count, off_t offset)=C2=A0 =C2=
=A0 =C2=A0 =C2=A0IO_STATUS_BLOCK io;=C2=A0 =C2=A0 =C2=A0 =C2=A0LARGE_INTEGE=
R off =3D { QuadPart:offset };=C2=A0+=C2=A0 =C2=A0 =C2=A0 memset(&io, 0, si=
zeof(io));=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!prw_handle && prw_open (false))=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto non_atomic;=C2=A0 =C2=A0 =C2=A0 =C2=A0stat=
us =3D NtReadFile (prw_handle, NULL, NULL, NULL, &io, buf, count,--=C2=A01.=
7.1
>=20
> This is still completely broken, unfortunately.=C2=A0 I took a look, thou=
gh,
> and fixed this problem slightly differently.=C2=A0 Please have a look at
> https://sourceware.org/git/?p=3Dnewlib-cygwin.git;a=3Dcommitdiff;h=3D4670=
2f92ea49
> I retained your authorship, of course.

Obvious followup patch:

https://sourceware.org/git/?p=3Dnewlib-cygwin.git;a=3Dcommitdiff;h=3D181fe5=
d2ed


Corinna

--=20
Corinna Vinschen=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Please, send mails regarding Cygwin to
Cygwin Maintainer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cy=
gwin AT cygwin DOT com
Red Hat=20=20
