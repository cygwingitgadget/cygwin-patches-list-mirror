From: DJ Delorie <dj@redhat.com>
To: mingw-patches@lists.sourceforge.net, cygwin-patches@cygwin.com
Subject: winnt.h: VOID already defined
Date: Thu, 05 Jul 2001 13:29:00 -0000
Message-id: <200107052028.QAA18173@greed.delorie.com>
X-SW-Source: 2001-q3/msg00001.html

If I try to cross-build a native cygwin expect under linux, tcl's
headers already define VOID to void, and thus winnt.h is missing a
number of important typedefs.  This patch seems to fix it, but I'm
worried that this just hides a true problem elsewhere.

Index: winnt.h
===================================================================
RCS file: /cvs/uberbaum/winsup/w32api/include/winnt.h,v
retrieving revision 1.22
diff -p -3 -r1.22 winnt.h
*** winnt.h     2001/05/17 21:13:10     1.22
--- winnt.h     2001/07/05 20:07:35
*************** extern "C" {
*** 41,50 ****
  
  #ifndef VOID
  #define VOID void
  typedef char CHAR;
  typedef short SHORT;
  typedef long LONG;
- #endif
  typedef CHAR CCHAR;
  typedef unsigned char UCHAR,*PUCHAR;
  typedef unsigned short USHORT,*PUSHORT;
--- 41,50 ----
  
  #ifndef VOID
  #define VOID void
+ #endif
  typedef char CHAR;
  typedef short SHORT;
  typedef long LONG;
  typedef CHAR CCHAR;
  typedef unsigned char UCHAR,*PUCHAR;
  typedef unsigned short USHORT,*PUSHORT;
