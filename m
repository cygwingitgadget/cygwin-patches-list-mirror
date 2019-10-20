Return-Path: <cygwin-patches-return-9767-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31876 invoked by alias); 20 Oct 2019 13:27:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 31821 invoked by uid 89); 20 Oct 2019 13:27:22 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-14.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.1 spammy=USB, irc, IRC, usb
X-HELO: vsmx011.vodafonemail.xion.oxcs.net
Received: from vsmx011.vodafonemail.xion.oxcs.net (HELO vsmx011.vodafonemail.xion.oxcs.net) (153.92.174.89) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 20 Oct 2019 13:27:19 +0000
Received: from vsmx003.vodafonemail.xion.oxcs.net (unknown [192.168.75.197])	by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTP id 0CEE059CDEC	for <cygwin-patches@cygwin.com>; Sun, 20 Oct 2019 13:27:17 +0000 (UTC)
Received: from Gertrud (unknown [84.160.192.162])	by mta-7-out.mta.xion.oxcs.net (Postfix) with ESMTPA id D4827539A01	for <cygwin-patches@cygwin.com>; Sun, 20 Oct 2019 13:27:14 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: Provide more COM devices
Date: Sun, 20 Oct 2019 13:27:00 -0000
Message-ID: <87mudvwnrl.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SW-Source: 2019-q4/txt/msg00038.txt.bz2


This was requested on IRC.

From a80b1c9ba67f94237948e85ad2dee744cdfbdcad Mon Sep 17 00:00:00 2001
From: Achim Gratz <Stromeko@Stromeko.DE>
Date: Sun, 20 Oct 2019 15:23:04 +0200
Subject: [PATCH] Cygwin: provide more COM devices

* winsup/cygwin/devices.cc: Add another 64 COM devices since Windows
  likes to create lots of these over time (one per identifiable device
  and USB port).
---
 winsup/cygwin/devices.cc | 64 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/winsup/cygwin/devices.cc b/winsup/cygwin/devices.cc
