Return-Path: <lavr@ncbi.nlm.nih.gov>
Received: from nihsmtpxwayst06.hub.nih.gov (nihsmtpxwayst06.hub.nih.gov
 [165.112.13.57])
 by sourceware.org (Postfix) with ESMTPS id 3A2E63896812
 for <cygwin-patches@cygwin.com>; Fri, 29 Jan 2021 19:29:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3A2E63896812
IronPort-SDR: VxKYU8YwKG/tVt9cirTxNIeQ7QwIcoKiNeq1WEYezWgCORzfEI3djWy/Pzb9H8pQ/k4rRsbk55
 wNv/Ngagfjuc7faaeTCHtSShPI6idULwpKktpxc3J0aBmcT8W/crLVyd4L3WpP1UVvjKFJAoF1
 apz2zktW0YVJsF+wJMaDtfq12yZTQW7u1yBstuunkZx/n5yZWB2afsfoGzm3tbfXEnn9rXQfiV
 79jyBFZlGzdDYTO3/5fkGoKjmTWb/mgb8sf3Em6swnxW9sD4tc9RMzrlK+RF0r9mbvPGduzhEP
 BHI=
X-SBRS-Extended: Low
X-IronPortListener: non-ces-out
X-IronPortListener: non-ces-out
X-IronPort-AV: E=Sophos;i="5.79,386,1602561600"; d="scan'208";a="45632784"
Received: from msg-b12-ltm1_v9.hub.nih.gov (HELO mail2.ncbi.nlm.nih.gov)
 ([128.231.90.73])
 by nihsmtpxwayst06.hub.nih.gov with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2021 14:29:39 -0500
Received: from mail1.ncbi.nlm.nih.gov (vhod12.be-md.ncbi.nlm.nih.gov
 [130.14.26.83])
 by mail2.ncbi.nlm.nih.gov (Postfix) with ESMTP id BB7851A0009;
 Fri, 29 Jan 2021 14:29:30 -0500 (EST)
From: Anton Lavrentiev <lavr@ncbi.nlm.nih.gov>
To: cygwin-patches@cygwin.com
Subject: [PATCH] CYGWIN:  Fix resolver debugging output
Date: Fri, 29 Jan 2021 14:29:03 -0500
Message-Id: <20210129192903.939-1-lavr@ncbi.nlm.nih.gov>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.4 required=5.0 tests=BAYES_00, DKIMWL_WL_HIGH,
 DKIM_SIGNED, DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, FROM_GOV_DKIM_AU,
 GIT_PATCH_0, SPF_HELO_PASS, SPF_PASS,
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
X-List-Received-Date: Fri, 29 Jan 2021 19:29:49 -0000

- Use %S (instead of %s) when a wide-character output is due;
- Use native byte order for host and add port when doing I/O with DNS server;
- Use forward way for resolv.conf's "options" processing, so listing "debug" as a
  first option, will show all following option(s) as they are read;
- Re-evaluate debug output flag after each "options" processing as it may chance.
---
 winsup/cygwin/libc/minires-os-if.c |  6 +++---
 winsup/cygwin/libc/minires.c       | 32 ++++++++++++++++++------------
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/winsup/cygwin/libc/minires-os-if.c b/winsup/cygwin/libc/minires-os-if.c
index 565158150..dedee3098 100644
--- a/winsup/cygwin/libc/minires-os-if.c
+++ b/winsup/cygwin/libc/minires-os-if.c
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
 
-  DPRINTF(statp->options & RES_DEBUG, "key %s\n", keyName);
+  DPRINTF(statp->options & RES_DEBUG, "key %S\n", keyName);
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
diff --git a/winsup/cygwin/libc/minires.c b/winsup/cygwin/libc/minires.c
index 0979daae3..8c7e31218 100644
--- a/winsup/cygwin/libc/minires.c
+++ b/winsup/cygwin/libc/minires.c
@@ -73,7 +73,7 @@ void minires_get_search(char * string, res_state statp)
       statp->dnsrch[j] = strcpy(ptr, words[j]);
       statp->dnsrch[j+1] = NULL;
       ptr += sizes[j];
-      DPRINTF(debug, "search \"%s\"\n", words[j]);
+      DPRINTF(debug, "registry search \"%s\"\n", words[j]);
     }
     else if (j < MAXDNSRCH + 1)
       DPRINTF(debug, "no space for \"%s\"\n", words[j]);
@@ -86,12 +86,12 @@ Read options
 
 
 ***********************************************************************/
