Return-Path: <mhentges@mozilla.com>
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 by sourceware.org (Postfix) with ESMTPS id E46563858C20
 for <cygwin-patches@cygwin.com>; Thu, 10 Feb 2022 15:38:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org E46563858C20
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=mozilla.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=mozilla.com
Received: by mail-io1-xd34.google.com with SMTP id r144so7736234iod.9
 for <cygwin-patches@cygwin.com>; Thu, 10 Feb 2022 07:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mozilla.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oRoPblEMRr8Mr/YO7tL2E1W6+hhg+epvcBVHwKdEEpg=;
 b=GHb4+Mxa9QEJxbjZWAETxv2Qhe4PPfxCEb2WdkSPsGra0beAhgHx7FK60nRtXPI4ku
 JipsnisxBWjEN602mRkeSRpGndNUNWP0QTX+wPctU9A4ovFM/Ih1lVqetjki7cezQLCp
 yHosMnpCjKMqzIjeQjzmtYGFwR2N6ILwmegjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oRoPblEMRr8Mr/YO7tL2E1W6+hhg+epvcBVHwKdEEpg=;
 b=2w9Evlwwjo5t28ISLdzcaeIyYFF+soB0iLTS4ki2pqnuuTArViJnEWfu/QcFwnakEI
 sZM8r2A0UP5I475KcXOjpH+HCWclhplgDKXb7rW1zZrHtMX48EElXVL3cSzfPt4+FIq1
 MWlaY5PnM3Hz987k6CKt6pZZKVINM7qF71SCBpFSTCe3I9LcNiTJ30RISBWjxWvKtNOn
 50QODeDnxOFMldGdwGrbWhIcAlQYPk7LIYAqhdm6jm9B8qLafoBUAv5C1BMyQo7Zm5Bu
 O3kldQ7HaBiDppseiFbnAGUAZ8adIOLHug21c3tad9ai6Hfo8fcif9bN3RwxYfgHSoY/
 z4jQ==
X-Gm-Message-State: AOAM5310zZ2sh4n+sWvh3PmoL90juhGwn5KBE0CKlFZ7S554wsIJ4IOf
 Mec0nc4vtvDk638TnTdbDqqflPbkVqC4ww==
X-Google-Smtp-Source: ABdhPJykBa6QTvsbXkzsqJg/43jZxAXMi9BN6zU85rmErgB0Ke3NoQd+BjfIzoIfmM2Sn8GV8dOqOg==
X-Received: by 2002:a05:6638:2492:: with SMTP id
 x18mr4253059jat.164.1644507496048; 
 Thu, 10 Feb 2022 07:38:16 -0800 (PST)
Received: from localhost
 (bras-base-hmtnon143hw-grc-07-174-91-106-15.dsl.bell.ca. [174.91.106.15])
 by smtp.gmail.com with ESMTPSA id k10sm2858686ilu.63.2022.02.10.07.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Feb 2022 07:38:15 -0800 (PST)
From: Mitchell Hentges <mhentges@mozilla.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/1] Cygwin: console: Maintain EXTENDED_FLAGS state
Date: Thu, 10 Feb 2022 10:38:08 -0500
Message-Id: <20220210153808.2655-1-mhentges@mozilla.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220210170756.a2efb012fdc916e3873b1b55@nifty.ne.jp>
References: <20220210170756.a2efb012fdc916e3873b1b55@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Thu, 10 Feb 2022 15:38:20 -0000

As well-described over in this post [1], it's possible for
the active console mode to be impossible to correctly determine.
Specifically, if ENABLE_EXTENDED_FLAGS is at any point unset,
then the flags it's associated with (ENABLE_INSERT_MODE,
ENABLE_QUICK_EDIT_MODE) will no longer be discoverable - they'll
always show up as unset, regardless of real console state.

It's not possible to work around this by setting
ENABLE_EXTENDED_FLAGS once then re-querying, because setting
ENABLE_EXTENDED_FLAGS on it's own will *disable* its related
flags.

Anyways, to avoid this case, all programs doing SetConsoleMode()
must be good community citizens and carefully maintain its state.
Unfortunately, we're accidentally stepping on this in
fhandler_console::set_input_mode().

This patch solves this by carrying forward ENABLED_EXTENDED_FLAGS
and friends in the only place where it had been ignoring it.
Since the previous behaviour of leaving all three flags unset would
essentially maintain their existing state (except for the footgun
being worked around here), *adding* the carry-over of the flags now
should not alter console behaviour.
---
 winsup/cygwin/fhandler_console.cc | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 7a1a45bc1..b2554c3ba 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -458,16 +458,18 @@ void
 fhandler_console::set_input_mode (tty::cons_mode m, const termios *t,
 				  const handle_set_t *p)
 {
-  DWORD flags = 0, oflags;
+  DWORD oflags;
   WaitForSingleObject (p->input_mutex, mutex_timeout);
   GetConsoleMode (p->input_handle, &oflags);
+  DWORD flags = oflags
+      & (ENABLE_EXTENDED_FLAGS | ENABLE_INSERT_MODE | ENABLE_QUICK_EDIT_MODE);
   switch (m)
     {
     case tty::restore:
-      flags = ENABLE_ECHO_INPUT | ENABLE_LINE_INPUT | ENABLE_PROCESSED_INPUT;
+      flags |= ENABLE_ECHO_INPUT | ENABLE_LINE_INPUT | ENABLE_PROCESSED_INPUT;
       break;
     case tty::cygwin:
-      flags = ENABLE_WINDOW_INPUT;
+      flags |= ENABLE_WINDOW_INPUT;
       if (wincap.has_con_24bit_colors () && !con_is_legacy)
 	flags |= ENABLE_VIRTUAL_TERMINAL_INPUT;
       else
-- 
2.35.1

