From: Mumit Khan <khan@NanoTech.Wisc.EDU>
To: cygwin-patches@sourceware.cygnus.com
Subject: (patch) inet header tweak
Date: Fri, 12 May 2000 16:06:00 -0000
Message-id: <200005122306.SAA05340@pluto.xraylith.wisc.edu>
X-SW-Source: 2000-q2/msg00055.html

Change to in.h is self-explanatory. The change to socket.h adds IPv6 
protocol and address family numbers for future, and also bumps up
AF_MAX and PF_MAX to 32 for future expansion (I believe the numbers
are already up to 24 for most systems, and systems like Linux tend
to have 32 as the ceiling for now).

2000-05-12  Mumit Khan  <khan@xraylith.wisc.edu>

	* include/cygwin/in.h (struct in6_addr): Fix spelling.
	* include/cygwin/socket.h (AF_INET6, PF_INET6): Define macros.
	(AF_MAX, PF_MAX): Bump to 32.

Index: include/cygwin/in.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/in.h,v
retrieving revision 1.1.1.1
diff -u -3 -p -r1.1.1.1 in.h
--- in.h	2000/02/17 19:38:31	1.1.1.1
+++ in.h	2000/05/12 23:01:56
@@ -172,7 +172,7 @@ struct sockaddr_in {
  *	a beginning dont get excited 8)
  */
  
-struct in_addr6
+struct in6_addr
 {
 	unsigned char s6_addr[16];
 };
Index: include/cygwin/socket.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/socket.h,v
retrieving revision 1.1.1.1
diff -u -3 -p -r1.1.1.1 socket.h
--- socket.h	2000/02/17 19:38:31	1.1.1.1
+++ socket.h	2000/05/12 23:01:56
@@ -66,8 +66,9 @@ struct msghdr 
 #define AF_HYLINK       15              /* NSC Hyperchannel */
 #define AF_APPLETALK    16              /* AppleTalk */
 #define AF_NETBIOS      17              /* NetBios-style addresses */
+#define AF_INET6        18              /* IP version 6 */
 
-#define AF_MAX          18
+#define AF_MAX          32
 /*
  * Protocol families, same as address families for now.
  */
@@ -91,6 +92,7 @@ struct msghdr 
 #define PF_HYLINK       AF_HYLINK
 #define PF_APPLETALK    AF_APPLETALK
 #define PF_NETBIOS      AF_NETBIOS
+#define PF_INET6        AF_INET6
 
 #define PF_MAX          AF_MAX
 
