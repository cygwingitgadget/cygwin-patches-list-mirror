Return-Path: <SRS0=LDpO=F4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:29])
	by sourceware.org (Postfix) with ESMTPS id 3AC364BB1C04
	for <cygwin-patches@cygwin.com>; Mon,  3 Aug 2026 02:50:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3AC364BB1C04
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3AC364BB1C04
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:29
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1785725425; cv=none;
	b=tgP9iW6OlM2xjw8faopi/dyrHd2QAKJK6yzkU5P7FIvm545Apm0KlTtjmWTn2vfw4gwUNxbzu2FwRwTlkQp/l935ZR0jCa+2ZO6Izi5kRCz9fWozd8WIa7US8Tw1/Mg+w1JpLTCxl/HDKQR4eOqfHc+t/QOOf/GlHeZRw+iuU14=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1785725425; c=relaxed/simple;
	bh=bMpavbK82a5+QME7UlZl2PWVJBIXTtHppmomLBAOohY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=SnxexUv/5KfFgE1GqO9LKOwjpDTlUWWgp1IjIMBsTrjrBHslXb8BE9HT4kCxw+ETL01cklzP3LkGAKuLLtC9c4nO7cBg2l2GQBut9NPdmi77j5bcXCwPW6nk2twzS7N9mJSnUTWxwXhYMSNmO88+5w0zxrIU/O7zNOGqsZtapJQ=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=kSshJjuY
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3AC364BB1C04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=kSshJjuY
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20260803025022928.ZCZN.60338.HP-Z230@nifty.com>;
          Mon, 3 Aug 2026 11:50:22 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Steven Doerfler <sgd-cygwinlist@lugaru.com>
Subject: [PATCH] Cygwin: console: Fix regression in console input
Date: Mon,  3 Aug 2026 11:49:59 +0900
Message-ID: <20260803025011.5289-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1785725423;
 bh=ig3QjFs879pvurK+uXrMY+IcZUgw7v44t5ZfbTfhce8=;
 h=From:To:Cc:Subject:Date;
 b=kSshJjuYTPZ5JKthPwA5YngYHn/0/a5l7ndIyug+eERA5+VGQwAMgQA1tGMsAbQb+UD3FX+N
 gp1ojqakrApaK8huCot1Nd8KpoOE5ARYVSJ5LtYf3GD9wEVv31JKumdBYo0yGmhod7MKifhgKO
 Is+0JXADiUKSeF6rDJ+DoArNhFHnDJidLKQ3c26+FLUvgRxkRBzfdz4HjDxYreeYAute4VpsMa
 b8eFUGGpYr/U2RnRE2fv/Y2C1KEbSmEL3E5LAWd4qag/hzUo6cbCP0/EtcRig54E6wY2KBxinM
 cJaiZekX3EXO3mLNhU9B//vozMauP1UNEdcu/DATD636DGgg==
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The commit fac73911f5a0 ("Cygwin: console: Fix typeahead input for
bash") introduced a bug where select() consumes some input chars in
canonical mode, preventing read() from reading them. This is due to
discarding input events when process_input_message() does not return
`input_ok` even if it is called from select().
The basic idea of that commit was making process_input_message()
not to store processed chars into readahead buffer. This was not
correct because the key input events ware processed twice, once by
select() and again by read(). Thus even if that commit worked as
intended, the side effect such as input echo would be applied twice.

With this patch, process_input_message() handles only the minimum
necessary of input events in both cases, those processed by select()
and those processed by read(). To achive this behaviour, the function
returns without processing when `input_ready` is already satisfied,
or after it has processed the specified number of chars.

Addresses: https://cygwin.com/pipermail/cygwin/2026-August/259915.html
Reported-by: Steven Doerfler <sgd-cygwinlist@lugaru.com>
Fixes: fac73911f5a0 ("Cygwin: console: Fix typeahead input for bash")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Revewed-by:
---
 winsup/cygwin/fhandler/console.cc | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 0219a37ef..3904fbd57 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -1406,7 +1406,6 @@ fhandler_console::input_states
 fhandler_console::process_input_message (size_t len)
 {
   char tmp[60];
-  size_t num_chars = 0;
 
   if (!shared_console_info[unit])
     return input_error;
@@ -1429,6 +1428,10 @@ fhandler_console::process_input_message (size_t len)
       return input_error;
     }
 
+  /* len == 0 if called from select.cc:peek_console() */
+  if (input_ready && (len == 0 || (get_ttyp ()->ti.c_lflag & ICANON)))
+    return input_ok;
+
   for (i = 0; i < total_read; i ++)
     {
       DWORD nread = 1;
@@ -1794,7 +1797,6 @@ fhandler_console::process_input_message (size_t len)
 	}
 
       num_input_events_processed = i + 1;
-      num_chars += nread;
       if (toadd)
 	{
 	  ssize_t ret;
@@ -1813,21 +1815,17 @@ fhandler_console::process_input_message (size_t len)
 	    }
 	}
       /* len == 0 if called from select.cc:peek_console() */
-      if (len && num_chars >= len)
+      if (input_ready && (len == 0 || con_ra.ralen >= len))
 	goto out;
     }
 out:
-  if (len == 0)
-    /* If len == 0, cancel reading from console input buffer.
-       Clear readahead buffer. */
-    eat_readahead (-1);
   /* Discard processed recored. */
   DWORD discard_len = min (total_read, i + 1);
   /* If input is signalled, do not discard input here because
      discard_key_events() is already called from line_edit(). */
   if (stat == input_signalled)
     discard_len = 0;
-  if (discard_len && (len || stat != input_ok))
+  if (discard_len)
     discard_key_events (discard_len);
   return stat;
 }
-- 
2.51.0

