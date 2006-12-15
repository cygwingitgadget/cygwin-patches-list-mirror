Return-Path: <cygwin-patches-return-6015-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30108 invoked by alias); 15 Dec 2006 03:45:30 -0000
Received: (qmail 30096 invoked by uid 22791); 15 Dec 2006 03:45:28 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-68-163-198-143.bos.east.verizon.net (HELO pool-68-163-198-143.bos.east.verizon.net) (68.163.198.143)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 15 Dec 2006 03:45:24 +0000
Received: from [192.168.1.10] (helo=Compaq) 	by phumblet.no-ip.org with smtp (Exim 4.63) 	(envelope-from <pierre@phumblet.no-ip.org>) 	id JAAQFK-00035W-H4 	for cygwin-patches@cygwin.com; Thu, 14 Dec 2006 22:45:20 -0500
Message-Id: <3.0.1.32.20061214224518.00bbb670@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
X-Mailer: Windows Eudora Pro Version 3.0.1 (32)
Date: Fri, 15 Dec 2006 03:45:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch] minires
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1166172318==_"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q4/txt/msg00033.txt.bz2


--=====================_1166172318==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 2783


2006-12-13  Pierre A. Humblet  <Pierre.Humblet@ieee.org>

	* libc/minires-os-if.c (cygwin_query): Remove ERROR_PROC_NOT_FOUND case.
	(get_dns_info): Verify DnsQuery exists. Use autoloaded GetNetworkParams.



