Return-Path: <lavr@ncbi.nlm.nih.gov>
Received: from nihsmtpxwayst06.hub.nih.gov (nihsmtpxwayst06.hub.nih.gov
 [165.112.13.57])
 by sourceware.org (Postfix) with ESMTPS id C3F7B385E44C
 for <cygwin-patches@cygwin.com>; Fri, 14 Jan 2022 22:10:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org C3F7B385E44C
X-SBRS-Extended: Low
X-IronPortListener: non-ces-out
X-IronPortListener: non-ces-out
X-IronPort-AV: E=Sophos;i="5.88,289,1635220800"; d="scan'208";a="90608949"
Received: from msg-b12-ltm1_v9.hub.nih.gov (HELO mail1.ncbi.nlm.nih.gov)
 ([128.231.90.73])
 by nihsmtpxwayst06.hub.nih.gov with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2022 17:10:53 -0500
Received: from mail2.ncbi.nlm.nih.gov (vhod23.be-md.ncbi.nlm.nih.gov
 [130.14.26.86])
 by mail1.ncbi.nlm.nih.gov (Postfix) with ESMTP id 4FB03340005;
 Fri, 14 Jan 2022 17:10:53 -0500 (EST)
From: Anton Lavrentiev <lavr@ncbi.nlm.nih.gov>
To: cygwin-patches@cygwin.com
Subject: [PATCH 6/7] Message consistency
Date: Fri, 14 Jan 2022 17:10:17 -0500
Message-Id: <20220114221018.43941-7-lavr@ncbi.nlm.nih.gov>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220114221018.43941-1-lavr@ncbi.nlm.nih.gov>
References: <20220114221018.43941-1-lavr@ncbi.nlm.nih.gov>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00, DKIMWL_WL_HIGH,
 DKIM_SIGNED, DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, FROM_GOV_DKIM_AU,
 GIT_PATCH_0, SPF_PASS, TXREP,
 T_SPF_HELO_PERMERROR autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Fri, 14 Jan 2022 22:10:58 -0000

---
 winsup/cygwin/libc/minires-os-if.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/libc/minires-os-if.c b/winsup/cygwin/libc/minires-os-if.c
index f71178b96..6b4c5e33e 100644
--- a/winsup/cygwin/libc/minires-os-if.c
+++ b/winsup/cygwin/libc/minires-os-if.c
@@ -165,7 +165,7 @@ static unsigned char * write_record(unsigned char * ptr, PDNS_RECORD rr,
   default:
   {
     unsigned int len = rr->wDataLength;
-    DPRINTF(debug, "No structure for wType %d\n", rr->wType);
+    DPRINTF(debug, "No structure for wType %u\n", rr->wType);
     if (ptr + len <= EndPtr)
       memcpy(ptr, (char *) &rr->Data, len);
     ptr += len;
@@ -210,7 +210,7 @@ static int cygwin_query(res_state statp, const char * DomName, int Class, int Ty
 #define NO_DATA		4 /* Valid name, no data record of requested type */
 #endif
 
-  DPRINTF(debug, "DnsQuery: %u (Windows)\n", res);
+  DPRINTF(debug, "DnsQuery for \"%s\" %d: %u (Windows)\n", DomName, Type, res);
   if (res) {
     switch (res) {
     case ERROR_INVALID_NAME:
@@ -236,7 +236,7 @@ static int cygwin_query(res_state statp, const char * DomName, int Class, int Ty
       statp->res_h_errno = NO_DATA;
       break;
     default:
-      DPRINTF(debug, "Unknown code %u for %s %d\n", res, DomName, Type);
+      DPRINTF(debug, "Unknown code %u\n", res);
       statp->res_h_errno = NO_RECOVERY;
       break;
     }
@@ -274,7 +274,7 @@ static int cygwin_query(res_state statp, const char * DomName, int Class, int Ty
 
     /* Check the records are in correct section order */
     if ((rr->Flags.DW & 0x3) < section) {
-      DPRINTF(debug, "Unexpected section order %s %d\n", DomName, Type);
+      DPRINTF(debug, "Unexpected section order for \"%s\" %d\n", DomName, Type);
       continue;
     }
     section =  rr->Flags.DW & 0x3;
@@ -324,7 +324,7 @@ static void get_registry_dns_items(PUNICODE_STRING in, res_state statp,
 	     srch++);
 	*srch++ = 0;
 	if (numAddresses < DIM(statp->nsaddr_list)) {
-	  DPRINTF(debug, "server \"%s\"\n", ap);
+	  DPRINTF(debug, "registry server \"%s\"\n", ap);
 	  statp->nsaddr_list[numAddresses].sin_addr.s_addr = cygwin_inet_addr((char *) ap);
 	  if ( statp->nsaddr_list[numAddresses].sin_addr.s_addr != 0 )
 	    numAddresses++;
@@ -355,7 +355,7 @@ static void get_registry_dns(res_state statp)
   NTSTATUS status;
   const PCWSTR keyName = L"Tcpip\\Parameters";
 
-  DPRINTF(statp->options & RES_DEBUG, "key %ls\n", keyName);
+  DPRINTF(statp->options & RES_DEBUG, "key \"%ls\"\n", keyName);
   status = RtlCheckRegistryKey (RTL_REGISTRY_SERVICES, keyName);
   if (!NT_SUCCESS (status))
     {
@@ -460,7 +460,7 @@ void get_dns_info(res_state statp)
        pIPAddr;
        pIPAddr = pIPAddr->Next) {
     if (numAddresses < DIM(statp->nsaddr_list)) {
-	DPRINTF(debug, "server \"%s\"\n", pIPAddr->IpAddress.String);
+	DPRINTF(debug, "params server \"%s\"\n", pIPAddr->IpAddress.String);
       statp->nsaddr_list[numAddresses].sin_addr.s_addr = cygwin_inet_addr(pIPAddr->IpAddress.String);
       if (statp->nsaddr_list[numAddresses].sin_addr.s_addr != 0) {
 	numAddresses++;
-- 
2.33.0