-static void get_options(res_state statp, int i, char **words)
+static void get_options(res_state statp, int n, char **words)
 {
   char *ptr;
-  int value;
+  int i, value;
 
-  while (i-- > 0) {
+  for (i = 0;  i < n;  ++i) {
     if (!strcasecmp("debug", words[i])) {
       statp->options |= RES_DEBUG;
       DPRINTF(statp->options & RES_DEBUG, "%s: 1\n", words[i]);
@@ -170,7 +170,7 @@ static void get_resolv(res_state statp)
   have_address = (statp->nscount != 0);
 
   while ( fgets(line, sizeof(line), fd) != 0) {
-    DPRINTF(debug, "resolv.conf %s", line);
+    DPRINTF(debug, _PATH_RESCONF " line: %s", line);
     if ((i = scanline(line, words, sizes, DIM(words))) > 0) {
       if (!have_address
 	  && !strncasecmp("nameserver", words[0], sizes[0])) {
@@ -186,7 +186,7 @@ static void get_resolv(res_state statp)
 	  else {
 	    statp->nsaddr_list[ns++].sin_addr.s_addr = address;
 	    statp->nscount++;
-	    DPRINTF(debug, "server \"%s\"\n", words[j]);
+	    DPRINTF(debug, "nameserver \"%s\"\n", words[j]);
 	  }
 	}
       }
@@ -208,8 +208,10 @@ static void get_resolv(res_state statp)
 	}
       }
       /* Options line */
-      else if (!strncasecmp("options", words[0], sizes[0]))
+      else if (!strncasecmp("options", words[0], sizes[0])) {
 	get_options(statp, i - 1, &words[1]);
+        debug = statp->options & RES_DEBUG;
+      }
     }
   }
   fclose(fd);
@@ -332,7 +334,7 @@ void res_nclose(res_state statp)
   if (statp->sockfd != -1) {
     res = close(statp->sockfd);
     DPRINTF(statp->options & RES_DEBUG, "close sockfd %d: %s\n",
-	    statp->sockfd, (res == 0)?"OK":strerror(errno));
+	    statp->sockfd, res == 0 ? "OK" : strerror(errno));
     statp->sockfd = -1;
   }
 }
@@ -503,8 +505,9 @@ int res_nsend( res_state statp, const unsigned char * MsgPtr,
     rslt = cygwin_sendto(statp->sockfd, MsgPtr, MsgLength, 0,
 			 (struct sockaddr *) &statp->nsaddr_list[wServ],
 			 sizeof(struct sockaddr_in));
-    DPRINTF(debug, "sendto: server %08x sockfd %d %s\n",
-	    statp->nsaddr_list[wServ].sin_addr.s_addr,
+    DPRINTF(debug, "sendto: server %08x:%hu sockfd %d %s\n",
+	    ntohl(statp->nsaddr_list[wServ].sin_addr.s_addr),
+	    ntohs(statp->nsaddr_list[wServ].sin_port),
 	    statp->sockfd, (rslt == MsgLength)?"OK":strerror(errno));
     if (rslt != MsgLength) {
       statp->res_h_errno = NETDB_INTERNAL;
@@ -519,8 +522,9 @@ int res_nsend( res_state statp, const unsigned char * MsgPtr,
     timeOut.tv_usec = 0;
     rslt = cygwin_select(statp->sockfd + 1, &fdset_read, NULL, NULL, &timeOut);
     if ( rslt == 0 ) { /* Timeout */
-      DPRINTF(statp->options & RES_DEBUG, "timeout for server %08x\n",
-	      statp->nsaddr_list[wServ].sin_addr.s_addr);
+      DPRINTF(statp->options & RES_DEBUG, "timeout for server %08x:%hu\n",
+	      ntohl(statp->nsaddr_list[wServ].sin_addr.s_addr),
+	      ntohs(statp->nsaddr_list[wServ].sin_port));
       continue;
     }
     else if ((rslt != 1) || (FD_ISSET(statp->sockfd, &fdset_read) == 0)) {
@@ -537,7 +541,9 @@ int res_nsend( res_state statp, const unsigned char * MsgPtr,
       statp->res_h_errno = NETDB_INTERNAL;
       return -1;
     }
-    DPRINTF(debug, "recvfrom: %d bytes from %08x\n", rslt, dnsSockAddr.sin_addr.s_addr);
+    DPRINTF(debug, "recvfrom: %d bytes from %08x:%hu\n", rslt, 
+            ntohl(dnsSockAddr.sin_addr.s_addr),
+            ntohs(dnsSockAddr.sin_port));
     /*
        Prepare to retry with tcp
     */
-- 
2.29.2

