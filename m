Return-Path: <SRS0=MPDs=JM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1003.nifty.com (mta-snd01010.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id DB4CE3858C50
	for <cygwin-patches@cygwin.com>; Sat,  3 Feb 2024 09:59:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DB4CE3858C50
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DB4CE3858C50
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1706954381; cv=none;
	b=uvD+A+fMDPLQHPLMhHTSY7NAPGARQzUxzf5/tvelyFJI5s6Hx7b8du4d7dnYsgD8ApNsDcwywNuLYr86SVfqxLNP13MzRp8EOQNWU8yD8KWC8/emEZ/R2mIYg7xNj04LdyaY8K9ACB/5L+b0jtfd7L9k4ilNQS++Ob/3Sbzg5n0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1706954381; c=relaxed/simple;
	bh=qOT5mt4TKrUqIF+rZJpdm4Qli9DL+iqI/cBmTsxOgus=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DYkSGP/nWpE8syB+tY2LBV1A5aFJWEyOwSN85VAVNdgKBBJETsdDq3EJIz0CIvatJG3A34etYAMY/iD0RihLcniJKHsPI7JD/iYdie4J6yMm3y5XRC4ztLAAPa848JkU1Mv3BvC7rqjM+C0mRXfxO8nX8BEQxpP9D7wKUufhFAE=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by dmta1003.nifty.com with ESMTP
          id <20240203095934419.PVPX.95478.localhost.localdomain@nifty.com>;
          Sat, 3 Feb 2024 18:59:34 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: net: Make if_nametoindex, etc. consistent with if_nameindex.
Date: Sat,  3 Feb 2024 18:59:06 +0900
Message-ID: <20240203095919.1483-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently, if_nametoindex() and if_indextoname() handle interface names
such as "ethernet_32777", while if_nameindex() returns the names such
as "{5AF7ACD0-D52E-4DFC-A4D0-54D3E6D6B2AC}". This patch unifies the
interface names to the latter.

Fixes: c356901f0d69 ("Rename if_indextoname to cygwin_if_indextoname (analag for if_nametoindex)")
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/autoload.cc |  2 --
 winsup/cygwin/net.cc      | 31 +++++++++++++++++++++++++++++--
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/autoload.cc b/winsup/cygwin/autoload.cc
index c1a124c1d..7e610bdd0 100644
--- a/winsup/cygwin/autoload.cc
+++ b/winsup/cygwin/autoload.cc
@@ -462,8 +462,6 @@ LoadDLLfunc (GetNetworkParams, iphlpapi)
 LoadDLLfunc (GetTcpTable, iphlpapi)
 LoadDLLfunc (GetTcp6Table, iphlpapi)
 LoadDLLfunc (GetUdpTable, iphlpapi)
-LoadDLLfunc (if_indextoname, iphlpapi)
-LoadDLLfunc (if_nametoindex, iphlpapi)
 
 LoadDLLfuncEx2 (DiscardVirtualMemory, kernel32, 1, 127)
 LoadDLLfuncEx (ClosePseudoConsole, kernel32, 1)
diff --git a/winsup/cygwin/net.cc b/winsup/cygwin/net.cc
index 8840d5ead..08c584fe5 100644
--- a/winsup/cygwin/net.cc
+++ b/winsup/cygwin/net.cc
@@ -2001,13 +2001,40 @@ get_ifconf (struct ifconf *ifc, int what)
 extern "C" unsigned
 cygwin_if_nametoindex (const char *name)
 {
-  return (unsigned) ::if_nametoindex (name);
+  PIP_ADAPTER_ADDRESSES pa0 = NULL, pap;
+  if (get_adapters_addresses (&pa0, AF_UNSPEC))
+    for (pap = pa0; pap; pap = pap->Next)
+      if (strcmp (name, pap->AdapterName) == 0)
+	{
+	  free (pa0);
+	  return pap->IfIndex;
+	}
+  if (pa0)
+    free (pa0);
+  return 0;
 }
 
 extern "C" char *
 cygwin_if_indextoname (unsigned ifindex, char *ifname)
 {
-  return ::if_indextoname (ifindex, ifname);
+  if (ifindex == 0 || ifname == NULL)
+    {
+      set_errno (ENXIO);
+      return NULL;
+    }
+  PIP_ADAPTER_ADDRESSES pa0 = NULL, pap;
+  if (get_adapters_addresses (&pa0, AF_UNSPEC))
+    for (pap = pa0; pap; pap = pap->Next)
+      if (ifindex == pap->IfIndex)
+	{
+	  strcpy (ifname, pap->AdapterName);
+	  free (pa0);
+	  return ifname;
+	}
+  if (pa0)
+    free (pa0);
+  set_errno (ENXIO);
+  return NULL;
 }
 
 extern "C" struct if_nameindex *
-- 
2.43.0

