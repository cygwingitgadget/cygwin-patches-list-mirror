Return-Path: <dra27@hermes.cam.ac.uk>
Received: from ppsw-31.csi.cam.ac.uk (ppsw-31.csi.cam.ac.uk [131.111.8.131])
 by sourceware.org (Postfix) with ESMTPS id A30E2385800E
 for <cygwin-patches@cygwin.com>; Tue, 20 Jul 2021 15:15:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org A30E2385800E
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cl.cam.ac.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=hermes.cam.ac.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cam.ac.uk; 
 s=20180806.ppsw;
 h=Sender:Content-Type:MIME-Version:Message-ID:Date:Subject:
 To:From:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5zI2hSpLR7TPUtocvSCW0hIHZ+duNyzfSFYVzrKfX3o=; b=NitdE4PP2FjiX6dkLqCv4fqYXb
 i9ujdJ5HzkpOwH9z1mn4eG13Z6mzOaBuJGt9DHLg3gIU89R3xdHs1v8wRarmfxrUUhDZ9U0QBjv+V
 8O6m7rfQjQDWLdPSGivwjbN5tyR2x6V2CKhkxBgJKK0hjwiKJ5rrlVIkCGUMrRHR9ccw=;
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: https://help.uis.cam.ac.uk/email-scanner-virus
Received: from [62.31.23.242] (port=57877 helo=Libera)
 by ppsw-31.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:25)
 with esmtpsa (LOGIN:dra27) (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
 id 1m5rTF-000qzY-Kx (Exim 4.94.2) for cygwin-patches@cygwin.com
 (return-path <dra27@hermes.cam.ac.uk>); Tue, 20 Jul 2021 16:15:45 +0100
Reply-To: <David.Allsopp@cl.cam.ac.uk>
From: "David Allsopp" <David.Allsopp@cl.cam.ac.uk>
To: <cygwin-patches@cygwin.com>
Subject: Fix nanosleep returning negative rem
Date: Tue, 20 Jul 2021 16:16:16 +0100
Organization: University of Cambridge
Message-ID: <000201d77d7a$2faae510$8f00af30$@cl.cam.ac.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_NextPart_000_0003_01D77D82.916F9B30"
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Add9eS/VixoQahcVTP2uK87XyOsdjg==
Content-Language: en-gb
Sender: David Allsopp <dra27@hermes.cam.ac.uk>
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50, DKIMWL_WL_MED,
 DKIM_SIGNED, DKIM_VALID, DKIM_VALID_EF, JMQ_SPF_NEUTRAL, RCVD_IN_MSPIKE_H3,
 RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=no autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 20 Jul 2021 15:15:48 -0000

This is a multipart message in MIME format.

------=_NextPart_000_0003_01D77D82.916F9B30
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I've pushed a repro case for this to
https://github.com/dra27/cygwin-nanosleep-bug.git

Originally noticed as the main CI system for OCaml has been failing
sporadically for the signal.ml test mentioned in that repo. This morning I
tried hammering that test on my dev machine and discovered that it fails
very frequently. No idea if that's drivers, Windows 10 updates, number of
cores or what, but it was definitely happening, and easily.

Drilling further, it appears that NtQueryTimer is able to return a negative
value in the TimeRemaining field even when SignalState is false. The values
I've seen have always been < 15ms - i.e. less than the timer resolution, so
I wonder if there is a point at which the timer has elapsed but has not been
signalled, but WaitForMultipleObjects returns because of the EINTR signal.
Mildly surprising that it seems to be so reproducible.

Anyway, a patch is attached which simply guards a negative return value. The
test on tbi.SignalState is in theory unnecessary.

All best,


David

------=_NextPart_000_0003_01D77D82.916F9B30
Content-Type: application/octet-stream;
	name="0001-Ensure-nanosleep-2-never-returns-negative-rem.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Ensure-nanosleep-2-never-returns-negative-rem.patch"

From 24f5adc3ac8246d93582ac6e4b2779b369f8b3f1 Mon Sep 17 00:00:00 2001=0A=
From: David Allsopp <david.allsopp@metastack.com>=0A=
Date: Tue, 20 Jul 2021 16:07:00 +0100=0A=
Subject: [PATCH] Ensure nanosleep(2) never returns negative rem=0A=
=0A=
It appears to be the case that NtQueryTimer can return a negative time=0A=
remaining for an unsignalled timer. The value appears to be less than=0A=
the timer resolution.=0A=
=0A=
Signed-off-by: David Allsopp <david.allsopp@metastack.com>=0A=
---=0A=
 winsup/cygwin/cygwait.cc    | 6 ++++--=0A=
 winsup/cygwin/release/3.2.1 | 4 ++++=0A=
 2 files changed, 8 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/winsup/cygwin/cygwait.cc b/winsup/cygwin/cygwait.cc=0A=
index 1d6c7c9cc..dbbe1db6e 100644=0A=
--- a/winsup/cygwin/cygwait.cc=0A=
+++ b/winsup/cygwin/cygwait.cc=0A=
@@ -104,8 +104,10 @@ cygwait (HANDLE object, PLARGE_INTEGER timeout, =
unsigned mask)=0A=
 		    sizeof tbi, NULL);=0A=
       /* if timer expired, TimeRemaining is negative and represents the=0A=
 	  system uptime when signalled */=0A=
-      if (timeout->QuadPart < 0LL)=0A=
-	timeout->QuadPart =3D tbi.SignalState ? 0LL : =
tbi.TimeRemaining.QuadPart;=0A=
+      if (timeout->QuadPart < 0LL) {=0A=
+	timeout->QuadPart =3D tbi.SignalState || tbi.TimeRemaining.QuadPart < =
0LL=0A=
+                            ? 0LL : tbi.TimeRemaining.QuadPart;=0A=
+      }=0A=
       NtCancelTimer (_my_tls.locals.cw_timer, NULL);=0A=
     }=0A=
 =0A=
diff --git a/winsup/cygwin/release/3.2.1 b/winsup/cygwin/release/3.2.1=0A=
index 4f4db622a..2a339718c 100644=0A=
--- a/winsup/cygwin/release/3.2.1=0A=
+++ b/winsup/cygwin/release/3.2.1=0A=
@@ -44,3 +44,7 @@ Bug Fixes=0A=
   AF_UNSPEC.  As specified by POSIX and Linux, this is allowed on=0A=
   datagram sockets, and its effect is to reset the socket's peer=0A=
   address.=0A=
+=0A=
+- Fix nanosleep(2) returning negative rem. NtQueryTimer appears to be =
able to=0A=
+  return a negative remaining time (less than the timer resolution) for=0A=
+  unsignalled timers.=0A=
-- =0A=
2.29.2.windows.2=0A=
=0A=

------=_NextPart_000_0003_01D77D82.916F9B30--

