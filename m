From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sourceware.cygnus.com, Mumit Khan <khan@xraylith.wisc.EDU>
Subject: [PATCH] fix duplicate typedefs in winnt.h
Date: Sun, 26 Mar 2000 10:45:00 -0000
Message-id: <20000326134520.A16419@cygnus.com>
X-SW-Source: 2000-q1/msg00014.html

I just noticed that I was getting warnings when compiling Windows CE
executables, so I made the following changes.

Mumit, how do you want to handle this kind of change?  Do you want
people just go ahead and check things in if they are relatively simple
and "make sense" or do you want to approve every patch?

Either way is ok with me.

cgf

Sun Mar 26 13:41:47 2000  Christopher Faylor <cgf@cygnus.com>

	* include/winnt.h: Eliminate duplicate PCONTEXT and LPCONTEXT typedefs.


Index: include/winnt.h
===================================================================
RCS file: /cvs/src/src/winsup/w32api/include/winnt.h,v
retrieving revision 1.3
diff -u -p -r1.3 winnt.h
--- winnt.h	2000/02/29 03:16:14	1.3
+++ winnt.h	2000/03/26 18:42:31
@@ -1150,7 +1150,7 @@ typedef struct _CONTEXT {
 	DWORD Psr;
 	DWORD ContextFlags;
 	DWORD Fill[4];
-} CONTEXT, *PCONTEXT;
+} CONTEXT;
 #elif defined(SHx)
 
 /* These are the debug or break registers on the SH3 */
@@ -1261,7 +1261,7 @@ typedef struct _CONTEXT {
 	ULONG	xFRegs[16];
 #endif
 #endif
-} CONTEXT,*PCONTEXT,*LPCONTEXT;
+} CONTEXT;
 
 #elif defined(MIPS)
 
@@ -1410,7 +1410,7 @@ typedef struct _CONTEXT {
 
     DWORD Fill[2];
 
-} CONTEXT,*PCONTEXT,*LPCONTEXT;
+} CONTEXT;
 #elif defined(ARM)
 //
 // The following flags control the contents of the CONTEXT structure.
@@ -1461,7 +1461,7 @@ typedef struct _CONTEXT {
     ULONG Lr;
     ULONG Pc;
     ULONG Psr;
-} CONTEXT, *PCONTEXT;
+} CONTEXT;
 
 #else
 #error "undefined processor type"
