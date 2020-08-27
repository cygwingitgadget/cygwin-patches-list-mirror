Return-Path: <corngood@gmail.com>
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by sourceware.org (Postfix) with ESMTPS id 74C1B3986830
 for <cygwin-patches@cygwin.com>; Fri,  4 Sep 2020 12:44:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 74C1B3986830
Received: by mail-qt1-x842.google.com with SMTP id p65so4475993qtd.2
 for <cygwin-patches@cygwin.com>; Fri, 04 Sep 2020 05:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version;
 bh=L7ZXonoWKoaw4VM5ZERbA1ebAlfEGgupiJgUGdH0Bt4=;
 b=klTnmhXEc1wyFmHRxKcNKdk2oAWetncSRvkDeG/910pX0jcoR4zzNNK8c3Z0rdo9g4
 Bq58rePhrvLlWllR1Z3syw/0AbyuFHUd/Q6tr48j8amNZkJRnbMd3t3RINY86//Iba57
 c6tJBi4nbDTUoB163Z8tDyUxCHEM99xW13mHSm+mJb07Wc9Nhq9tYAJ/FhR1HEC4lmp9
 Qn5XatqzlpwuVBqi/3geB/OJ2mBWLiL7k5PZA0LOfv8pXXgbKmpfzPGT/q8O2aORod2E
 puWjmyqCw36TFSn52Lxv8Xip1SMUEnbHsUml6709InD85BI6GZxYHUYhSZuBZ7vt20vK
 JizA==
X-Gm-Message-State: AOAM532RyWTEuBJhtU0Z59xYPKtxdcpBr41j7O0H66NRsePBAWcn1A/0
 V2mhBiqUP2dms8HaS3FS5f7g7H/YIA8=
X-Google-Smtp-Source: ABdhPJwJujrQZl7zJFI8VYp5duvlerLJIwz7jH3lsLcIYK/cl6lu21Qu3OA45sKInZbNU/4kKE6qog==
X-Received: by 2002:ac8:100c:: with SMTP id z12mr8221903qti.81.1599223452867; 
 Fri, 04 Sep 2020 05:44:12 -0700 (PDT)
Received: from davidm-laptop (host-24-138-77-139.public.eastlink.ca.
 [24.138.77.139])
 by smtp.gmail.com with ESMTPSA id e9sm4402378qkb.8.2020.09.04.05.44.12
 for <cygwin-patches@cygwin.com>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 05:44:12 -0700 (PDT)
From: David McFarland <corngood@gmail.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: create install dir for libs
Date: Thu, 27 Aug 2020 09:02:46 -0300
Message-ID: <vrit8sdpaezo.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00, DATE_IN_PAST_96_XX,
 DKIM_SIGNED, DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, FREEMAIL_FROM,
 GIT_PATCH_0, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Fri, 04 Sep 2020 12:44:14 -0000

This fixes a race in parallel installs.
---
 winsup/cygwin/Makefile.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
index fac81759e..ea0243033 100644
--- a/winsup/cygwin/Makefile.in
+++ b/winsup/cygwin/Makefile.in
@@ -600,7 +600,7 @@ install: install-libs install-headers install-man install-ldif install_target \
 uninstall: uninstall-libs uninstall-headers uninstall-man
 
 install-libs: $(TARGET_LIBS)
-	@$(MKDIRP) $(DESTDIR)$(bindir)
+	@$(MKDIRP) $(DESTDIR)$(bindir) $(DESTDIR)$(tooldir)/lib
 	$(INSTALL_PROGRAM) $(TEST_DLL_NAME) $(DESTDIR)$(bindir)/$(DLL_NAME); \
 	for i in $^; do \
 	    $(INSTALL_DATA) $$i $(DESTDIR)$(tooldir)/lib/`basename $$i` ; \
-- 
2.28.0

