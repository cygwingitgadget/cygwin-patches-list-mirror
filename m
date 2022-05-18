Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id 8B359385043C
 for <cygwin-patches@cygwin.com>; Wed, 18 May 2022 18:49:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 8B359385043C
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 24IImmS5005653;
 Thu, 19 May 2022 03:48:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 24IImmS5005653
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1652899735;
 bh=Tt/FLu/MU8WFK2CUg4PN3YK69pUW/x84A/nij0NsoaE=;
 h=From:To:Cc:Subject:Date:From;
 b=L4pjRmYElAkB0O3IfFX3dTiGgc0MNuLc2hAzChGzAgFO0xAf+jWkLldpPT7+phcdD
 Qp4pFCasoP93VDwVJ0T3dqxekIlbFSar5WqNA7ipT3luu0CJpZqhmFmYX0dtexx/9U
 m4//Wn6Wr2sqrrO8L4xrvv9ZZdMyW+er3xkSJEVBINNCfFQY/nYv6gvvmMODVlHuKK
 ymtIqyuwd9FIE3ctRHNi4Jh4lRB7fKK13wgqBF0tV6vau3JfwlwCnkw1qWw/Z/Pc57
 kMGyuerik1zZUrRl3mDhiBHMCVkT4FSJ3nTBFfCjfK9AFkb6mKIXRoSgVRzEoErQsh
 106z4cNyQdqiA==
X-Nifty-SrcIP: [119.150.44.95]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2] Cygwin: Use two pass parse for tlsoffsets generation.
Date: Thu, 19 May 2022 03:48:44 +0900
Message-Id: <20220518184844.9219-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Wed, 18 May 2022 18:49:18 -0000

- The commit "Cygwin: fix new sigfe.o generation in optimized case"
  fixed the wrong tlsoffsets generation by adding -O0 to compile
  options. Current gentls_offsets expects entry of "start_offset"
  is the first entry in the assembler code. However, without -O0,
  entry of "start_offset" goes to the last entry for some reason.
  Currently, -O0 can prevents assembler code from reversing the
  order of the entry, however, there is no guarantee will retain
  the order of the entries in the future.

  This patch makes gentls_offsets parse the assembler code in the
  two pass to omit -O0 option dependency.
---
 winsup/cygwin/gentls_offsets | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/gentls_offsets b/winsup/cygwin/gentls_offsets
index d76562c05..0adb702a3 100755
--- a/winsup/cygwin/gentls_offsets
+++ b/winsup/cygwin/gentls_offsets
@@ -2,6 +2,9 @@
 #set -x
 input_file=$1
 output_file=$2
+tmp_file=/tmp/${output_file}.$$
+
+trap "rm -f ${tmp_file}" 0 1 2 15
 
 # Preprocess cygtls.h and filter out only the member lines from
 # class _cygtls to generate an input file for the cross compiler
@@ -43,7 +46,7 @@ gawk '
   }
 ' | \
 # Now run the compiler to generate an assembler file.
-${CXXCOMPILE} -x c++ -g0 -O0 -S - -o - | \
+${CXXCOMPILE} -x c++ -g0 -S - -o ${tmp_file} && \
 # The assembler file consists of lines like these:
 #
 #   __CYGTLS__foo
@@ -52,10 +55,25 @@ ${CXXCOMPILE} -x c++ -g0 -O0 -S - -o - | \
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
+' ${tmp_file}) && \
+gawk -v start_offset="$start_offset" '\
   BEGIN {
     varname=""
-    start_offset = 0
   }
   /^__CYGTLS__/ {
     varname = gensub (/__CYGTLS__(\w+):/, "\\1", "g");
@@ -70,7 +88,6 @@ gawk '\
   /\s*\.long\s+/ {
     if (length (varname) > 0) {
       if (varname == "start_offset") {
-      	start_offset = $2;
 	printf (".equ _cygtls.%s, -%u\n", varname, start_offset);
       } else {
       	value = $2;
@@ -80,4 +97,4 @@ gawk '\
       varname = "";
     }
   }
-' > "${output_file}"
+' ${tmp_file} > "${output_file}"
-- 
2.36.1

