Return-Path: <cygwin-patches-return-9787-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 76480 invoked by alias); 22 Oct 2019 17:52:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 76464 invoked by uid 89); 22 Oct 2019 17:52:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-15.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.1 spammy=USB, usb, device, HX-Spam-Relays-External:ESMTPA
X-HELO: vsmx009.vodafonemail.xion.oxcs.net
Received: from vsmx009.vodafonemail.xion.oxcs.net (HELO vsmx009.vodafonemail.xion.oxcs.net) (153.92.174.87) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 22 Oct 2019 17:52:45 +0000
Received: from vsmx001.vodafonemail.xion.oxcs.net (unknown [192.168.75.191])	by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTP id 584AC159D748	for <cygwin-patches@cygwin.com>; Tue, 22 Oct 2019 17:52:43 +0000 (UTC)
Received: from Gertrud (unknown [84.160.192.162])	by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 2A693159D74E	for <cygwin-patches@cygwin.com>; Tue, 22 Oct 2019 17:52:40 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Provide more COM devices
References: <87mudvwnrl.fsf@Rainer.invalid>	<20191021081844.GH16240@calimero.vinschen.de>	<87pniq7yvm.fsf@Rainer.invalid>	<20191022071622.GM16240@calimero.vinschen.de>	<87d0eo65s5.fsf@Rainer.invalid>	<20191022174151.GV16240@calimero.vinschen.de>
Date: Tue, 22 Oct 2019 17:52:00 -0000
In-Reply-To: <20191022174151.GV16240@calimero.vinschen.de> (Corinna Vinschen's	message of "Tue, 22 Oct 2019 19:41:51 +0200")
Message-ID: <878spc651z.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SW-Source: 2019-q4/txt/msg00058.txt.bz2


As requested:

From 7908d09f547e0a7a707139d0faaccc151b88024c Mon Sep 17 00:00:00 2001
From: Achim Gratz <Stromeko@Stromeko.DE>
Date: Tue, 22 Oct 2019 19:50:50 +0200
Subject: [PATCH] Cygwin: provide more COM devices

* winsup/cygwin/devices.in: Provide for 128 COM devices since Windows
  likes to create lots of these over time (one per identifiable device
  and USB port).
---
 winsup/cygwin/devices.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/devices.in b/winsup/cygwin/devices.in
index 59f5f00d2..9a42951f6 100644
--- a/winsup/cygwin/devices.in
+++ b/winsup/cygwin/devices.in
@@ -164,7 +164,7 @@ const _device dev_error_storage =
 "/dev/urandom", BRACK(FH_URANDOM), "\\Device\\Null", exists_ntdev, S_IFCHR, =urandom_dev
 "/dev/clipboard", BRACK(FH_CLIPBOARD), "\\Device\\Null", exists_ntdev, S_IFCHR
 "/dev/com%(1-16)d", BRACK(FHDEV(DEV_SERIAL_MAJOR, {$1 - 1})), "\\??\\COM{$1}", exists_ntdev_silent, S_IFCHR
-"/dev/ttyS%(0-63)d", BRACK(FHDEV(DEV_SERIAL_MAJOR, {$1})), "\\??\\COM{$1 + 1}", exists_ntdev, S_IFCHR
+"/dev/ttyS%(0-127)d", BRACK(FHDEV(DEV_SERIAL_MAJOR, {$1})), "\\??\\COM{$1 + 1}", exists_ntdev, S_IFCHR
 ":pipe", BRACK(FH_PIPE), "/dev/pipe", exists_internal, S_IFCHR
 ":fifo", BRACK(FH_FIFO), "/dev/fifo", exists_internal, S_IFCHR
 "/dev/st%(0-127)d", BRACK(FHDEV(DEV_TAPE_MAJOR, {$1})), "\\Device\\Tape{$1}", exists_ntdev, S_IFBLK
-- 
2.23.0


Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Waldorf MIDI Implementation & additional documentation:
http://Synth.Stromeko.net/Downloads.html#WaldorfDocs
