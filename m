Return-Path: <SRS0=geUt=NJ=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-044.btinternet.com (mailomta11-sa.btinternet.com [213.120.69.17])
	by sourceware.org (Postfix) with ESMTPS id E8916381C6E6
	for <cygwin-patches@cygwin.com>; Fri,  7 Jun 2024 16:37:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E8916381C6E6
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E8916381C6E6
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=213.120.69.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1717778274; cv=none;
	b=U6lBW7HjXr4s9Eoa6blNQlTLhMrcwAKNLD46hvs5ferQNfnu/o6c32JVE4bKbel5J5ZdsMGerIp3Tu5dtqnr2VaDlOmHOdB+ieOH3Q2B1sabz6aJ+ceeEY+rQlI6QxeSBrOM/V3oHWsODiVgI0kQupr6wa86OiWWjVodGI+Zr2g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1717778274; c=relaxed/simple;
	bh=myni88fFaJClqmrZpNBOGsmnP+LxpnUPebeuNWCqR3Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=cC05hPQrKFtbAjwn8BkPlnP1bOL/IWYkEPZr0B8DSjKlztNSVxRfC74cnTjM+UdY57zEuuGfn3PEB2eDU0EHYf5rxC8q7cZLy5GbkiS4rwWSsE7xyUbo7hoYq42erlcW1YWrg9qPR+0Mj8FfhkhD2cGl1UpswNwG3M7xPL+oqy8=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
          by sa-prd-fep-044.btinternet.com with ESMTP
          id <20240607163742.KPCR11931.sa-prd-fep-044.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
          Fri, 7 Jun 2024 17:37:42 +0100
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 65A566C2102B954E
X-Originating-IP: [86.139.167.83]
X-OWM-Source-IP: 86.139.167.83
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvledrfedtuddgjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeehvdffgedukeeffeefieegudelffeuteffueffudfhjefghfehvddvudefkeejkeenucfkphepkeeirddufeelrdduieejrdekfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeelrdduieejrdekfedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudefledqudeijedqkeefrdhrrghnghgvkeeiqddufeelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgv
	ohfkrfepifeupdfovfetjfhoshhtpehsrgdqphhrugdqrhhgohhuthdqtddtge
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.167.83) by sa-prd-rgout-004.btmx-prd.synchronoss.net (authenticated as jonturney@btinternet.com)
        id 65A566C2102B954E; Fri, 7 Jun 2024 17:37:42 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: Suppress a warning generated with w32api >= 12.0.0
Date: Fri,  7 Jun 2024 17:37:24 +0100
Message-ID: <20240607163724.29390-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1198.0 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,TXREP,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

w32api 12.0.0 adds the returns_twice attribute to RtlCaptureContext().
There's some data-flow interaction with using it inside a while loop
which causes a maybe-uninitialized warning.

../../../../winsup/cygwin/exceptions.cc: In member function 'int _cygtls::call_signal_handler()':                                                                                                │
../../../../winsup/cygwin/exceptions.cc:1720:33: error: '<anonymous>' may be used uninitialized in this function [-Werror=maybe-uninitialized]                                                   │
---
 winsup/cygwin/exceptions.cc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index a2a6f9d4c..28d0431d5 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1717,7 +1717,10 @@ _cygtls::call_signal_handler ()
 		 context, unwind to the caller and in case we're called
 		 from sigdelayed, fix the instruction pointer accordingly. */
 	      context.uc_mcontext.ctxflags = CONTEXT_FULL;
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wmaybe-uninitialized"
 	      RtlCaptureContext ((PCONTEXT) &context.uc_mcontext);
+#pragma GCC diagnostic pop
 	      __unwind_single_frame ((PCONTEXT) &context.uc_mcontext);
 	      if (stackptr > stack)
 		{
-- 
2.45.1

