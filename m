Return-Path: <SRS0=R95s=YB=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo009.btinternet.com (btprdrgo009.btinternet.com [65.20.50.104])
	by sourceware.org (Postfix) with ESMTP id 753223858D32
	for <cygwin-patches@cygwin.com>; Sat, 17 May 2025 14:01:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 753223858D32
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 753223858D32
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.104
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1747490471; cv=none;
	b=cEhvlHIEAELlhMU/rqE0beTVx7aHRZjR59UUY7lpEEi0lb9sYnIQJK50drmbK/A6BStCUB2zkimNdOyFOe4VifUK5vpWRaoaL8td4r1pdMk+APOkw1wTDj7n6HZ8dt0WIKBFwKjfuNwV+qeXw854qls4tkQKL5UVRt/5aux7s9U=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1747490471; c=relaxed/simple;
	bh=VIY/jpJcTIIcW9Vl0DkZpyg4+Lse7bhM1E92yEik5q0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Mol/wVt+Ux6DvlNv8vRPSqYpxv2f6aso2EpSNRZ6/QJSKTwuRqAhamkwESMMJT4AuSZ2Q3k+eMqtzI3+0gmuqnhjWRy7X1sr58Tf6e39XEVGZv/SA2Fpr2GtG7TlxlyOp8QroZ8QccQmgSs/QBSbMDt9PTJO6And12c8oAYkJJE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 753223858D32
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89DC906DB3A52
X-Originating-IP: [81.129.146.154]
X-OWM-Source-IP: 81.129.146.154
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudehkedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhephfeugfehhedtgfefvedtveelkefgjeelgeffgfeijeeluefgffetgfdvudduiedunecuffhomhgrihhnpegthihgfihinhdrtghomhenucfkphepkedurdduvdelrddugeeirdduheegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddruddvledrudegiedrudehgedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekuddquddvledqudegiedqudehgedrrhgrnhhgvgekuddquddvledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtledpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgt
	hhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.129.146.154) by btprdrgo009.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89DC906DB3A52; Sat, 17 May 2025 15:01:10 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: Only return true from try_to_debug() if we launched a JIT debugger
Date: Sat, 17 May 2025 15:00:53 +0100
Message-ID: <20250517140054.1826-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This fixes constantly replaying the exception if we have a segfault
while a debugger is already attached, e.g. stracing a segv, see:

https://cygwin.com/pipermail/cygwin/2025-May/258144.html

(I'm tempted to remove the 'debugging' static from exception::handle()
and everything associated with it, since replaying the exception the
next half a million times it's hit seems really weird)

(This would seem to make try_to_debug() less useful, as it then does
nothing if you're just run under gdb, but it's what the code used to
do...)

Fixes: 91457377d6c9 ("Cygwin: Make 'ulimit -c' control writing a coredump")
---
 winsup/cygwin/exceptions.cc | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 9763a1b04..3a0315fd0 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -591,13 +591,16 @@ int exec_prepared_command (PWCHAR command)
 extern "C" int
 try_to_debug ()
 {
+  if (!debugger_command)
+    return 0;
+
   /* If already being debugged, break into the debugger (Note that this function
      can be called from places other than an exception) */
   if (being_debugged ())
     {
       extern void break_here ();
       break_here ();
-      return 1;
+      return 0;
     }
 
   /* Otherwise, invoke the JIT debugger, if set */
@@ -812,6 +815,8 @@ exception::handle (EXCEPTION_RECORD *e, exception_list *frame, CONTEXT *in,
   else if (try_to_debug ())
     {
       debugging = 1;
+      /* If a JIT debugger just attached, replay the exception for the benefit
+	 of that */
       return ExceptionContinueExecution;
     }
 
-- 
2.45.1

