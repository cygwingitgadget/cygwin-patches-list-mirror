Return-Path: <cygwin-patches-return-8909-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17610 invoked by alias); 7 Nov 2017 17:33:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 17559 invoked by uid 89); 7 Nov 2017 17:33:21 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-18.4 required=5.0 tests=AWL,BAYES_00,FORGED_MUA_MOZILLA,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,RP_MATCHES_RCVD,SPF_PASS autolearn=ham version=3.3.2 spammy=H*c:PHrt, H*c:alternative, H*x:5.0, H*UA:6.1
X-HELO: sonic307-9.consmr.mail.gq1.yahoo.com
Received: from sonic307-9.consmr.mail.gq1.yahoo.com (HELO sonic307-9.consmr.mail.gq1.yahoo.com) (98.137.64.33) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 07 Nov 2017 17:33:19 +0000
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.gq1.yahoo.com with HTTP; Tue, 7 Nov 2017 17:33:18 +0000
Date: Tue, 07 Nov 2017 17:33:00 -0000
From: "Xiaofeng Liu via cygwin-patches" <cygwin-patches@cygwin.com>
Reply-To: Xiaofeng Liu <liuxf09@yahoo.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Message-ID: <1958376489.4046072.1510075992854@mail.yahoo.com>
Subject: [PATCH] pread() returns non-zero if read beyond EOF, because NtReadFile returns  EOF status but doesn't set information to 0. Need reset io status block  before NtReadFile is called, so that pread() will return 0 if read beyond EOF.
MIME-Version: 1.0
References: <1958376489.4046072.1510075992854.ref@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00039.txt.bz2

---=C2=A0winsup/cygwin/fhandler_disk_file.cc |=C2=A0 =C2=A0 1 +=C2=A01 file=
s changed, 1 insertions(+), 0 deletions(-)
diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_d=
isk_file.ccindex bc8fead..525cb32 100644--- a/winsup/cygwin/fhandler_disk_f=
ile.cc+++ b/winsup/cygwin/fhandler_disk_file.cc@@ -1525,6 +1525,7 @@ fhandl=
er_disk_file::pread (void *buf, size_t count, off_t offset)=C2=A0 =C2=A0 =
=C2=A0 =C2=A0IO_STATUS_BLOCK io;=C2=A0 =C2=A0 =C2=A0 =C2=A0LARGE_INTEGER of=
f =3D { QuadPart:offset };=C2=A0+=C2=A0 =C2=A0 =C2=A0 memset(&io, 0, sizeof=
(io));=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!prw_handle && prw_open (false))=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 goto non_atomic;=C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D=
 NtReadFile (prw_handle, NULL, NULL, NULL, &io, buf, count,--=C2=A01.7.1
