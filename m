Return-Path: <SRS0=9Csj=H7=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by sourceware.org (Postfix) with ESMTPS id A2CDB4BA543C
	for <cygwin-patches@cygwin.com>; Fri,  9 Oct 2026 12:13:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A2CDB4BA543C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A2CDB4BA543C
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::62f
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1791547981; cv=none;
	b=SFtzI7vJyDe2tZatrhdNOqdcS6ArXClsTrPztbWVgcJD5EDgsCRr1XcaJxwsJuYjIAnvqRfyw3nsjuGtNez30E99isV80xKtunHfTTjnchsjNbApySHqfC/XeNENYvpPz716SYjIjhPgkXv2lsY+1vgmbxnRNLkvNk7FDh7Z68A=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791547981; c=relaxed/simple;
	bh=QmoinoI3Od24qfb9w9og4aoZ9Ee6rnSbrho0Jzm4pIE=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=mfdmz+I0Ird3wSRKF5eU2ixGZAVBWwCmLqM0R6379xZ0tuAd+7YaB554cD+ha3md22TvWprejicP7ZTrgJN3tilf/RoouNCxYC9bq37C/fGfzVjtEy8h39KPoQk9DkZJe/s2C2tTq9Q+elNxCnOuB1G+3Lqk0ZRfZ8lJLc8t6M0=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=izHkNdKn
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A2CDB4BA543C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=izHkNdKn
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2d032846c95so33525935ad.1
        for <cygwin-patches@cygwin.com>; Fri, 09 Oct 2026 05:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791547980; x=1792152780; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S0ow/5lVx0XG/BTIOe2+q7W/+spRGdEOzUV4WlZTi0s=;
        b=izHkNdKnMk3B1BbDthQYtFqxkrA9yEczoucVBXlDLPGuQLJM1hRLiOcspwY81HA1vP
         dfbp91XrdRJBC9j4kgzqzhfuX1XNcFDAwk3QGdW2qaXC/Bf8VIXgz0m+PZ+Ikd7OIzj6
         1evUJxeEF+t0aLcHOV8MJxfMgIIphku9y+W+PfPnLMWnw6j89za3Mws/9tI+EkxX+Qfu
         ydwqbbo6o0fGONQofSAqoppLxBN4ePjqczEV8oFOuDa19JXlirJ9Yij0hy2iVzQNbb6X
         8fAOSHKUaw/GE6nnfFDFB+re60QQM4IceQ/YMJQ4uNpRi17+it5F889vv0fIo/J2A6MJ
         T9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791547980; x=1792152780;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S0ow/5lVx0XG/BTIOe2+q7W/+spRGdEOzUV4WlZTi0s=;
        b=g+kfCsnFxf1bpzER0cndFIRDW7IfznsutUxcIjuY6Na6f+XkreWt2yNHY0knIfJWh3
         ew5pe6JQJbrCZOUlhOuP3U3ZKWWqXtJDMizxwGXZapA7f8Ju00DMK2egowBiAfiVHviJ
         Q9BQch7pF8WxEmk1iQEP2hCDpMNuyK62EL0r2M5bAdMmIejMW7kjGMSpiaFqb+UXb6GA
         YmFHik1BqO3PQ3eIATj3+odYBE2mFHrnUoLMraAJASgf9RNqZckMzlMDqgNhA497VV2l
         8tREzB8uRNelkOIXEkyrvxyXFS2pQTdIuh6/5Rk+4YNQs9qKYQlt3OvWXnbjaehO0i4S
         /WUA==
X-Gm-Message-State: AFq9FYIMttyTg8xBrqaG3qDGWLunayOPF8LBOOGfqLYIZe4oIkIDJEeW
	3mAa9WFSal49nsGCiNvSbE5WHEVHAlnKaPfjoL/HlF7Oe2eU2CsG4sKUSNFm5w==
X-Gm-Gg: AYBFou09cYbKNvk9qRIuDpatRmT76QVLlVad1/iGd/2FJ/qzsUoa40YThQDfPx9vs3q
	hJP1JDkUTX8ghnpjg2pnm/bbRhWlmhCPTKwNUrhuwexzb841RJN/DJzTX4AUON77KDTh1A1QUiQ
	O6PUGw4OVCXgrWjab2lKdler+xKVAS6EGW4KLB1eVTeBfBYkh9+teDDIc+sy9+W4C9deEpNFA2P
	PGoI7KRVU2gnp79Sy12Ox1olj6EQsnwipG76JVcgugfSlRdPFFotHGhhqtyYbkwFyHU7pRJV/TB
	y+BvE/UjoIk9uVoqkxGFg5LCbLOv8hqC0BqIhg4uUCag88NmhecMZCm/sLm7skmyqlyN0mcYa78
	2sMWMOPdA6A/x2UXbXMT4G+Z1O8iFymmT2xEAoOT13l0fwONWAF63wy+p5DtAov0bvCPvik2Gg1
	e4CdH6FW8eNAjG39XawJmWN8J8lG0ndV4dvx5AcYm94yShPeOVeb13HQ23ZhVTrveUGHXCWrZvy
	+FdzHfeuQ==
X-Received: by 2002:a17:903:230b:b0:2dd:c100:a5e1 with SMTP id d9443c01a7336-2e842df9c64mr14858935ad.53.1791547980410;
        Fri, 09 Oct 2026 05:13:00 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.102.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422fb8b4sm7273485ad.82.2026.10.09.05.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 05:12:58 -0700 (PDT)
Message-Id: <9a4e55cd7642c4211a4e4dcfdb6a0ac14dc30e3a.1791547975.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.13.v2.cygwin.1791547975.gitgitgadget@gmail.com>
References: <pull.13.cygwin.1791537820.gitgitgadget@gmail.com>
	<pull.13.v2.cygwin.1791547975.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Oct 2026 12:12:54 +0000
Subject: [PATCH v2 1/2] Cygwin: console: Preserve saved modes with redirected
 stdio
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

With console stdin but captured stdout and stderr, a runtime child can
replace the shared saved output mode with zero. A later invocation
restores that value, rendering CR/LF as glyphs instead of line breaks.
Redirected stdin with console output exposes the corresponding
input-mode omission.

Console handlers restore both modes on close, even with redirected
stdio. Keep their backups valid regardless of whether opening the
handler needs to switch either mode.

Addresses: https://github.com/msys2/msys2-runtime/issues/379
Fixes: bbd3710fc834 ("Cygwin: console: Set console mode only if
  std{in,out,err} is console")
Assisted-by: GPT-6.1
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 winsup/cygwin/fhandler/console.cc | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 098b4e7eb..71a502c12 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -2201,15 +2201,16 @@ fhandler_console::open (int flags, mode_t)
     }
 
   WaitForSingleObject (cons_mode_mutex, mutex_timeout);
+  /* close() restores both modes even when stdio is redirected. */
+  prev_input_mode_backup = con.prev_input_mode;
+  prev_output_mode_backup = con.prev_output_mode;
   if (in_is_console && con.curr_input_mode != tty::cygwin)
     {
-      prev_input_mode_backup = con.prev_input_mode;
       GetConsoleMode (get_handle (), &con.prev_input_mode);
       set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
     }
   if (out_is_console && con.curr_output_mode != tty::cygwin)
     {
-      prev_output_mode_backup = con.prev_output_mode;
       GetConsoleMode (get_output_handle (), &con.prev_output_mode);
       set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
     }
-- 
cygwingitgadget

