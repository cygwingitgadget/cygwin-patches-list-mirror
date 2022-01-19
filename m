Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-043.btinternet.com (mailomta22-sa.btinternet.com
 [213.120.69.28])
 by sourceware.org (Postfix) with ESMTPS id B61983858401
 for <cygwin-patches@cygwin.com>; Wed, 19 Jan 2022 13:15:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org B61983858401
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
 by sa-prd-fep-043.btinternet.com with ESMTP id
 <20220119131554.GZWQ18908.sa-prd-fep-043.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
 Wed, 19 Jan 2022 13:15:54 +0000
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 613006A912DF444E
X-Originating-IP: [81.129.146.209]
X-OWM-Source-IP: 81.129.146.209 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrudehgdegkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepjedvvdduveeigeevhfeufeehvdejhfehleeggfeugeeiffeigefhuefffedtfeefnecuffhomhgrihhnpehprghttghhvggurdgtrghmnecukfhppeekuddruddvledrudegiedrvddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurdduvdelrddugeeirddvtdelpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.129.146.209) by
 sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as
 jonturney@btinternet.com)
 id 613006A912DF444E; Wed, 19 Jan 2022 13:15:54 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/4] Cygwin: silence most custom build rules
Date: Wed, 19 Jan 2022 13:15:18 +0000
Message-Id: <20220119131521.51616-2-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220119131521.51616-1-jon.turney@dronecode.org.uk>
References: <20220119131521.51616-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1198.2 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Wed, 19 Jan 2022 13:15:58 -0000

---
 winsup/cygwin/Makefile.am | 38 +++++++++++++++++++-------------------
 winsup/doc/Makefile.am    | 38 +++++++++++++++++++-------------------
 2 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/winsup/cygwin/Makefile.am b/winsup/cygwin/Makefile.am
index 2b8e87fcd..8d55e1693 100644
--- a/winsup/cygwin/Makefile.am
+++ b/winsup/cygwin/Makefile.am
@@ -367,16 +367,16 @@ libdll_a_SOURCES= \
 #
 
 shared_info_magic.h: cygmagic shared_info.h
-	$(srcdir)/cygmagic $@ "$(CC) $(INCLUDES) $(CPPFLAGS) -E -x c++" $(word 2,$^) SHARED_MAGIC 'class shared_info' USER_MAGIC 'class user_info'
+	$(AM_V_GEN)$(srcdir)/cygmagic $@ "$(CC) $(INCLUDES) $(CPPFLAGS) -E -x c++" $(word 2,$^) SHARED_MAGIC 'class shared_info' USER_MAGIC 'class user_info'
 
 child_info_magic.h: cygmagic child_info.h
-	$(srcdir)/cygmagic $@ "$(CC) $(INCLUDES) $(CPPFLAGS) -E -x c++" $(word 2,$^) CHILD_INFO_MAGIC 'class child_info'
+	$(AM_V_GEN)$(srcdir)/cygmagic $@ "$(CC) $(INCLUDES) $(CPPFLAGS) -E -x c++" $(word 2,$^) CHILD_INFO_MAGIC 'class child_info'
 
 globals.h: mkglobals_h globals.cc
-	$^ > $@
+	$(AM_V_GEN)$^ > $@
 
 localtime.patched.c: tzcode/localtime.c tzcode/localtime.c.patch
-	patch -u -o localtime.patched.c \
+	$(AM_V_GEN)patch -u -o localtime.patched.c \
 		    $(srcdir)/tzcode/localtime.c \
 		    $(srcdir)/tzcode/localtime.c.patch
 
@@ -620,12 +620,12 @@ $(LIBSERVER):
 # linker script
 LDSCRIPT=cygwin.sc
 $(LDSCRIPT): $(LDSCRIPT).in
-	$(CC) -E - -P < $^ -o $@
+	$(AM_V_GEN)$(CC) -E - -P < $^ -o $@
 
 # cygwin dll
 $(TEST_DLL_NAME): $(LDSCRIPT) dllfixdbg libdll.a $(VERSION_OFILES) $(LIBSERVER)\
 		  $(newlib_build)/libm/libm.a $(newlib_build)/libc/libc.a
-	$(CXX) $(CXXFLAGS) \
+	$(AM_V_CXXLD)$(CXX) $(CXXFLAGS) \
 	-mno-use-libstdc-wrappers \
 	-Wl,--gc-sections -nostdlib -Wl,-T$(LDSCRIPT) -static \
 	-Wl,--heap=0 -Wl,--out-implib,cygdll.a -shared -o $@ \
@@ -636,14 +636,14 @@ $(TEST_DLL_NAME): $(LDSCRIPT) dllfixdbg libdll.a $(VERSION_OFILES) $(LIBSERVER)\
 	$(newlib_build)/libm/libm.a \
 	$(newlib_build)/libc/libc.a \
 	-lgcc -lkernel32 -lntdll -Wl,-Map,cygwin.map
