Return-Path: <SRS0=koVj=IF=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
	by sourceware.org (Postfix) with ESMTPS id AA9904BA23D8
	for <cygwin-patches@cygwin.com>; Thu, 15 Oct 2026 07:45:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AA9904BA23D8
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AA9904BA23D8
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::333
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792050313; cv=none;
	b=mIHTNbzeMzdQTDwhQAQdu+07QzfPw6YdyVbAtg02x3vRKVG5fKl8JFMZJoiLnPG6QJ1BcyruiUX0AOt4W6yEpzmTZ1H0th53j7nhCtSkyGuhnsetjH7N9I6jM0BzMrrfMhdaC9VE0HIzsEXExSjtpIT5R6X9jIUxnYLiZHmUmYA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792050313; c=relaxed/simple;
	bh=sAPIZ0WR+g2vohiMHbdKlzYse760elFJAXwfi2/JKHo=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=Bc1sPE1NYrqhDLBH7ex8tTUKwePlLIbdBY0+NxTzpsQ1XlDCVYhIQWsrenuN0Hiz9RH3Fy6gO09YbrCbWNnjyCMifMsQ3JXk62gHMaVJxnsPTLDRhuhiEMKaBxbpHlPmcpvmnmXJSXj1BLMhkLMiTljDU5djU0r064XkoA77KSw=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T46nyt4f
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AA9904BA23D8
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T46nyt4f
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-823b938464fso1199262a34.2
        for <cygwin-patches@cygwin.com>; Thu, 15 Oct 2026 00:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792050313; x=1792655113; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aPDUDWuehZEIxc6ZBl89CRB10qP5nQyfDTAOwtKJ+6A=;
        b=T46nyt4fbZUhQ5vAzc788T+ZfRrWhbowLsRb6U1v37mnRsTE4g2sq2zdro0pa0GBHj
         VPq37Tp0v6N9edwjpnDBBbXgoOIHT3JRkj6BQx3o4WuK2YivVqVSb/Mq6WksBiPK3X11
         eOtn2DZH1nwpAa50lTDfVJ0S7v6a/ZYl3EOwXJkRezXWujrPxG5WEn51llIwyfVeQZAB
         jQfpUeztOCYuLeNxJ1ZKJdkTb3Ys0UEQBU7RpgqEJr0zstesJj2h50NQqX//xlcUlxax
         RLrl+KPRnr92uFrTtbWK0+QEjWvlpP6xfDkJ1olp+ch9QAE+IZd6rPfHgBkbVRP6GE0m
         utfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792050313; x=1792655113;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aPDUDWuehZEIxc6ZBl89CRB10qP5nQyfDTAOwtKJ+6A=;
        b=ZpU03zvKA155vujjmsO085K27945TGpyiae6XoJZCeCut95Sbvvwtg1hx0DemMFlhA
         FVC+GbciN/pRjxVH8LvMzsp474PJILyituD7MO+mVx1jizxx+qUq4rH9BUDFAetTDYNu
         exSMN80vMaWlHmBdyw8la2P7kYJs8gWXV0nrlK+ULgq6gWtmuty7q8P14N+UavurNrGw
         iwpgy43JsnDPobdTjqlgMii4eXbcc7hRd3xJhs8+/7beh1hEGymcw69D7TxwsxuT9cIk
         ihmMitYgdDeb9wFSZgK4ezzSMjkvLLu7AxqYdUPSfZstnu57FSSaRPn2tYBMqgyayanE
         yXnQ==
X-Gm-Message-State: AFq9FYL+mIcBWNwLBk541LbHd61PUyi9R5bUyvFHkweywndhOEianhpJ
	2aEoC9Rr2uLGvcM8bPahJZuHwHmQSnmXF8iliP6k5kYeKLHDncRa1XapXZ6j7ymZlIU=
X-Gm-Gg: AYBFou2dxEFEEB9LSs78jJrtng/lt50AhIVtg4aS5q5TYdBNeepPIZeX3g50mgmnER1
	5NST77oeeP/LmAYyM3xT9fnr8gkg1sKErVqPh1wwUoV++LAiqmdw9GW8nC2M3xAChqWrewtJGDD
	3gCZJO1ZovxpAlOz94kmHyiSfGIQv7mOrdQbI3d6DaYqsaQPqspKDxOo00wHkEqRdfw8Oy7vfms
	p5kTMFWJWfyO3wGjEH5JWGVl/VXohnScVKMk4AXVBXGoWCIxlI/q8bADafUcUSYf48CirTwjXZI
	ULHcUXzSTXoGeWUDHC4nBM6gjgYOgsXp/SdrVaHr4tO6ZnGu4/X4ETNjJpzVpRxQyD5Qdus2rs9
	zzQuxBZUaSrnVUF7E4XLZFE2cdZzXz32vkYUkVrM4VlnfgK4mYe9MT5+WOEFUIdVSu3SOy4JV5n
	edC7J2JkQ7+LuW7yGkEry3YiV6HBltV0NAH0c4tS99rlvpi4jPmk0BHm3gU/wMV1wEbWwL8W/yJ
	lY=
X-Received: by 2002:a05:6830:2a92:b0:822:ce5a:4ab with SMTP id 46e09a7af769-83098347255mr17001595a34.26.1792050312864;
        Thu, 15 Oct 2026 00:45:12 -0700 (PDT)
Received: from [127.0.0.1] ([52.176.123.176])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303494f64csm16476399a34.3.2026.10.15.00.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 00:45:11 -0700 (PDT)
Message-Id: <f1a25a8e50b16a72a4b2080ed27f0f03f48acfbf.1792050298.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.10.v2.cygwin.1792050298.gitgitgadget@gmail.com>
References: <pull.10.cygwin.1789302605264.gitgitgadget@gmail.com>
	<pull.10.v2.cygwin.1792050298.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 Oct 2026 07:44:57 +0000
Subject: [PATCH v2 4/5] Cygwin: pty: recover input for children of native
 programs
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

A native Windows program can start a Cygwin child while PTY input is
still routed to the native console. The `exec()` handover does not
cover this case, yet a `vim.exe` started this way can enter raw mode
and query the terminal before its first read.

Therefore, let's recover input during the child's initialization too,
once the reopened stdin handle has been published. At that moment,
the handover can recognize it as standard input. Doing this in `init()`
is too early. If `stdin` and `stdout` share a PTY, initializing `stdout`
later can perform the handover `stdin` missed.

Addresses: https://github.com/git-for-windows/git/issues/6403
Suggested-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Assisted-by: GPT-6.1
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 winsup/cygwin/fhandler/pty.cc           | 7 +++++++
 winsup/cygwin/local_includes/fhandler.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 19e12c274..763babbe8 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -1078,6 +1078,13 @@ fhandler_pty_slave::init (HANDLE h, DWORD a, mode_t, int64_t dummy)
   return ret;
 }
 
+void
+fhandler_pty_slave::post_open_setup (int fd)
+{
+  if (fd == 0)
+    fixup_input_state_for_cygwin_app ();
+}
+
 void
 fhandler_pty_slave::set_switch_to_nat_pipe (void)
 {
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index b69a358f6..b7341f277 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2473,6 +2473,7 @@ class fhandler_pty_slave: public fhandler_pty_common
 
   int open (int flags, mode_t mode = 0);
   bool open_setup (int flags);
+  void post_open_setup (int fd);
   ssize_t write (const void *ptr, size_t len);
   void read (void *ptr, size_t& len);
   int init (HANDLE, DWORD, mode_t, int64_t = 0);
-- 
cygwingitgadget