Index: minires-os-if.c
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/libc/minires-os-if.c,v
retrieving revision 1.1
diff -u -p -r1.1 minires-os-if.c
--- minires-os-if.c     11 Dec 2006 19:59:06 -0000      1.1
+++ minires-os-if.c     15 Dec 2006 03:34:28 -0000
@@ -196,10 +196,6 @@ static int cygwin_query(res_state statp,
   DPRINTF(debug, "DnsQuery: %lu (Windows)\n", res);
   if (res) {
     switch (res) {
-    case ERROR_PROC_NOT_FOUND:
-      errno = ENOSYS;
-      statp->res_h_errno = NO_RECOVERY;
-      break;
     case ERROR_INVALID_NAME:
       errno = EINVAL;
       statp->res_h_errno = NETDB_INTERNAL;;
@@ -393,13 +389,12 @@ void get_dns_info(res_state statp)
   DWORD dwRetVal;
   IP_ADDR_STRING * pIPAddr;
   FIXED_INFO * pFixedInfo;
-  HINSTANCE kerneldll;
-  typedef DWORD WINAPI (*GNPType)(PFIXED_INFO, PULONG);
-  GNPType PGetNetworkParams;
   int numAddresses = 0;
 
-  if (statp->use_os) {
-    DPRINTF(debug, "using dnsapi.dll\n");
+  if (statp->use_os
+      && ((dwRetVal = DnsQuery_A(NULL, 0, 0, NULL, NULL, NULL)) !=
ERROR_PROC_NOT_FOUND))
+  {
+    DPRINTF(debug, "using dnsapi.dll %d\n", dwRetVal);
     statp->os_query = (typeof(statp->os_query)) cygwin_query;
     /* We just need the search list. Avoid loading iphlpapi. */
     statp->nscount = -1;
@@ -408,17 +403,8 @@ void get_dns_info(res_state statp)
   if (statp->nscount != 0)
     goto use_registry;
 
-  if (!(kerneldll = LoadLibrary("IPHLPAPI.DLL"))) {
-    DPRINTF(debug, "LoadLibrary: error %lu (Windows)\n", GetLastError());
-    goto use_registry;
-  }
-  if (!(PGetNetworkParams = (GNPType) GetProcAddress(kerneldll, 
-                                                    "GetNetworkParams"))) {
-    DPRINTF(debug, "GetProcAddress: error %lu (Windows)\n", GetLastError());
-    goto use_registry;
-  }
   /* First call to get the buffer length we need */
-  dwRetVal = PGetNetworkParams((FIXED_INFO *) 0, &ulOutBufLen);
+  dwRetVal = GetNetworkParams((FIXED_INFO *) 0, &ulOutBufLen);
   if (dwRetVal != ERROR_BUFFER_OVERFLOW) {
     DPRINTF(debug, "GetNetworkParams: error %lu (Windows)\n", dwRetVal);
     goto use_registry;
@@ -427,7 +413,7 @@ void get_dns_info(res_state statp)
     DPRINTF(debug, "alloca: %s\n", strerror(errno));
     goto use_registry;
   }
-  if ((dwRetVal = PGetNetworkParams((FIXED_INFO *) pFixedInfo, &
ulOutBufLen))) {
+  if ((dwRetVal = GetNetworkParams(pFixedInfo, & ulOutBufLen))) {
     DPRINTF(debug, "GetNetworkParams: error %lu (Windows)\n", dwRetVal);
     goto use_registry;
   }

--=====================_1166172318==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="mini.diff"
Content-length: 2694

Index: minires-os-if.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/libc/minires-os-if.c,v
retrieving revision 1.1
diff -u -p -r1.1 minires-os-if.c
--- minires-os-if.c	11 Dec 2006 19:59:06 -0000	1.1
+++ minires-os-if.c	15 Dec 2006 03:34:22 -0000
@@ -196,10 +196,6 @@ static int cygwin_query(res_state statp,
   DPRINTF(debug, "DnsQuery: %lu (Windows)\n", res);
   if (res) {
     switch (res) {
-    case ERROR_PROC_NOT_FOUND:
-      errno =3D ENOSYS;
-      statp->res_h_errno =3D NO_RECOVERY;
-      break;
     case ERROR_INVALID_NAME:
       errno =3D EINVAL;
       statp->res_h_errno =3D NETDB_INTERNAL;;
@@ -393,13 +389,12 @@ void get_dns_info(res_state statp)
   DWORD dwRetVal;
   IP_ADDR_STRING * pIPAddr;
   FIXED_INFO * pFixedInfo;
-  HINSTANCE kerneldll;
-  typedef DWORD WINAPI (*GNPType)(PFIXED_INFO, PULONG);
-  GNPType PGetNetworkParams;
   int numAddresses =3D 0;

-  if (statp->use_os) {
-    DPRINTF(debug, "using dnsapi.dll\n");
+  if (statp->use_os
+      && ((dwRetVal =3D DnsQuery_A(NULL, 0, 0, NULL, NULL, NULL)) !=3D ERR=
OR_PROC_NOT_FOUND))
+  {
+    DPRINTF(debug, "using dnsapi.dll %d\n", dwRetVal);
     statp->os_query =3D (typeof(statp->os_query)) cygwin_query;
     /* We just need the search list. Avoid loading iphlpapi. */
     statp->nscount =3D -1;
@@ -408,17 +403,8 @@ void get_dns_info(res_state statp)
   if (statp->nscount !=3D 0)
     goto use_registry;

-  if (!(kerneldll =3D LoadLibrary("IPHLPAPI.DLL"))) {
-    DPRINTF(debug, "LoadLibrary: error %lu (Windows)\n", GetLastError());
-    goto use_registry;
-  }
-  if (!(PGetNetworkParams =3D (GNPType) GetProcAddress(kerneldll,
-						     "GetNetworkParams"))) {
-    DPRINTF(debug, "GetProcAddress: error %lu (Windows)\n", GetLastError()=
);
-    goto use_registry;
-  }
   /* First call to get the buffer length we need */
-  dwRetVal =3D PGetNetworkParams((FIXED_INFO *) 0, &ulOutBufLen);
+  dwRetVal =3D GetNetworkParams((FIXED_INFO *) 0, &ulOutBufLen);
   if (dwRetVal !=3D ERROR_BUFFER_OVERFLOW) {
     DPRINTF(debug, "GetNetworkParams: error %lu (Windows)\n", dwRetVal);
     goto use_registry;
@@ -427,7 +413,7 @@ void get_dns_info(res_state statp)
     DPRINTF(debug, "alloca: %s\n", strerror(errno));
     goto use_registry;
   }
-  if ((dwRetVal =3D PGetNetworkParams((FIXED_INFO *) pFixedInfo, & ulOutBu=
fLen))) {
+  if ((dwRetVal =3D GetNetworkParams(pFixedInfo, & ulOutBufLen))) {
     DPRINTF(debug, "GetNetworkParams: error %lu (Windows)\n", dwRetVal);
     goto use_registry;
   }

--=====================_1166172318==_--


