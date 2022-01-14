Return-Path: <lavr@ncbi.nlm.nih.gov>
Received: from nihsmtpxwayst06.hub.nih.gov (nihsmtpxwayst06.hub.nih.gov
 [165.112.13.57])
 by sourceware.org (Postfix) with ESMTPS id AC1383858033
 for <cygwin-patches@cygwin.com>; Fri, 14 Jan 2022 22:10:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org AC1383858033
X-SBRS-Extended: Low
X-IronPortListener: non-ces-out
X-IronPortListener: non-ces-out
X-IronPort-AV: E=Sophos;i="5.88,289,1635220800"; d="scan'208";a="90608943"
Received: from msg-b12-ltm1_v9.hub.nih.gov (HELO mail1.ncbi.nlm.nih.gov)
 ([128.231.90.73])
 by nihsmtpxwayst06.hub.nih.gov with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2022 17:10:53 -0500
Received: from mail2.ncbi.nlm.nih.gov (vhod23.be-md.ncbi.nlm.nih.gov
 [130.14.26.86])
 by mail1.ncbi.nlm.nih.gov (Postfix) with ESMTP id CCB3F340002;
 Fri, 14 Jan 2022 17:10:52 -0500 (EST)
From: Anton Lavrentiev <lavr@ncbi.nlm.nih.gov>
To: cygwin-patches@cygwin.com
Subject: [PATCH 3/7] Debug output to show both IP and port # in native b.o.,
 a few little cosmetic improvements for consistency
Date: Fri, 14 Jan 2022 17:10:14 -0500
Message-Id: <20220114221018.43941-4-lavr@ncbi.nlm.nih.gov>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220114221018.43941-1-lavr@ncbi.nlm.nih.gov>
References: <20220114221018.43941-1-lavr@ncbi.nlm.nih.gov>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00, DKIMWL_WL_HIGH,
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
X-List-Received-Date: Fri, 14 Jan 2022 22:10:56 -0000

---
 winsup/cygwin/libc/minires.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/winsup/cygwin/libc/minires.c b/winsup/cygwin/libc/minires.c
index 0979daae3..58c0438d3 100644
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
@@ -254,6 +254,8 @@ static int open_sock(struct sockaddr_in *CliAddr, int debug)
     DPRINTF(debug, "bind: %s\n", strerror(errno));
     return -1;
   }
+
+  DPRINTF(debug, "UDP socket sockfd %d\n", fd);
   return fd;
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
@@ -519,12 +522,14 @@ int res_nsend( res_state statp, const unsigned char * MsgPtr,
     timeOut.tv_usec = 0;
     rslt = cygwin_select(statp->sockfd + 1, &fdset_read, NULL, NULL, &timeOut);
     if ( rslt == 0 ) { /* Timeout */
-      DPRINTF(statp->options & RES_DEBUG, "timeout for server %08x\n",
-	      statp->nsaddr_list[wServ].sin_addr.s_addr);
+      DPRINTF(statp->options & RES_DEBUG, "timeout for server %08x:%hu sockfd %d\n",
+	      ntohl(statp->nsaddr_list[wServ].sin_addr.s_addr),
+	      ntohs(statp->nsaddr_list[wServ].sin_port),
+	      statp->sockfd);
       continue;
     }
     else if ((rslt != 1) || (FD_ISSET(statp->sockfd, &fdset_read) == 0)) {
-      DPRINTF(debug, "select: %s\n", strerror(errno));
+      DPRINTF(debug, "select sockfd %d: %s\n", statp->sockfd, strerror(errno));
       statp->res_h_errno = NETDB_INTERNAL;
       return -1;
     }
@@ -533,11 +538,14 @@ int res_nsend( res_state statp, const unsigned char * MsgPtr,
     rslt = cygwin_recvfrom(statp->sockfd, AnsPtr, AnsLength, 0,
 			   (struct sockaddr *) & dnsSockAddr, & addrLen);
     if (rslt <= 0) {
-      DPRINTF(debug, "recvfrom: %s\n", strerror(errno));
+      DPRINTF(debug, "recvfrom sockfd %d: %s\n", statp->sockfd, strerror(errno));
       statp->res_h_errno = NETDB_INTERNAL;
       return -1;
     }
-    DPRINTF(debug, "recvfrom: %d bytes from %08x\n", rslt, dnsSockAddr.sin_addr.s_addr);
+    DPRINTF(debug, "recvfrom: %d bytes from %08x:%hu sockfd %d\n", rslt,
+            ntohl(dnsSockAddr.sin_addr.s_addr),
+            ntohs(dnsSockAddr.sin_port),
+            statp->sockfd);
     /*
        Prepare to retry with tcp
     */
-- 
2.33.0

