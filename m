Return-Path: <david.macek.0@gmail.com>
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by sourceware.org (Postfix) with ESMTPS id EA5BB385B835
 for <cygwin-patches@cygwin.com>; Thu, 16 Apr 2020 21:09:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org EA5BB385B835
Received: by mail-wm1-x342.google.com with SMTP id r26so387788wmh.0
 for <cygwin-patches@cygwin.com>; Thu, 16 Apr 2020 14:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-transfer-encoding;
 bh=NMmHUGhztbSqcierimHP+bDeCjVsQhAa1nEinGPqPGI=;
 b=dIFiBYbOQFmJtiknUmZRleMxlEcscW5LcNcCyELLMlu9dMFB9RPUbFIY73prlieWZt
 afg7wqHfcH4TnasXHknS2pZSB7UfRqRL9HqAZjUSdfrb5kVcPRkogwvrXJb15L5YI/wR
 ShjYSvsEmgtp99hOqegtYmhU2phgSGXJzvsXfIZLfPke2UdP6TeQN0fEbMDnwwCynupZ
 MTCCeZdtf3jFfHreMfg+pCFUCzSgeA9DUt6gtnufEugNBegOslRlV3ER/7en7V233GVK
 4PKM9Ct70tOT9HxAvuyzLJ+/gJzodEyisEH6HuCVMC76nXSlCuw7mMftU6MCTRCZ5JgF
 u9wA==
X-Gm-Message-State: AGi0PuYS1MM6O8a1sId6ym9XTFDEqkoK3ZGpwlzdx98J8xUJ06xoYA2p
 ejnpQP/mh9WhqopfUXI3ErgyOzNUhR0=
X-Google-Smtp-Source: APiQypLYrIfBndcqYeT8WUGSmzewMrfKNiHsyz3RfOZbv9GQhqgQvLX4rWo9n3+rJjRZEGXe1MtHAg==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr6393941wmi.64.1587071356656;
 Thu, 16 Apr 2020 14:09:16 -0700 (PDT)
Received: from localhost ([193.165.97.202])
 by smtp.gmail.com with ESMTPSA id g74sm5213808wme.44.2020.04.16.14.09.15
 for <cygwin-patches@cygwin.com>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 16 Apr 2020 14:09:16 -0700 (PDT)
Date: Thu, 16 Apr 2020 23:09:07 +0200
From: David Macek <david.macek.0@gmail.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] cygheap_pwdgrp: Handle invalid db_* entries correctly
Message-ID: <20200416225237.00004a1a@gmail.com>
X-Mailer: Claws Mail 3.15.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-22.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, FREEMAIL_ENVFROM_END_DIGIT,
 FREEMAIL_FROM, GIT_PATCH_0, GIT_PATCH_1, GIT_PATCH_2, GIT_PATCH_3,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 16 Apr 2020 21:09:20 -0000

If the first scheme in db_* was invalid, the code would think there
were no schemes specified and replace the second scheme with
NSS_SCHEME_DESC.

Signed-off-by: David Macek <david.macek.0@gmail.com>
---
 winsup/cygwin/uinfo.cc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
index bfcce00da0..be3c4855cc 100644
--- a/winsup/cygwin/uinfo.cc
+++ b/winsup/cygwin/uinfo.cc
@@ -823,7 +823,10 @@ cygheap_pwdgrp::nss_init_line (const char *line)
 					  c, e - c);
 		    }
 		  else
-		    debug_printf ("Invalid nsswitch.conf content: %s", line);
+		    {
+		      debug_printf ("Invalid nsswitch.conf content: %s", line);
+		      --idx;
+		    }
 		  c += strcspn (c, " \t");
 		  c += strspn (c, " \t");
 		  ++idx;
-- 
2.26.1.windows.1

