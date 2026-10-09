Return-Path: <SRS0=9Csj=H7=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
	by sourceware.org (Postfix) with ESMTPS id 9E3544BA5436
	for <cygwin-patches@cygwin.com>; Fri,  9 Oct 2026 09:23:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9E3544BA5436
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9E3544BA5436
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::c2b
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1791537826; cv=none;
	b=S1uw1IeaMuZJvocaWMzqLMzxADtaMHkYqp25R0mEvJOqNujCxEKiygKWnaFQgfUX2icBNsKWqI5U3wrQoD/Yycd/yi+9sk+LxiKVmvwGCO8f75HUdL8c4ah9Oe0S+4PhrVi69sUAhj0HcchON8j349fb/HtaaKpIa65EQw5r6PI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791537826; c=relaxed/simple;
	bh=QmoinoI3Od24qfb9w9og4aoZ9Ee6rnSbrho0Jzm4pIE=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=rLQ99AbT+1Uql8wAQNhVyEFh4GkOarovTin9gYVErKJsHjTeefNhJjHCSF53Kf9AbkLsNZXLwhMERljYz8AuNseFhZw8C/oZ91fu8lBy6MWZn8T7Xsq/bqHQTWO/nD92ASyyiQp7K3eXdkz5rS+y9oXKM2kXt/XqRRm7Dr+2iE8=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dEbBkM7M
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9E3544BA5436
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dEbBkM7M
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-6dd7070699eso4467047eaf.3
        for <cygwin-patches@cygwin.com>; Fri, 09 Oct 2026 02:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791537826; x=1792142626; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S0ow/5lVx0XG/BTIOe2+q7W/+spRGdEOzUV4WlZTi0s=;
        b=dEbBkM7MdMHMjVxw8rLP5HlQxsWbVtmG5KFDHJCNv0V+5teP5SW4k6vtJ8xFfqiRI9
         VbPpM0319dIp6x7nZ09yg3wFNYgNm07cxqmxlcGRQ/CeiEv3rye8sE0ujoAnNGnS/DgQ
         QSGVGMd6rLdm2OcQsNogHNROvbPEVZmGu/8CJA5oVW0jQd2mvp6DZY74nvsBhEdHWEti
         z5+0meuaa9J6RMH+2nf468qvKbJLxFuk6vLHtM6/EXhtUGWlvYp1FvXC+BAB9K8Y91qv
         akF6J0Yi0qvxctY2fCy5pcuLFVZe0y2SyGmpBlOBCZHB+efdmntmjR4A7W1tISjPUNvz
         pAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791537826; x=1792142626;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S0ow/5lVx0XG/BTIOe2+q7W/+spRGdEOzUV4WlZTi0s=;
        b=2EFxiIUqfsexEPUEHapBQAyjebsMvaTdlZ25xabThv8yWF6VhjGvXtExLVndOyZJuY
         UNAsbQGoVPn6z1HLpetFo81R0sGzcJM9OMEeVkfccPseKoaeZwbcwfqbVR+LGJKYtdS0
         +MX7jkSIqjc1xeIvEY9pKFqsFLzj0DZZrUv1BZVif/QL7NvtSbHaVL9tH3cH7eXk9uHU
         ZzRhV+DengqdgfovWsk2Ad/h9Tc9qtW2nWqWWtsVQWEaStnMisv7ck+iPUsfaYK78G9H
         rbZ4Q/FhhFmWufD0UMsN2owLHJJefOYxlRfuHNx5K2Vp9sbljts3+mUZcItbQFfHoouj
         1gmg==
X-Gm-Message-State: AFuF++k+t3G9DORLThWVnSvzwi53FfVslUQnnwLsjRSDOd7YFpFsjHmi
	HIfMctHyUVB6KkgJNFX/dMJC4jTGLdh+k/JbdMtiR+OTI13pEVe/nUtdZR/LT8QO
X-Gm-Gg: AYBFou2/5Bvilv4ULBvC3WKxu08MjVv+bClpwpv9GPeF2uBvHC1xVd25PsmKomxf2sC
	V5J+0DA3OcsqY9hs9KF/QIWawC25mhGalN/yAz7ryjxLoKTeMdQoVGcdt4rIC9/KyQteyy5Vg52
	MMTcskK7Li8tvoJNkCdM/IM3ncgTgOHaiLPflrAymGxLZbo7ev8Ql7szR94x87XfvhFapRl+3Tc
	IUGovckJ8VpHNRpBfhQ3kykvuj1G1/JKEpSzROKWvN1fZi5KiVe2Vb7DG+jZcdm5ez8RGpwTniO
	CAPvkVdElWrHEUOqFahrEU2tZ6SZlkcbZrVG4ZqWrDizvMW7aOj2vf4uBMobCopo554nti6iRvb
	Dqhlr8+6Yxt38cXThGYbFw9TO9E6PXO6dS8UCOSBhSqeuQDT+L8cr7Zs5T1rm9fgPCYwVEKiVc2
	nbHEH3RdbUinRdJQtZOiyFU23iXdd9mNxPrPRwpwGOPH4lbcQl2Ci2rG59wP9M2YYNYFYqhnrIT
	g==
X-Received: by 2002:a05:6820:1c91:b0:6ae:5250:dd1c with SMTP id 006d021491bc7-6ef0eec221amr1029880eaf.29.1791537825547;
        Fri, 09 Oct 2026 02:23:45 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.31.81])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ef0052070bsm1283394eaf.3.2026.10.09.02.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 02:23:44 -0700 (PDT)
Message-Id: <9a4e55cd7642c4211a4e4dcfdb6a0ac14dc30e3a.1791537820.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.13.cygwin.1791537820.gitgitgadget@gmail.com>
References: <pull.13.cygwin.1791537820.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Oct 2026 09:23:39 +0000
Subject: [PATCH 1/2] Cygwin: console: Preserve saved modes with redirected
 stdio
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
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

