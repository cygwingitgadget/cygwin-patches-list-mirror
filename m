Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-042.btinternet.com (mailomta32-re.btinternet.com
 [213.120.69.125])
 by sourceware.org (Postfix) with ESMTPS id 99D2839450CF
 for <cygwin-patches@cygwin.com>; Mon, 21 Sep 2020 19:25:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 99D2839450CF
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
 by re-prd-fep-042.btinternet.com with ESMTP id
 <20200921192549.BIIG13627.re-prd-fep-042.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>;
 Mon, 21 Sep 2020 20:25:49 +0100
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.176.137.240]
X-OWM-Source-IP: 86.176.137.240 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedruddvgddugedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeefieduveehgfffffeuueehleefgeevfedvffeljeefheduteelteelvdettefhvdenucfkphepkeeirddujeeirddufeejrddvgedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudejiedrudefjedrvdegtddpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.176.137.240) by
 re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C506120E51B9; Mon, 21 Sep 2020 20:25:49 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/3] Cygwin: avoid GCC 10 error with -Werror=parentheses
Date: Mon, 21 Sep 2020 20:25:24 +0100
Message-Id: <20200921192526.36773-2-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921192526.36773-1-jon.turney@dronecode.org.uk>
References: <20200921192526.36773-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Mon, 21 Sep 2020 19:25:51 -0000

../../../../src/winsup/cygwin/fhandler_socket_inet.cc: In member function 'ssize_t fhandler_socket_wsock::send_internal(_WSAMSG*, int)':
../../../../src/winsup/cygwin/fhandler_socket_inet.cc:1381:69: error: suggest parentheses around assignment used as truth value [-Werror=parentheses]
---
 winsup/cygwin/fhandler_socket_inet.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_socket_inet.cc b/winsup/cygwin/fhandler_socket_inet.cc
index 2b50671e5..71e92e341 100644
--- a/winsup/cygwin/fhandler_socket_inet.cc
+++ b/winsup/cygwin/fhandler_socket_inet.cc
@@ -1378,7 +1378,7 @@ fhandler_socket_wsock::send_internal (struct _WSAMSG *wsamsg, int flags)
      buffer which only gets partially written. */
   for (DWORD in_idx = 0, in_off = 0;
        in_idx < wsamsg->dwBufferCount;
-       in_off >= wsamsg->lpBuffers[in_idx].len && (++in_idx, in_off = 0))
+       in_off >= wsamsg->lpBuffers[in_idx].len && (++in_idx, (in_off = 0)))
     {
       /* Split a message into the least number of pieces to minimize the
 	 number of WsaSendTo calls.  Don't split datagram messages (bad idea).
-- 
2.28.0