-	$(srcdir)/dllfixdbg $(OBJDUMP) $(OBJCOPY) $@ cygwin1.dbg
+	@$(srcdir)/dllfixdbg $(OBJDUMP) $(OBJCOPY) $@ cygwin1.dbg
 	@ln -f $@ new-cygwin1.dll
 
 # cygwin import library
 toolopts=--cpu=@target_cpu@ --ar=@AR@ --as=@AS@ --nm=@NM@ --objcopy=@OBJCOPY@
 
 $(DEF_FILE): gendef $(srcdir)/$(TLSOFFSETS_H) $(DIN_FILE) common.din
-	$(srcdir)/gendef --cpu=@target_cpu@ --output-def=$(DEF_FILE) --tlsoffsets=$(srcdir)/$(TLSOFFSETS_H) $(srcdir)/$(DIN_FILE) $(srcdir)/common.din
+	$(AM_V_GEN)$(srcdir)/gendef --cpu=@target_cpu@ --output-def=$(DEF_FILE) --tlsoffsets=$(srcdir)/$(TLSOFFSETS_H) $(srcdir)/$(DIN_FILE) $(srcdir)/common.din
 
 sigfe.s: $(DEF_FILE)
 	@[ -s $@ ] || \
@@ -652,11 +652,11 @@ sigfe.s: $(DEF_FILE)
 
 LIBCOS=$(addsuffix .o,$(basename $(LIB_FILES)))
 $(LIB_NAME): $(DEF_FILE) $(LIBCOS) | $(TEST_DLL_NAME)
-	$(srcdir)/mkimport $(toolopts) $(NEW_FUNCTIONS) $@ cygdll.a $(wordlist 2,99,$^)
+	$(AM_V_GEN)$(srcdir)/mkimport $(toolopts) $(NEW_FUNCTIONS) $@ cygdll.a $(wordlist 2,99,$^)
 
 # cygwin import library used by testsuite
 $(TEST_LIB_NAME): $(LIB_NAME)
-	perl -p -e 'BEGIN{binmode(STDIN); binmode(STDOUT);}; s/cygwin1/cygwin0/g' < $? > $@
+	$(AM_V_GEN)perl -p -e 'BEGIN{binmode(STDIN); binmode(STDOUT);}; s/cygwin1/cygwin0/g' < $? > $@
 
 # sublibs
 # import libraries for some subset of symbols indicated by given objects
@@ -669,32 +669,32 @@ speclib=\
 	--exclude='^_main$$'
 
 libc.a: $(LIB_NAME) libm.a libpthread.a libutil.a
-	$(speclib) $^ -v $(@F)
+	$(AM_V_GEN)$(speclib) $^ -v $(@F)
 
 libm.a: $(LIB_NAME) $(newlib_build)/libm/libm.a $(addsuffix .o,$(basename $(MATH_FILES)))
-	$(speclib) $^ $(@F)
+	$(AM_V_GEN)$(speclib) $^ $(@F)
 
 libpthread.a: $(LIB_NAME) pthread.o thread.o libc/call_once.o libc/cnd.o \
 	      libc/mtx.o libc/thrd.o libc/tss.o
-	$(speclib) $^ $(@F)
+	$(AM_V_GEN)$(speclib) $^ $(@F)
 
 libutil.a: $(LIB_NAME) libc/bsdlib.o
-	$(speclib) $^ $(@F)
+	$(AM_V_GEN)$(speclib) $^ $(@F)
 
 libdl.a: $(LIB_NAME) dlfcn.o
-	$(speclib) $^ $(@F)
+	$(AM_V_GEN)$(speclib) $^ $(@F)
 
 libresolv.a: $(LIB_NAME) libc/minires.o
-	$(speclib) $^ $(@F)
+	$(AM_V_GEN)$(speclib) $^ $(@F)
 
 librt.a: $(LIB_NAME) posix_ipc.o
-	$(speclib) $^ $(@F)
+	$(AM_V_GEN)$(speclib) $^ $(@F)
 
 libacl.a: $(LIB_NAME) sec_posixacl.o
-	$(speclib) $^ $(@F)
+	$(AM_V_GEN)$(speclib) $^ $(@F)
 
 libssp.a: $(LIB_NAME) $(newlib_build)/libc/ssp/lib.a
-	$(speclib) $^ $(@F)
+	$(AM_V_GEN)$(speclib) $^ $(@F)
 
 #
 # all
diff --git a/winsup/doc/Makefile.am b/winsup/doc/Makefile.am
index 5164c6e0a..44b64babc 100644
--- a/winsup/doc/Makefile.am
+++ b/winsup/doc/Makefile.am
@@ -107,56 +107,56 @@ uninstall-hook: uninstall-extra-man uninstall-html uninstall-info uninstall-etc
 
 # nochunks ug html is not installed, but will be deployed to website
 cygwin-ug-net/cygwin-ug-net-nochunks.html.gz: $(cygwin-ug-net_SOURCES) html.xsl
-	$(XMLTO) html-nochunks -m $(srcdir)/html.xsl $<
+	$(AM_V_GEN)$(XMLTO) html-nochunks -m $(srcdir)/html.xsl $<
 	@$(MKDIR_P) cygwin-ug-net
