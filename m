Return-Path: <david.macek.0@gmail.com>
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by sourceware.org (Postfix) with ESMTPS id B1FF238708FF
 for <cygwin-patches@cygwin.com>; Sat, 16 May 2020 12:43:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B1FF238708FF
Received: by mail-wr1-x444.google.com with SMTP id i15so6455653wrx.10
 for <cygwin-patches@cygwin.com>; Sat, 16 May 2020 05:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-transfer-encoding;
 bh=2EsBCurE/ktADRk3HCYiR4VGfeYq6fsjtm5mt1wvnbc=;
 b=sJ5IWURUVT83pCBwwVEzBiJc3Yo8xoMcFGKnsn7OEnI23yj8Hf25GDz014XSHhKXge
 r0Kv0TCwa3120deyXSu5JyDqtF1SiKb1bzrkodIsIZw0koyexiwA608Lx0aqWIImVUOn
 MQL2lIGs949H6/ewSF/4NXLBhiZipyh/EJmr0e19G51XegYkT6lzjdePSHlL+JjNguJD
 AgM2ZC3uxWv2MhiR73VXaAQPvvIJBwe31IatMX6/7khzKJUk4Bw6xyrbujXrJ/gXyxY3
 awd37YJDZTJuiUHcc5IT3mgrYWTtPJTnjOUC39FyAQtvvjt1xSX8yRaf6LddG1N5hN3B
 WPiQ==
X-Gm-Message-State: AOAM5307L04KxAEb9Paiux/K/+sNY8e6t/aGAloBDjIV7aGZIROqIgLV
 a75ZoD7BP882H2Sk5IFVN5pYbPi5
X-Google-Smtp-Source: ABdhPJysRHeFuH9WAogpDzHEAL/QD9uJs8z/28DMIsBdHab8pef0rCTexS/KBm0/ktKWgUf1XsFdFg==
X-Received: by 2002:adf:82c3:: with SMTP id 61mr10047874wrc.326.1589632988433; 
 Sat, 16 May 2020 05:43:08 -0700 (PDT)
Received: from localhost ([193.165.97.191])
 by smtp.gmail.com with ESMTPSA id q17sm8105541wmk.36.2020.05.16.05.43.07
 for <cygwin-patches@cygwin.com>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2020 05:43:07 -0700 (PDT)
Date: Sat, 16 May 2020 14:43:02 +0200
From: David Macek <david.macek.0@gmail.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] libc: Replace i386/sys/fenv.h symlink with an #include shim
Message-ID: <20200516144257.00003284@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, FREEMAIL_ENVFROM_END_DIGIT,
 FREEMAIL_FROM, GIT_PATCH_0, RCVD_IN_ABUSEAT, RCVD_IN_BARRACUDACENTRAL,
 RCVD_IN_DNSWL_NONE, RCVD_IN_SBL_CSS, SPF_HELO_NONE, SPF_PASS,
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
X-List-Received-Date: Sat, 16 May 2020 12:43:12 -0000

Same reasoning as fbaa0967.

Signed-off-by: David Macek <david.macek.0@gmail.com>
---

Excuse my ignorance, but is this acceptable?  I'm not sure
what actually happens with these files, but it'd be nice to
get rid of the last symlink in the repo.

 newlib/libc/machine/i386/sys/fenv.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
 mode change 120000 => 100644 newlib/libc/machine/i386/sys/fenv.h

diff --git a/newlib/libc/machine/i386/sys/fenv.h b/newlib/libc/machine/i386/sys/fenv.h
deleted file mode 120000
index 218057825e..0000000000
--- a/newlib/libc/machine/i386/sys/fenv.h
+++ /dev/null
@@ -1 +0,0 @@
-../../x86_64/sys/fenv.h
\ No newline at end of file
diff --git a/newlib/libc/machine/i386/sys/fenv.h b/newlib/libc/machine/i386/sys/fenv.h
new file mode 100644
index 0000000000..d2c41a6d5a
--- /dev/null
+++ b/newlib/libc/machine/i386/sys/fenv.h
@@ -0,0 +1,5 @@
+/*
+ * SPDX-License-Identifier: BSD-2-Clause
+ */
+
+#include "../../x86_64/sys/fenv.h"
-- 
2.26.2.windows.1

