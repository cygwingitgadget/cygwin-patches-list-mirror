From: Vadim Egorov <egorovv@mailandnews.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: inet_network
Date: Tue, 18 Apr 2000 21:47:00 -0000
Message-id: <uu2gy8zps.fsf@mailandnews.com>
X-SW-Source: 2000-q2/msg00009.html

Hello,

Occasionally (building Apache) I found that though <arpa/inet.h> declares 
inet_network, it is not implemented. 

Here is my proposal which makes use of an undocumented wsock32.dll entry.

-- 
Regards,
Vadim Egorov 


Index: net.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/net.cc,v
retrieving revision 1.3
diff -c -r1.3 net.cc
*** net.cc	2000/02/23 04:07:13	1.3
--- net.cc	2000/04/19 04:30:45
***************
*** 127,132 ****
--- 127,143 ----
    return res;
  }
  
+ /* undocumented in wsock32.dll */
+ extern "C" unsigned int	 inet_network (const char *);
+ 
+ extern "C"
+ unsigned int 
+ cygwin_inet_network (const char *cp)
+ {
+   unsigned int res = inet_network (cp);
+   return res;
+ }
+ 
  /* inet_netof is in the standard BSD sockets library.  It is useless
     for modern networks, since it assumes network values which are no
     longer meaningful, but some existing code calls it.  */
***************
*** 1811,1816 ****
--- 1822,1828 ----
  LoadDLLfunc (getsockname, getsockname@12, wsock32)
  LoadDLLfunc (getsockopt, getsockopt@20, wsock32)
  LoadDLLfunc (inet_addr, inet_addr@4, wsock32)
+ LoadDLLfunc (inet_network, inet_network@4, wsock32)
  LoadDLLfunc (inet_ntoa, inet_ntoa@4, wsock32)
  LoadDLLfunc (ioctlsocket, ioctlsocket@12, wsock32)
  LoadDLLfunc (listen, listen@8, wsock32)
Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.5
diff -c -r1.5 cygwin.din
*** cygwin.din	2000/04/13 06:53:23	1.5
--- cygwin.din	2000/04/19 04:29:58
***************
*** 919,924 ****
--- 919,925 ----
  connect = cygwin_connect
  herror = cygwin_herror
  inet_addr = cygwin_inet_addr
+ inet_network = cygwin_inet_network
  inet_netof
  inet_makeaddr
  listen = cygwin_listen

