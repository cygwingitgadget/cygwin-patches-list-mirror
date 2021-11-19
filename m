Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id AF3723857C43
 for <cygwin-patches@cygwin.com>; Fri, 19 Nov 2021 11:51:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org AF3723857C43
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 1AJBop3k025767;
 Fri, 19 Nov 2021 20:50:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 1AJBop3k025767
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1637322656;
 bh=H4NTiJylQWUMBmUvE2jDoOi4rIEOL9qV0DEJ/Od3Vwc=;
 h=From:To:Cc:Subject:Date:From;
 b=iFa4LNc58PvNbthM5ILxES9ZPqMG/1iJM5AoiHqCXxvVtupZRCrGtLy07VJDS8ykt
 L7VzhnkR8OXdfLnJ6L+U7Q57BoAGOkucjAumEC8ipYVAO7EqYqhDU6p+x05NwhEyN2
 srEW++aN61JTg//Acap47EvofzNkp/ZeCisHU1qvnUzmzzwrI6pLgAvC4RzyTygpE/
 9YiiI8ouefIl+QAquYw8NyTIj9Pi6WkbMjAiZ4Y0paj0t2E3hgg8Nz9QMPKulYjDWb
 HZ0+Dc5YkyGZzesSBtbS3V31TUw6dEstmVRht0PoK0vy7yiEW9fSLiqe9OIqQPzfg8
 Y9dQ5umLM+JLw==
X-Nifty-SrcIP: [110.4.221.123]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: sigproc: Do not send signal to myself if exiting.
Date: Fri, 19 Nov 2021 20:50:43 +0900
Message-Id: <20211119115043.356-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Fri, 19 Nov 2021 11:51:18 -0000

- This patch fixes the issue that process sometimes hangs for 60
  seconds with the following scenario.
    1) Open command prompt.
    2) Run "c:\cygwin64\bin\bash -l"
    3) Compipe the following source with mingw compiler.
       /*--- Begin ---*/
       #include <stdio.h>
       int main() {return getchar();}
       /*---- End ----*/
    3) Run "tcsh -c ./a.exe"
    4) Hit Ctrl-C.
---
 winsup/cygwin/sigproc.cc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 97211edcf..9160dd160 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -603,6 +603,10 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
       its_me = false;
     }
 
+  /* Do not send signal to myself if exiting. */
+  if (its_me && exit_state > ES_EXIT_STARTING && si.si_signo > 0)
+    goto out;
+
   if (its_me)
     sendsig = my_sendsig;
   else
-- 
2.33.0

