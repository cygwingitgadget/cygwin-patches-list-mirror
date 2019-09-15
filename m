Return-Path: <cygwin-patches-return-9688-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 49433 invoked by alias); 15 Sep 2019 16:28:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 49418 invoked by uid 89); 15 Sep 2019 16:28:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-14.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Spam-Relays-External:ESMTPA
X-HELO: vsmx012.vodafonemail.xion.oxcs.net
Received: from vsmx012.vodafonemail.xion.oxcs.net (HELO vsmx012.vodafonemail.xion.oxcs.net) (153.92.174.90) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 15 Sep 2019 16:28:32 +0000
Received: from vsmx004.vodafonemail.xion.oxcs.net (unknown [192.168.75.198])	by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTP id DDB7FF34E30	for <cygwin-patches@cygwin.com>; Sun, 15 Sep 2019 16:28:29 +0000 (UTC)
Received: from Gertrud (unknown [84.160.192.162])	by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTPA id B007619ADBA	for <cygwin-patches@cygwin.com>; Sun, 15 Sep 2019 16:28:27 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH] winsup/cygwin/times.cc (times): follow Linux and allow for a NULL buf argument
Date: Sun, 15 Sep 2019 16:28:00 -0000
Message-ID: <87pnk17cd6.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SW-Source: 2019-q3/txt/msg00208.txt.bz2


Adresses a problem reported on the Cygwin list.

---
 winsup/cygwin/times.cc | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/times.cc b/winsup/cygwin/times.cc
index 8908d44f1..909cae1f1 100644
--- a/winsup/cygwin/times.cc
+++ b/winsup/cygwin/times.cc
@@ -72,12 +72,17 @@ times (struct tms *buf)
       /* ticks is in in 100ns, convert to clock ticks. */
       tc = (clock_t) (ticks.QuadPart * CLOCKS_PER_SEC / NS100PERSEC);
 
-      buf->tms_stime = __to_clock_t (&kut.KernelTime, 0);
-      buf->tms_utime = __to_clock_t (&kut.UserTime, 0);
-      timeval_to_filetime (&myself->rusage_children.ru_stime, &kut.KernelTime);
-      buf->tms_cstime = __to_clock_t (&kut.KernelTime, 1);
-      timeval_to_filetime (&myself->rusage_children.ru_utime, &kut.UserTime);
-      buf->tms_cutime = __to_clock_t (&kut.UserTime, 1);
+      /* Linux allows a NULL buf and just returns tc in that case, so
+	 mimic that */
+      if (buf)
+	{
+	  buf->tms_stime = __to_clock_t (&kut.KernelTime, 0);
+	  buf->tms_utime = __to_clock_t (&kut.UserTime, 0);
+	  timeval_to_filetime (&myself->rusage_children.ru_stime, &kut.KernelTime);
+	  buf->tms_cstime = __to_clock_t (&kut.KernelTime, 1);
+	  timeval_to_filetime (&myself->rusage_children.ru_utime, &kut.UserTime);
+	  buf->tms_cutime = __to_clock_t (&kut.UserTime, 1);
+	}
     }
   __except (EFAULT)
     {
-- 
2.23.0


Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

SD adaptation for Waldorf rackAttack V1.04R1:
http://Synth.Stromeko.net/Downloads.html#WaldorfSDada
