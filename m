Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id EBFC738515CD
 for <cygwin-patches@cygwin.com>; Wed, 18 May 2022 18:23:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org EBFC738515CD
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 24IIMf81024473;
 Thu, 19 May 2022 03:22:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 24IIMf81024473
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1652898168;
 bh=+zdYvzk3X70NMezyYSy98ssAl2GPnUK9vufnBxmggEg=;
 h=From:To:Cc:Subject:Date:From;
 b=VZPQtYlcQfsbaO71Owo/1G9JFy3TM/1YimcX9AgGi1McwwbXVKIzuSx0E1ouX3pZh
 0iJZR2B6jv5jLasrR4KWKHRuBumTsAqKxMTcP04FaWb0M+KJ2lg28cXeDtmX5uUCl0
 0PUVVmLlRyXzGhy3zMKN7iVjvZuCwYUl234GHrYlqjzaSCl8BTT8z+vDg7zuTPHVkS
 88X4Rf97OGhrqVAGlgoKCKFMf1CEzR45H1Ku96dSF+zc9S9Es5ZmaJcakVyaDUkFMR
 Bh4YQZTljzPv6ktQBTXUt9NW1IgIah0Pevva3Jgd6BIJ+fC+FtmmC8Y8rIffFV1D9Y
 KS12O6tMz593Q==
X-Nifty-SrcIP: [119.150.44.95]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: Use two pass parse for tlsoffsets generation.
Date: Thu, 19 May 2022 03:22:35 +0900
Message-Id: <20220518182235.9203-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Wed, 18 May 2022 18:23:17 -0000

- The commit "Cygwin: fix new sigfe.o generation in optimized case"
  fixed the wrong tlsoffsets generation by adding -O0 to compile
  options. Current gentls_offsets expects entry of "start_offset"
  is the first entry in the assembler code. However, without -O0,
  entry of "start_offset" goes to the last entry for some reason.
  Currently, -O0 can prevents assembler code from reversing the
  order of the entry, however, there is no guarantee will retain
  the order of the entries in the future.

  This patch make gentls_offsets parse the assembler code in the
  two pass to omit -O0 option dependency.
---
 winsup/cygwin/gentls_offsets | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/gentls_offsets b/winsup/cygwin/gentls_offsets
index d76562c05..111e6aa78 100755
--- a/winsup/cygwin/gentls_offsets
+++ b/winsup/cygwin/gentls_offsets
@@ -43,7 +43,7 @@ gawk '
   }
 ' | \
 # Now run the compiler to generate an assembler file.
-${CXXCOMPILE} -x c++ -g0 -O0 -S - -o - | \
+${CXXCOMPILE} -x c++ -g0 -S - -o ${output_file}.s && \
 # The assembler file consists of lines like these:
 #
 #   __CYGTLS__foo
@@ -52,10 +52,25 @@ ${CXXCOMPILE} -x c++ -g0 -O0 -S - -o - | \
 #       .align 4
 #
 # From this info, generate the tlsoffsets file.
-gawk '\
+start_offset=$(gawk '\
+  BEGIN {
+    varname=""
+  }
+  /^__CYGTLS__/ {
+    varname = gensub (/__CYGTLS__(\w+):/, "\\1", "g");
+  }
+  /\s*\.long\s+/ {
+    if (length (varname) > 0) {
+      if (varname == "start_offset") {
+	print $2;
+      }
+      varname = "";
+    }
+  }
+' ${output_file}.s) && \
+gawk -v start_offset="$start_offset" '\
   BEGIN {
     varname=""
-    start_offset = 0
   }
   /^__CYGTLS__/ {
     varname = gensub (/__CYGTLS__(\w+):/, "\\1", "g");
@@ -70,7 +85,6 @@ gawk '\
   /\s*\.long\s+/ {
     if (length (varname) > 0) {
       if (varname == "start_offset") {
-      	start_offset = $2;
 	printf (".equ _cygtls.%s, -%u\n", varname, start_offset);
       } else {
       	value = $2;
@@ -80,4 +94,7 @@ gawk '\
       varname = "";
     }
   }
-' > "${output_file}"
+' ${output_file}.s > "${output_file}"
+ret=$?
+rm -f ${output_file}.s
+exit $ret
-- 
2.36.1

