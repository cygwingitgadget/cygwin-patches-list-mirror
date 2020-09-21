Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-041.btinternet.com (mailomta4-re.btinternet.com
 [213.120.69.97])
 by sourceware.org (Postfix) with ESMTPS id A1815394948C
 for <cygwin-patches@cygwin.com>; Mon, 21 Sep 2020 19:25:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A1815394948C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
 by re-prd-fep-041.btinternet.com with ESMTP id
 <20200921192554.MOJZ30588.re-prd-fep-041.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>;
 Mon, 21 Sep 2020 20:25:54 +0100
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.176.137.240]
X-OWM-Source-IP: 86.176.137.240 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedruddvgddugedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeefieduveehgfffffeuueehleefgeevfedvffeljeefheduteelteelvdettefhvdenucfkphepkeeirddujeeirddufeejrddvgedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudejiedrudefjedrvdegtddpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.176.137.240) by
 re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C506120E5245; Mon, 21 Sep 2020 20:25:54 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/3] Cygwin: avoid GCC 10 error with -Werror=narrowing
Date: Mon, 21 Sep 2020 20:25:25 +0100
Message-Id: <20200921192526.36773-3-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921192526.36773-1-jon.turney@dronecode.org.uk>
References: <20200921192526.36773-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_NONE,
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
X-List-Received-Date: Mon, 21 Sep 2020 19:25:57 -0000

../../../../src/winsup/cygwin/fhandler_console.cc: In member function 'const unsigned char* fhandler_console::write_normal(const unsigned char*, const unsigned char*)':
../../../../src/winsup/cygwin/fhandler_console.cc:2782:8: error: narrowing conversion of '-2' from 'int' to 'long unsigned int' [-Wnarrowing]
../../../../src/winsup/cygwin/fhandler_console.cc:2786:8: error: narrowing conversion of '-1' from 'int' to 'long unsigned int' [-Wnarrowing]
../../../../src/winsup/cygwin/fhandler_console.cc:2836:8: error: narrowing conversion of '-2' from 'int' to 'long unsigned int' [-Wnarrowing]
../../../../src/winsup/cygwin/fhandler_console.cc:2840:8: error: narrowing conversion of '-1' from 'int' to 'long unsigned int' [-Wnarrowing]

A mbtowc_p funtion returns an int, so that seems the correct type to use here.
---
 winsup/cygwin/fhandler_console.cc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 33e40a9f9..41cac37e6 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -2759,7 +2759,7 @@ fhandler_console::write_normal (const unsigned char *src,
   DWORD done;
   DWORD buf_len;
   const unsigned char *found = src;
-  size_t ret;
+  int ret;
   mbstate_t ps;
   mbtowc_p f_mbtowc;
 
@@ -2938,7 +2938,7 @@ do_print:
 		{
 		  ret = __utf8_mbtowc (_REENT, NULL, (const char *) found + 1,
 				       end - found - 1, &ps);
-		  if (ret != (size_t) -1)
+		  if (ret != -1)
 		    while (ret-- > 0)
 		      {
 			WCHAR w = *(found + 1);
-- 
2.28.0

