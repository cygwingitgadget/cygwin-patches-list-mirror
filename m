From: DJ Delorie <dj@delorie.com>
To: cygwin-patches@sourceware.cygnus.com
Cc: khan@xraylith.wisc.edu
Subject: shlobj.h patch
Date: Tue, 11 Jul 2000 10:33:00 -0000
Message-id: <200007111733.NAA02079@envy.delorie.com>
X-SW-Source: 2000-q3/msg00010.html

I've committed this (Mumit take note):

Index: ChangeLog
===================================================================
RCS file: /cvs/src/src/winsup/w32api/ChangeLog,v
retrieving revision 1.21
diff -p -2 -r1.21 ChangeLog
*** ChangeLog	2000/06/27 18:21:31	1.21
--- ChangeLog	2000/07/11 17:21:11
***************
*** 1,2 ****
--- 1,6 ----
+ 2000-07-11  DJ Delorie  <dj@cygnus.com>
+ 
+ 	* include/shlobj.h: add CSIDL_COMMON_*
+ 
  Tue Jun 27 19:35:00 2000  Corinna Vinschen <corinna@vinschen.de>
  
Index: include/shlobj.h
===================================================================
RCS file: /cvs/src/src/winsup/w32api/include/shlobj.h,v
retrieving revision 1.3
diff -p -2 -r1.3 shlobj.h
*** shlobj.h	2000/04/25 19:13:51	1.3
--- shlobj.h	2000/07/11 17:21:11
*************** extern "C" {
*** 127,130 ****
--- 127,136 ----
  #define CSIDL_FONTS	20
  #define CSIDL_TEMPLATES	21
+ #define CSIDL_COMMON_STARTMENU	22
+ #define CSIDL_COMMON_PROGRAMS	23
+ #define CSIDL_COMMON_STARTUP	24
+ #define CSIDL_COMMON_DESKTOPDIRECTORY	25
+ #define CSIDL_COMMON_ALTSTARTUP	30
+ #define CSIDL_COMMON_FAVORITES	31
  #define CFSTR_SHELLIDLIST	"Shell IDList Array"
  #define CFSTR_SHELLIDLISTOFFSET	"Shell Object Offsets"
