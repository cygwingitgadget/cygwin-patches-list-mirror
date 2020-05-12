Return-Path: <david.macek.0@gmail.com>
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by sourceware.org (Postfix) with ESMTPS id 5D9D5386F46B
 for <cygwin-patches@cygwin.com>; Tue, 12 May 2020 20:49:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5D9D5386F46B
Received: by mail-wm1-x344.google.com with SMTP id z72so15816644wmc.2
 for <cygwin-patches@cygwin.com>; Tue, 12 May 2020 13:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-transfer-encoding;
 bh=4K/G8p5byxHLg5JDYI9AIrpVUchBncIrFY0jY3DF9tU=;
 b=CRL1oGOslrJ7zf02M+Loq63dEoRzh2JdmhS/ZR6sQTm47B13QKW/nSDB/5aEWPikFd
 bkFPkrd2YjCwcIFyHQ5pGXZFzPJXvk6wlmYi/e9kaw56bfGatSUalv4Wd0vROrPBYJ1d
 n/aJzXRm2hyPUOTLb1uufCNz6A64/LDzlp5WskttrFlreVvgZlYL62ozJHjPzPJEdQH5
 Mu1xe4LNy2VOCbrm7m5skn7t1UDvPnmUP5b9odtsYwDgNg5C80yoPMrJWfX/OZftGjXf
 rjywBUuqw/KDQxcdamrrENGaR49GCSSh9YoJLKYvgGdGqJEnwR2DE7QH9pOlo48pRl1J
 cfuw==
X-Gm-Message-State: AGi0PubsTj0xvGvc0Ay+nmre3kWDyDj7hhfgskkeyfCpqsSGnUfWAyYJ
 w9zq+S1eOEvHsNJmBVrOCr8B9YZ7
X-Google-Smtp-Source: APiQypISMzKp/KJDDPCcKbX0dKtDK6d1OtgTEcNIJnkHoY0LsV9fA4We89Qh3G33O55aGBqU1fnfnQ==
X-Received: by 2002:a1c:7d92:: with SMTP id y140mr23887658wmc.10.1589316558025; 
 Tue, 12 May 2020 13:49:18 -0700 (PDT)
Received: from localhost ([193.165.97.191])
 by smtp.gmail.com with ESMTPSA id d1sm22908145wrx.65.2020.05.12.13.49.17
 for <cygwin-patches@cygwin.com>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 13:49:17 -0700 (PDT)
Date: Tue, 12 May 2020 22:49:15 +0200
From: David Macek <david.macek.0@gmail.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] cygwin: doc: Add keywords for ACE order issues
Message-ID: <20200512224910.0000040e@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, FREEMAIL_ENVFROM_END_DIGIT,
 FREEMAIL_FROM, GIT_PATCH_0, RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 12 May 2020 20:49:20 -0000

Windows Explorer shows a warning with Cygwin-created DACLs, but putting
the text of the warning into Google doesn't lead to the relevant Cygwin
docs.  Let's copy the warning text into the docs in the hopes of helping
confused users.

Latest inquiry: <https://cygwin.com/pipermail/cygwin/2020-May/244814.html>

Signed-off-by: David Macek <david.macek.0@gmail.com>
---
 winsup/doc/ntsec.xml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/winsup/doc/ntsec.xml b/winsup/doc/ntsec.xml
index 08a33bdc6c..b94cdd9a97 100644
--- a/winsup/doc/ntsec.xml
+++ b/winsup/doc/ntsec.xml
@@ -2163,7 +2163,10 @@ preferred order.</para>
 the Windows Explorer insists to rearrange the order of the ACEs to
 canonical order before you can read them. Thank God, the sort order
 remains unchanged if one presses the Cancel button.  But don't even
-<emphasis role='bold'>think</emphasis> of pressing OK...</para>
+<emphasis role='bold'>think</emphasis> of pressing OK...  For the sake
+of people searching for this explanation, let's note that the Explorer
+warning says "The permissions on ... are incorrectly orderer, which may
+cause some entries to be ineffective."</para>
 
 <para>Canonical ACLs are unable to reflect each possible combination
 of POSIX permissions. Example:</para>
-- 
2.26.2.windows.1