-	cp cygwin-ug-net.html cygwin-ug-net/cygwin-ug-net-nochunks.html
-	rm -f cygwin-ug-net/cygwin-ug-net-nochunks.html.gz
-	gzip cygwin-ug-net/cygwin-ug-net-nochunks.html
+	@cp cygwin-ug-net.html cygwin-ug-net/cygwin-ug-net-nochunks.html
+	@rm -f cygwin-ug-net/cygwin-ug-net-nochunks.html.gz
+	$(AM_V_at)gzip cygwin-ug-net/cygwin-ug-net-nochunks.html
 
 cygwin-ug-net/cygwin-ug-net.html: $(cygwin-ug-net_SOURCES) html.xsl
-	$(XMLTO) html -o cygwin-ug-net/ -m $(srcdir)/html.xsl $<
+	$(AM_V_GEN)$(XMLTO) html -o cygwin-ug-net/ -m $(srcdir)/html.xsl $<
 
 cygwin-ug-net/cygwin-ug-net.pdf: $(cygwin-ug-net_SOURCES) fo.xsl
-	$(XMLTO) pdf -o cygwin-ug-net/ -m $(srcdir)/fo.xsl $<
+	$(AM_V_GEN)$(XMLTO) pdf -o cygwin-ug-net/ -m $(srcdir)/fo.xsl $<
 
 utils2man.stamp: $(cygwin-ug-net_SOURCES) man.xsl
-	$(XMLTO) man -m $(srcdir)/man.xsl $<
+	$(AM_V_GEN)$(XMLTO) man -m $(srcdir)/man.xsl $<
 	@touch $@
 
 cygwin-ug-net.info: $(cygwin-ug-net_SOURCES) charmap
-	$(DOCBOOK2XTEXI) $(srcdir)/cygwin-ug-net.xml --string-param output-file=cygwin-ug-net
+	$(AM_V_GEN)$(DOCBOOK2XTEXI) $(srcdir)/cygwin-ug-net.xml --string-param output-file=cygwin-ug-net
 
 cygwin-api/cygwin-api.html: $(cygwin-api_SOURCES) html.xsl
-	$(XMLTO) html -o cygwin-api/ -m $(srcdir)/html.xsl $<
+	$(AM_V_GEN)$(XMLTO) html -o cygwin-api/ -m $(srcdir)/html.xsl $<
 
 cygwin-api/cygwin-api.pdf: $(cygwin-api_SOURCES) fo.xsl
-	$(XMLTO) pdf -o cygwin-api/ -m $(srcdir)/fo.xsl $<
+	$(AM_V_GEN)$(XMLTO) pdf -o cygwin-api/ -m $(srcdir)/fo.xsl $<
 
 api2man.stamp: $(cygwin-api_SOURCES) man.xsl
-	$(XMLTO) man -m $(srcdir)/man.xsl $<
+	$(AM_V_GEN)$(XMLTO) man -m $(srcdir)/man.xsl $<
 	@touch $@
 
 cygwin-api.info: $(cygwin-api_SOURCES) charmap
-	$(DOCBOOK2XTEXI) $(srcdir)/cygwin-api.xml --string-param output-file=cygwin-api
+	$(AM_V_GEN)$(DOCBOOK2XTEXI) $(srcdir)/cygwin-api.xml --string-param output-file=cygwin-api
 
 # this generates a custom charmap for docbook2x-texi which has a mapping for &reg;
 charmap:
-	cp /usr/share/docbook2X/charmaps/texi.charmap charmap
-	echo "ae (R)" >>charmap
+	$(AM_V_GEN)cp /usr/share/docbook2X/charmaps/texi.charmap charmap
+	$(AM_V_at)echo "ae (R)" >>charmap
 
 intro2man.stamp: intro.xml man.xsl
-	$(XMLTO) man -m $(srcdir)/man.xsl $<
+	$(AM_V_GEN)$(XMLTO) man -m $(srcdir)/man.xsl $<
 	@echo ".so intro.1" >cygwin.1
 	@touch $@
 
 faq/faq.html: $(faq_SOURCES) html.xsl
-	$(XMLTO) html -o faq -m $(srcdir)/html.xsl $(srcdir)/faq.xml
-	sed -i 's;<a name="id[mp][0-9]*"></a>;;g' faq/faq.html
+	$(AM_V_GEN)$(XMLTO) html -o faq -m $(srcdir)/html.xsl $(srcdir)/faq.xml
+	@sed -i 's;<a name="id[mp][0-9]*"></a>;;g' faq/faq.html
 
 # faq body is not installed, but is intended to be deployed to website, where it
 # can be SSI included in a framing page
 faq/faq.body: faq/faq.html
-	$(srcdir)/bodysnatcher.pl $<
+	$(AM_V_GEN)$(srcdir)/bodysnatcher.pl $<
 
 Makefile.dep: cygwin-ug-net.xml cygwin-api.xml faq.xml intro.xml
-	cd $(srcdir) && ./xidepend $^ > "$(CURDIR)/$@"
+	$(AM_V_GEN)cd $(srcdir) && ./xidepend $^ > "$(CURDIR)/$@"
-- 
2.34.1

