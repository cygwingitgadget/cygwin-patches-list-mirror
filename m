From: Earnie Boyd <earnie_boyd@yahoo.com>
To: cygwin-patches@cygwin.com
Subject: config/i386/cygwin.h Use msvcrt for -mno-cygwin
Date: Wed, 10 Jan 2001 12:54:00 -0000
Message-id: <3A5CCC11.9CF6AC25@yahoo.com>
X-SW-Source: 2001-q1/msg00024.html

Here are the necessary changes to use MSVCRT instead of CRTDLL for the
-mno-cygwin switch.

Cheers,
Earnie
Wed Jan 10 13:48:22  2001  Earnie Boyd  <earnie_boyd@yahoo.com>

	* config/i386/cygwin.h: Use MSVCRT instead of CRTDLL for -mno-cygwin.
	Make the WIN32 definitions match between !mno-cygwin and mno-cygwin.


--- cygwin.h.orig	Wed Jan 10 13:41:14 2001
+++ cygwin.h	Wed Jan 10 13:57:37 2001
@@ -79,13 +79,13 @@ Boston, MA 02111-1307, USA. */
    by calling the init function from the prologue. */
 
 #undef LIBGCC_SPEC
-#define LIBGCC_SPEC "%{mno-cygwin: %{mthreads:-lmingwthrd} -lmingw32} -lgcc %{mno-cygwin:-lmoldname -lcrtdll}"
+#define LIBGCC_SPEC "%{mno-cygwin: %{mthreads:-lmingwthrd} -lmingw32} -lgcc %{mno-cygwin:-lmoldname -lmsvcrt}"
 
 #define LINKER_NAME "collect2"
 
 #undef STARTFILE_SPEC
-#define STARTFILE_SPEC "%{shared|mdll: %{mno-cygwin:dllcrt1%O%s}} \
-  %{!shared: %{!mdll: %{!mno-cygwin:crt0%O%s} %{mno-cygwin:-L/usr/local/lib/mingw -L/usr/lib/mingw crt1%O%s} \
+#define STARTFILE_SPEC "%{shared|mdll: %{mno-cygwin:dllcrt2%O%s}} \
+  %{!shared: %{!mdll: %{!mno-cygwin:crt0%O%s} %{mno-cygwin:-L/usr/local/lib/mingw -L/usr/lib/mingw crt2%O%s} \
   %{pg:gcrt0%O%s}}}"
 
 #undef CPP_SPEC
@@ -94,7 +94,8 @@ Boston, MA 02111-1307, USA. */
     -isystem /usr/local/include \
     -idirafter /usr/include} \
   %{mno-win32: %{mno-cygwin: %emno-cygwin and mno-win32 are not compatible}} \
-  %{mno-cygwin:-DWIN32 -D__WIN32__ -D__MINGW32__=0.2 \
+  %{mno-cygwin:-DWIN32 -D_WIN32 -D__WIN32 -D__WIN32__ -DWINNT \
+    -D__MINGW32__=0.3 -D__MSVCRT__ \
     %{mthreads:-D_MT} \
     -isystem /usr/local/include/mingw \
     -idirafter /usr/include/mingw \
@@ -102,7 +103,8 @@ Boston, MA 02111-1307, USA. */
     -iwithprefixbefore ../../../../mingw/include \
     -iwithprefixbefore ../../../../mingw32/include/g++-3 \
     -iwithprefixbefore ../../../../mingw32/include } \
-  %{!mno-win32:-D_WIN32 -DWINNT -idirafter /usr/include/w32api}"
+  %{!mno-win32:-DWIN32 -D_WIN32 -D__WIN32 -D__WIN32__ -DWINNT \
+    -idirafter /usr/include/w32api}"
 
 /* This macro defines names of additional specifications to put in the specs
    that can be used in various specifications like CC1_SPEC.  Its definition
