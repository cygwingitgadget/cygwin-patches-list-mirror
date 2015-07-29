Return-Path: <cygwin-patches-return-8228-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 109975 invoked by alias); 29 Jul 2015 14:10:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 109963 invoked by uid 89); 29 Jul 2015 14:10:36 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.7 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,RP_MATCHES_RCVD,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mgate3.illumina.com
Received: from mgate3.illumina.com (HELO mgate3.illumina.com) (46.17.164.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Wed, 29 Jul 2015 14:10:34 +0000
X-ASG-Debug-ID: 1438179020-05f25675af2ff390003-QFy3Zk
Received: from UKCH-PRD-EXCA01.illumina.com (ukch-prd-exca01.illumina.com [10.46.32.80]) by mgate3.illumina.com with ESMTP id PwMuoZ1Tl2aZ2UUz (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO) for <cygwin-patches@cygwin.com>; Wed, 29 Jul 2015 07:10:29 -0700 (PDT)
X-Barracuda-Envelope-From: RPetrovski@illumina.com
X-ASG-Whitelist: Client
Received: from UKCH-PRD-EXMB01.illumina.com ([::1]) by UKCH-PRD-EXCA01.illumina.com ([10.46.32.80]) with mapi id 14.03.0195.001; Wed, 29 Jul 2015 15:10:26 +0100
From: "Petrovski, Roman" <RPetrovski@illumina.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: RtlFillMemory fails on block sizes over 0x7fffffff
X-ASG-Orig-Subj: RtlFillMemory fails on block sizes over 0x7fffffff
Date: Wed, 29 Jul 2015 14:10:00 -0000
Message-ID: <3BD89E0BA5F96349B765DE1100906A6D016FC0267F@UKCH-PRD-EXMB01.illumina.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Barracuda-Connect: ukch-prd-exca01.illumina.com[10.46.32.80]
X-Barracuda-Start-Time: 1438179027
X-Barracuda-Encrypted: AES128-SHA
X-Barracuda-URL: http://10.46.33.14:8000/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-IsSubscribed: yes
X-SW-Source: 2015-q3/txt/msg00010.txt.bz2

Hi, just ran into a problem which boils down to the following at least with=
 Windows 7:

char *p =3D (char*)malloc(0x80000000UL);	//works fine, allocates memory as =
requested
memset(p, 0, 0x80000000UL);			//Watch process segfault.

The RtlFillMemory either crashes or underfills the buffer depending on the =
size given.
Looks like internally it treats size as a signed 4-byte integer.

Please apply the patch below or implement an alternative.

Roman.



=46rom 60ed745b75d16755769653f19882335ef69960dd Mon Sep 17 00:00:00 2001
From: Roman Petrovski <rpetrovski@illumina.com>
Date: Wed, 29 Jul 2015 06:45:45 -0700
Subject: [PATCH] RtlFillMemory fails on block sizes over 0x7fffffff

---
 winsup/cygwin/miscfuncs.cc | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/miscfuncs.cc b/winsup/cygwin/miscfuncs.cc
index 4a7a1b8..7308498 100644
--- a/winsup/cygwin/miscfuncs.cc
+++ b/winsup/cygwin/miscfuncs.cc
@@ -904,17 +904,35 @@ err:
 extern "C" void NTAPI RtlFillMemory (PVOID, SIZE_T, BYTE);
 extern "C" void NTAPI RtlCopyMemory (PVOID, const VOID *, SIZE_T);

+
+static const size_t RTL_MAX_SIZE =3D 0x7fffffff;
 extern "C" void *
 memset (void *s, int c, size_t n)
 {
-  RtlFillMemory (s, n, c);
+  char *p =3D (char*)s;
+  while (n)
+  {
+    size_t size =3D min(RTL_MAX_SIZE, n);
+    RtlFillMemory (p, size, c);
+    p +=3D size;
+    n -=3D size;
+  }
   return s;
 }

 extern "C" void *
 memcpy(void *__restrict dest, const void *__restrict src, size_t n)
 {
-  RtlCopyMemory (dest, src, n);
+  char *d =3D (char*)dest;
+  char *s =3D (char*)src;
+  while (n)
+  {
+    size_t size =3D min(RTL_MAX_SIZE, n);
+    RtlCopyMemory (d, s, n);
+    d +=3D size;
+    s +=3D size;
+    n -=3D size;
+  }
   return dest;
 }
 #endif
--
2.4.5