index 2e31ca366..7a57459d8 100644
--- a/winsup/cygwin/devices.cc
+++ b/winsup/cygwin/devices.cc
@@ -798,6 +798,70 @@ const _RDATA _device dev_storage[] =
   {"/dev/ttyS61", BRACK(FHDEV(DEV_SERIAL_MAJOR, 61)), "\\??\\COM62", exists_ntdev, S_IFCHR, true},
   {"/dev/ttyS62", BRACK(FHDEV(DEV_SERIAL_MAJOR, 62)), "\\??\\COM63", exists_ntdev, S_IFCHR, true},
   {"/dev/ttyS63", BRACK(FHDEV(DEV_SERIAL_MAJOR, 63)), "\\??\\COM64", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS64", BRACK(FHDEV(DEV_SERIAL_MAJOR, 64)), "\\??\\COM65", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS65", BRACK(FHDEV(DEV_SERIAL_MAJOR, 65)), "\\??\\COM66", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS66", BRACK(FHDEV(DEV_SERIAL_MAJOR, 66)), "\\??\\COM67", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS67", BRACK(FHDEV(DEV_SERIAL_MAJOR, 67)), "\\??\\COM68", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS68", BRACK(FHDEV(DEV_SERIAL_MAJOR, 68)), "\\??\\COM69", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS69", BRACK(FHDEV(DEV_SERIAL_MAJOR, 69)), "\\??\\COM70", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS70", BRACK(FHDEV(DEV_SERIAL_MAJOR, 70)), "\\??\\COM71", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS71", BRACK(FHDEV(DEV_SERIAL_MAJOR, 71)), "\\??\\COM72", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS72", BRACK(FHDEV(DEV_SERIAL_MAJOR, 72)), "\\??\\COM73", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS73", BRACK(FHDEV(DEV_SERIAL_MAJOR, 73)), "\\??\\COM74", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS74", BRACK(FHDEV(DEV_SERIAL_MAJOR, 74)), "\\??\\COM75", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS75", BRACK(FHDEV(DEV_SERIAL_MAJOR, 75)), "\\??\\COM76", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS76", BRACK(FHDEV(DEV_SERIAL_MAJOR, 76)), "\\??\\COM77", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS77", BRACK(FHDEV(DEV_SERIAL_MAJOR, 77)), "\\??\\COM78", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS78", BRACK(FHDEV(DEV_SERIAL_MAJOR, 78)), "\\??\\COM79", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS79", BRACK(FHDEV(DEV_SERIAL_MAJOR, 79)), "\\??\\COM80", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS80", BRACK(FHDEV(DEV_SERIAL_MAJOR, 80)), "\\??\\COM81", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS81", BRACK(FHDEV(DEV_SERIAL_MAJOR, 81)), "\\??\\COM82", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS82", BRACK(FHDEV(DEV_SERIAL_MAJOR, 82)), "\\??\\COM83", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS83", BRACK(FHDEV(DEV_SERIAL_MAJOR, 83)), "\\??\\COM84", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS84", BRACK(FHDEV(DEV_SERIAL_MAJOR, 84)), "\\??\\COM85", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS85", BRACK(FHDEV(DEV_SERIAL_MAJOR, 85)), "\\??\\COM86", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS86", BRACK(FHDEV(DEV_SERIAL_MAJOR, 86)), "\\??\\COM87", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS87", BRACK(FHDEV(DEV_SERIAL_MAJOR, 87)), "\\??\\COM88", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS88", BRACK(FHDEV(DEV_SERIAL_MAJOR, 88)), "\\??\\COM89", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS89", BRACK(FHDEV(DEV_SERIAL_MAJOR, 89)), "\\??\\COM90", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS90", BRACK(FHDEV(DEV_SERIAL_MAJOR, 90)), "\\??\\COM91", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS91", BRACK(FHDEV(DEV_SERIAL_MAJOR, 91)), "\\??\\COM92", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS92", BRACK(FHDEV(DEV_SERIAL_MAJOR, 92)), "\\??\\COM93", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS93", BRACK(FHDEV(DEV_SERIAL_MAJOR, 93)), "\\??\\COM94", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS94", BRACK(FHDEV(DEV_SERIAL_MAJOR, 94)), "\\??\\COM95", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS95", BRACK(FHDEV(DEV_SERIAL_MAJOR, 95)), "\\??\\COM96", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS96", BRACK(FHDEV(DEV_SERIAL_MAJOR, 96)), "\\??\\COM97", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS97", BRACK(FHDEV(DEV_SERIAL_MAJOR, 97)), "\\??\\COM98", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS98", BRACK(FHDEV(DEV_SERIAL_MAJOR, 98)), "\\??\\COM99", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS99", BRACK(FHDEV(DEV_SERIAL_MAJOR, 99)), "\\??\\COM100", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS100", BRACK(FHDEV(DEV_SERIAL_MAJOR, 100)), "\\??\\COM101", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS101", BRACK(FHDEV(DEV_SERIAL_MAJOR, 101)), "\\??\\COM102", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS102", BRACK(FHDEV(DEV_SERIAL_MAJOR, 102)), "\\??\\COM103", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS103", BRACK(FHDEV(DEV_SERIAL_MAJOR, 103)), "\\??\\COM104", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS104", BRACK(FHDEV(DEV_SERIAL_MAJOR, 104)), "\\??\\COM105", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS105", BRACK(FHDEV(DEV_SERIAL_MAJOR, 105)), "\\??\\COM106", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS106", BRACK(FHDEV(DEV_SERIAL_MAJOR, 106)), "\\??\\COM107", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS107", BRACK(FHDEV(DEV_SERIAL_MAJOR, 107)), "\\??\\COM108", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS108", BRACK(FHDEV(DEV_SERIAL_MAJOR, 108)), "\\??\\COM109", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS109", BRACK(FHDEV(DEV_SERIAL_MAJOR, 109)), "\\??\\COM110", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS110", BRACK(FHDEV(DEV_SERIAL_MAJOR, 110)), "\\??\\COM111", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS111", BRACK(FHDEV(DEV_SERIAL_MAJOR, 111)), "\\??\\COM112", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS112", BRACK(FHDEV(DEV_SERIAL_MAJOR, 112)), "\\??\\COM113", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS113", BRACK(FHDEV(DEV_SERIAL_MAJOR, 113)), "\\??\\COM114", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS114", BRACK(FHDEV(DEV_SERIAL_MAJOR, 114)), "\\??\\COM115", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS115", BRACK(FHDEV(DEV_SERIAL_MAJOR, 115)), "\\??\\COM116", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS116", BRACK(FHDEV(DEV_SERIAL_MAJOR, 116)), "\\??\\COM117", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS117", BRACK(FHDEV(DEV_SERIAL_MAJOR, 117)), "\\??\\COM118", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS118", BRACK(FHDEV(DEV_SERIAL_MAJOR, 118)), "\\??\\COM119", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS119", BRACK(FHDEV(DEV_SERIAL_MAJOR, 119)), "\\??\\COM120", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS120", BRACK(FHDEV(DEV_SERIAL_MAJOR, 120)), "\\??\\COM121", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS121", BRACK(FHDEV(DEV_SERIAL_MAJOR, 121)), "\\??\\COM122", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS122", BRACK(FHDEV(DEV_SERIAL_MAJOR, 122)), "\\??\\COM123", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS123", BRACK(FHDEV(DEV_SERIAL_MAJOR, 123)), "\\??\\COM124", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS124", BRACK(FHDEV(DEV_SERIAL_MAJOR, 124)), "\\??\\COM125", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS125", BRACK(FHDEV(DEV_SERIAL_MAJOR, 125)), "\\??\\COM126", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS126", BRACK(FHDEV(DEV_SERIAL_MAJOR, 126)), "\\??\\COM127", exists_ntdev, S_IFCHR, true},
+  {"/dev/ttyS127", BRACK(FHDEV(DEV_SERIAL_MAJOR, 127)), "\\??\\COM128", exists_ntdev, S_IFCHR, true},
   {"/dev/urandom", BRACK(FH_URANDOM), "\\Device\\Null", exists_ntdev, S_IFCHR, true},
   {"/dev/windows", BRACK(FH_WINDOWS), "\\Device\\Null", exists_ntdev, S_IFCHR, true},
   {"/dev/zero", BRACK(FH_ZERO), "\\Device\\Null", exists_ntdev, S_IFCHR, true},
-- 
2.23.0


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Samples for the Waldorf Blofeld:
http://Synth.Stromeko.net/Downloads.html#BlofeldSamplesExtra
