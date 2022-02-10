Return-Path: <mhentges@mozilla.com>
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 by sourceware.org (Postfix) with ESMTPS id 7D0DC3858D1E
 for <cygwin-patches@cygwin.com>; Thu, 10 Feb 2022 00:09:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 7D0DC3858D1E
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=mozilla.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=mozilla.com
Received: by mail-yb1-xb32.google.com with SMTP id p5so10601527ybd.13
 for <cygwin-patches@cygwin.com>; Wed, 09 Feb 2022 16:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mozilla.com; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=vaWDZ+K0jDOxevYItqVASkO1ndMNafsaeIkp8N8le7I=;
 b=Qmsk0S9BBH30Rbvxm+rzoj7pWQIa5QGgiaSESDaAN4tENPkMzQHdAXmNfF6nzGu85B
 vCHDZ7CAWmOl8ynPolKEAexSgp8AgEADTw8vB/DiPJHCMl8U1rxbTF7D9sPtKjZbdT+a
 Fpym/z15v0a96E2KCHuwv4lhE4jqlpzztvdhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=vaWDZ+K0jDOxevYItqVASkO1ndMNafsaeIkp8N8le7I=;
 b=TKsJeNp58yOnGNa6E1WmzHoX9EDnKtRS5AKq9+PQ6R+0vngK9gIsA4RxNCVDbz5c+K
 Nv0bzuB2DmWpV6fhmPIus0HL+rRKO8MuQJxETd2rDx98LaG9/6qV1ea9nir+CMg3RjFz
 mEe1Q2AfQkZ8KwGrpETDg+WoAVYbFkV3L4MTYZeclW0BVU/NbKsIwWyXbMFP/GhfjHvZ
 fAd9tgrYEzR9Y16dJK/Fk2EDK+QVDQtXnDeVMzu334ZGXe6OWPjV9szMObeER6K1oZ48
 5V0FtU0rm7akXoQ9zxn+HUUSWBs+AV9a/+9HoQqjXZrUAERQZtJsXi8JR6V0lTTflNIZ
 SzQg==
X-Gm-Message-State: AOAM530Eiv8cw1rPS/V7b/N509awMFI0kruPb4OGT+FpbbyexUUxRSvn
 9+zkF+sMeWb0n7Tjhl5VzyUs+LNPGaUk+eNUMJ1l5YU7fccrXA==
X-Google-Smtp-Source: ABdhPJwMBd8j4yR76sGMFP+Q12JQhMItSa4M5C6Iu8lywg34ReJgu49iddtap/UI0LC3lRDlDoeezOBr7tHBeAits+8=
X-Received: by 2002:a5b:804:: with SMTP id x4mr4814814ybp.673.1644451753876;
 Wed, 09 Feb 2022 16:09:13 -0800 (PST)
MIME-Version: 1.0
From: Mitchell Hentges <mhentges@mozilla.com>
Date: Wed, 9 Feb 2022 19:09:02 -0500
Message-ID: <CAAvot89oYw7QF8YNMGp9fGTRsB18u2of1TFw-g_B4GWctLtFDw@mail.gmail.com>
Subject: [PATCH 1/1] Cygwin: console: Maintain EXTENDED_FLAGS state
To: cygwin-patches@cygwin.com
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, HTML_MESSAGE,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
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
X-List-Received-Date: Thu, 10 Feb 2022 00:09:17 -0000

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
(and friends) in the only place where it had been ignored: set_input_mode()
Since the previous behaviour of leaving all three flags unset would
essentially maintain their existing state (except for the footgun
being worked around here), *adding* the carry-over of the flags now
should not alter console behaviour.

[1] https://www.os2museum.com/wp/disabling-quick-edit-mode/
---
 winsup/cygwin/fhandler_console.cc | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc
b/winsup/cygwin/fhandler_console.cc
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
+      & (ENABLE_EXTENDED_FLAGS | ENABLE_INSERT_MODE |
ENABLE_QUICK_EDIT_MODE);
   switch (m)
     {
     case tty::restore:
-      flags = ENABLE_ECHO_INPUT | ENABLE_LINE_INPUT |
ENABLE_PROCESSED_INPUT;
+      flags |= ENABLE_ECHO_INPUT | ENABLE_LINE_INPUT |
ENABLE_PROCESSED_INPUT;
       break;
     case tty::cygwin:
-      flags = ENABLE_WINDOW_INPUT;
+      flags |= ENABLE_WINDOW_INPUT;
       if (wincap.has_con_24bit_colors () && !con_is_legacy)
        flags |= ENABLE_VIRTUAL_TERMINAL_INPUT;
       else
--
2.35.1
