Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-041.btinternet.com (mailomta17-re.btinternet.com
 [213.120.69.110])
 by sourceware.org (Postfix) with ESMTPS id 8F2893858D1E
 for <cygwin-patches@cygwin.com>; Sat, 19 Feb 2022 18:19:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 8F2893858D1E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
 by re-prd-fep-041.btinternet.com with ESMTP id
 <20220219181947.BTN24157.re-prd-fep-041.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
 Sat, 19 Feb 2022 18:19:47 +0000
Authentication-Results: btinternet.com;
 auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com;
 bimi=skipped
X-SNCR-Rigid: 613A8DE81545EEE7
X-Originating-IP: [86.139.167.74]
X-OWM-Source-IP: 86.139.167.74 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrkedvgdduudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeuieejgeduvdeutdffieeileefffdufeekhefgjefffeehtdekjeegkeeftdfffeenucfkphepkeeirddufeelrdduieejrdejgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeelrdduieejrdejgedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhk
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.167.74) by
 re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as
 jonturney@btinternet.com)
 id 613A8DE81545EEE7; Sat, 19 Feb 2022 18:19:47 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: Adjust path to newlib libm.a in builddir
Date: Sat, 19 Feb 2022 18:18:51 +0000
Message-Id: <20220219181851.57211-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1200.2 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE,
 SPF_HELO_PASS, SPF_NONE, TXREP,
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
X-List-Received-Date: Sat, 19 Feb 2022 18:19:50 -0000

Adjust path to newlib libm.a in builddir, changed by ac9f8c46
---
 winsup/cygwin/Makefile.am | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/Makefile.am b/winsup/cygwin/Makefile.am
index ad38fb220..1c4f00c24 100644
--- a/winsup/cygwin/Makefile.am
+++ b/winsup/cygwin/Makefile.am
@@ -626,7 +626,7 @@ $(LDSCRIPT): $(LDSCRIPT).in
 
 # cygwin dll
 $(PRE_DLL_NAME): $(LDSCRIPT) libdll.a $(VERSION_OFILES) $(LIBSERVER)\
-		  $(newlib_build)/libm/libm.a $(newlib_build)/libc/libc.a
+		  $(newlib_build)/libm.a $(newlib_build)/libc/libc.a
 	$(AM_V_CXXLD)$(CXX) $(CXXFLAGS) \
 	-mno-use-libstdc-wrappers \
 	-Wl,--gc-sections -nostdlib -Wl,-T$(LDSCRIPT) -static \
@@ -635,7 +635,7 @@ $(PRE_DLL_NAME): $(LDSCRIPT) libdll.a $(VERSION_OFILES) $(LIBSERVER)\
 	-Wl,-whole-archive libdll.a -Wl,-no-whole-archive \
 	$(VERSION_OFILES) \
 	$(LIBSERVER) \
-	$(newlib_build)/libm/libm.a \
+	$(newlib_build)/libm.a \
 	$(newlib_build)/libc/libc.a \
 	-lgcc -lkernel32 -lntdll -Wl,-Map,cygwin.map
 
@@ -696,7 +696,7 @@ speclib=\
 libc.a: $(LIB_NAME) libm.a libpthread.a libutil.a
 	$(AM_V_GEN)$(speclib) $^ -v $(@F)
 
-libm.a: $(LIB_NAME) $(newlib_build)/libm/libm.a $(addsuffix .o,$(basename $(MATH_FILES)))
+libm.a: $(LIB_NAME) $(newlib_build)/libm.a $(addsuffix .o,$(basename $(MATH_FILES)))
 	$(AM_V_GEN)$(speclib) $^ $(@F)
 
 libpthread.a: $(LIB_NAME) pthread.o thread.o libc/call_once.o libc/cnd.o \
-- 
2.35.1

