Return-Path: <cygwin-patches-return-7068-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13278 invoked by alias); 26 Aug 2010 16:08:17 -0000
Received: (qmail 13259 invoked by uid 22791); 26 Aug 2010 16:08:15 -0000
X-SWARE-Spam-Status: No, hits=3.0 required=5.0	tests=AWL,BAYES_05,RDNS_DYNAMIC,TO_NO_BRKTS_DYNIP,TVD_RCVD_IP
X-Spam-Check-By: sourceware.org
Received: from 84-252-10-45.2073173222.ddns-lan.ekk.bg (HELO pseudo.egg6.net) (84.252.10.45)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 26 Aug 2010 16:07:41 +0000
Received: from pseudo.egg6.net (localhost [127.0.0.1])	by pseudo.egg6.net (Postfix) with ESMTP id BDBE77000BF	for <cygwin-patches@cygwin.com>; Thu, 26 Aug 2010 19:07:38 +0300 (EEST)
Received: from 87.120.222.252        (SquirrelMail authenticated user pseudo@egg6.net)        by pseudo.egg6.net with HTTP;        Thu, 26 Aug 2010 19:07:38 +0300
Message-ID: <4e84197e3f02b0bbf6e190e78826148b.squirrel@pseudo.egg6.net>
Date: Thu, 26 Aug 2010 16:08:00 -0000
Subject: res_send() doesn't work with osquery enabled
From: pseudo@egg6.net
To: cygwin-patches@cygwin.com
User-Agent: SquirrelMail/1.4.19
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q3/txt/msg00028.txt.bz2

Currently res_init() checks for availability of the native windows
function DnsQuery_A. If the function is found, it's preferred over the
cygwin implementation and res_query is set up to use it.
As DnsQuery_A finds the configured name servers itself, the current code
assumes we can avoid loading the dns server list with GetNetworkParams().

However, the assumption that everybody would use res_query is wrong. Some
programs may use res_mkquery() and res_send() or may only read the list of
servers from _res.nsaddr_list and send/receive the queries/replies
themselves. res_send() also relies on nsaddr_list.

The following patch makes get_dns_info() always try to populate
nsaddr_list if empty. If resolv.conf exists and provides nameservers, they
will be used as usual. Otherwise, GetNetworkParams() will be called to get
the servers from the operating system.

2010-08-26  Rumen Stoyanov <pseudo@egg6.net>

     * libc/minires-os-if.c (get_dns_info): Always populate nsaddr_list
     if empty, regardless of the availability of os_query.
     * libc/minires.c (res_nsend): Make sure there is atleast one
     nameserver in nsaddr_list or return.


Index: winsup/cygwin/libc/minires-os-if.c
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/libc/minires-os-if.c,v
retrieving revision 1.8
diff -u -p -r1.8 minires-os-if.c
--- winsup/cygwin/libc/minires-os-if.c  3 Jan 2009 05:12:22 -0000       1.8
+++ winsup/cygwin/libc/minires-os-if.c  26 Aug 2010 15:28:32 -0000
@@ -405,13 +405,16 @@ void get_dns_info(res_state statp)
   {
     DPRINTF(debug, "using dnsapi.dll %d\n", dwRetVal);
     statp->os_query = (typeof(statp->os_query)) cygwin_query;
-    /* We just need the search list. Avoid loading iphlpapi. */
-    statp->nscount = -1;
   }

   if (statp->nscount != 0)
     goto use_registry;

+  /* Some applications use res_send() or access the dns server list
+     directly, In both cases the list needs to get populated
+     regardless of the availability of a native os query. */
+  DPRINTF(debug, "no servers. falling back to iphlpapi.dll\n");
+
   /* First call to get the buffer length we need */
   dwRetVal = GetNetworkParams((FIXED_INFO *) 0, &ulOutBufLen);
   if (dwRetVal != ERROR_BUFFER_OVERFLOW) {
Index: winsup/cygwin/libc/minires.c
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/libc/minires.c,v
retrieving revision 1.8
diff -u -p -r1.8 minires.c
--- winsup/cygwin/libc/minires.c        6 May 2009 12:03:32 -0000       1.8
+++ winsup/cygwin/libc/minires.c        26 Aug 2010 15:28:32 -0000
@@ -436,6 +436,10 @@ int res_nsend( res_state statp, const un
   statp->res_h_errno = NETDB_SUCCESS;
   if (((statp->options & RES_INIT) == 0) && (res_ninit(statp) != 0))
     return -1;
+
+  /* successful res_ninit() doesn't guarantee we have servers to send to */
+  if (statp->nscount == 0)
+    return -1;

   /* Close the socket if it had been opened before a fork.
      Reuse of pid's cannot hurt */
