From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: [PATCH] Throttle fork_copy on Windows 9x
Date: Sun, 26 Mar 2000 14:55:00 -0000
Message-id: <20000326175458.A1082@cygnus.com>
X-SW-Source: 2000-q1/msg00016.html

I've appended the following patch after a net user indicated that it solved
a problem where fork_copy was taking an inordinately long time on Windows 98.

I can't say that I understand it but I'm not surprised the Windows 9x doesn't
like copying large amounts of memory between processes.

cgf

Sun Mar 26 17:52:09 2000  Christopher Faylor <cgf@cygnus.com>

        * dcrt0.cc (host_dependent_constants::init): Limit non-NT platforms to
        32K chunks when copying regions during a fork.

Index: dcrt0.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dcrt0.cc,v
retrieving revision 1.6
diff -u -p -r1.6 dcrt0.cc
--- dcrt0.cc	2000/03/25 05:25:27	1.6
+++ dcrt0.cc	2000/03/26 22:54:37
@@ -151,6 +151,7 @@ host_dependent_constants NO_COPY host_de
 void
 host_dependent_constants::init ()
 {
+  extern DWORD chunksize;
   /* fhandler_disk_file::lock needs a platform specific upper word
      value for locking entire files.
 
@@ -169,6 +170,7 @@ host_dependent_constants::init ()
     case win32s:
       win32_upper = 0x00000000;
       shared = FILE_SHARE_READ | FILE_SHARE_WRITE;
+      chunksize = 32 * 1024 * 1024;
       break;
 
     default:
