From: Corinna Vinschen <corinna@vinschen.de>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: cross compiling patches
Date: Wed, 29 Mar 2000 15:13:00 -0000
Message-id: <38E28DBD.CD799CC1@vinschen.de>
X-SW-Source: 2000-q1/msg00017.html

Hi Chris,

just to be sure, I sent the patches I made for being able to cross
compile on my linux box. If you agree, I will commit them. I have
changed them according to your latest advice.

One remaining (and yet uncommented) problem is that the second level
directories
 - libiberty
 - include
of our cvs repository are not compatible to the current state of
the net release preview. I think it's due to the fact that
binutils in the repository is a 199909.. version while the net
release binutils is the 19990818-1 version.

I only want let this as an aid to memory.

Corinna
Index: ChangeLog
===================================================================
RCS file: /cvs/src/src/ChangeLog,v
retrieving revision 1.32
diff -u -p -r1.32 ChangeLog
--- ChangeLog	2000/03/10 21:21:16	1.32
+++ ChangeLog	2000/03/29 22:55:24
@@ -1,3 +1,8 @@
+Thu Mar 30 00:44:00 2000  Corinna Vinschen <corinna@vinschen.de>
+
+	* Makefile.in: Add winsup lib and include paths to CC_FOR_TARGET
+	and CXX_FOR_TARGET.
+
 2000-03-10  H.J. Lu  <hjl@gnu.org>
 
 	* Makefile.in (all-gcc): Backed out the last change.
Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/Makefile.in,v
retrieving revision 1.11
diff -u -p -r1.11 Makefile.in
--- Makefile.in	2000/03/10 21:21:16	1.11
+++ Makefile.in	2000/03/29 22:55:25
@@ -215,7 +215,7 @@ CC_FOR_TARGET = ` \
     if [ -f $$r/$(TARGET_SUBDIR)/newlib/Makefile ] ; then \
       case "$(target_canonical)" in \
         i[3456]86-*-cygwin*) \
-          echo $$r/gcc/xgcc -B$$r/gcc/ -B$$r/$(TARGET_SUBDIR)/newlib/ -L$$r/$(TARGET_SUBDIR)/winsup -idirafter $$r/$(TARGET_SUBDIR)/newlib/targ-include -idirafter $$s/winsup/include -idirafter $$s/newlib/libc/include -idirafter $$s/newlib/libc/sys/cygwin -idirafter $$s/newlib/libc/sys/cygwin32 -nostdinc; \
+          echo $$r/gcc/xgcc -B$$r/gcc/ -B$$r/$(TARGET_SUBDIR)/newlib/ -L$$r/$(TARGET_SUBDIR)/winsup -L$$r/$(TARGET_SUBDIR)/winsup/w32api/lib -idirafter $$r/$(TARGET_SUBDIR)/newlib/targ-include -idirafter $$s/winsup/include -idirafter $$s/winsup/cygwin/include -idirafter $$s/winsup/w32api/include -idirafter $$s/newlib/libc/include -idirafter $$s/newlib/libc/sys/cygwin -idirafter $$s/newlib/libc/sys/cygwin32 -nostdinc; \
           ;; \
         *) \
           echo $$r/gcc/xgcc -B$$r/gcc/ -idirafter $$r/$(TARGET_SUBDIR)/newlib/targ-include -idirafter $$s/newlib/libc/include -nostdinc; \
@@ -254,7 +254,7 @@ CXX_FOR_TARGET = ` \
     if [ -f $$r/$(TARGET_SUBDIR)/newlib/Makefile ] ; then \
       case "$(target_canonical)" in \
         i[3456]86-*-cygwin*) \
-          echo $$r/gcc/xgcc -B$$r/gcc/ -B$$r/$(TARGET_SUBDIR)/newlib/ -L$$r/$(TARGET_SUBDIR)/winsup -idirafter $$r/$(TARGET_SUBDIR)/newlib/targ-include -idirafter $$s/winsup/include -idirafter $$s/newlib/libc/include -idirafter $$s/newlib/libc/sys/cygwin -idirafter $$s/newlib/libc/sys/cygwin32 -nostdinc; \
+          echo $$r/gcc/xgcc -B$$r/gcc/ -B$$r/$(TARGET_SUBDIR)/newlib/ -L$$r/$(TARGET_SUBDIR)/winsup -L$$r/$(TARGET_SUBDIR)/winsup/w32api/lib -idirafter $$r/$(TARGET_SUBDIR)/newlib/targ-include -idirafter $$s/winsup/include -idirafter $$s/winsup/cygwin/include -idirafter $$s/winsup/w32api/include -idirafter $$s/newlib/libc/include -idirafter $$s/newlib/libc/sys/cygwin -idirafter $$s/newlib/libc/sys/cygwin32 -nostdinc; \
           ;; \
         *) \
           echo $$r/gcc/xgcc -B$$r/gcc/ -idirafter $$r/$(TARGET_SUBDIR)/newlib/targ-include -idirafter $$s/newlib/libc/include -nostdinc; \
Index: winsup/cygwin/ChangeLog
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/ChangeLog,v
retrieving revision 1.41
diff -u -p -r1.41 ChangeLog
--- ChangeLog	2000/03/28 21:49:16	1.41
+++ ChangeLog	2000/03/29 22:55:28
@@ -1,3 +1,7 @@
+Thu Mar 30 00:44:00 2000  Corinna Vinschen <corinna@vinschen.de>
+
+	* Makefile.in: Substitute CC by COMPILE_CC in cygrun.exe rule.
+
 Tue Mar 28 16:45:42 2000  Christopher Faylor <cgf@cygnus.com>
 
 	* Makefile.in: Use default rules when compiling cygrun.o.
Index: winsup/cygwin/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/Makefile.in,v
retrieving revision 1.4
diff -u -p -r1.4 Makefile.in
--- Makefile.in	2000/03/28 21:49:16	1.4
+++ Makefile.in	2000/03/29 22:55:28
@@ -195,7 +195,7 @@ winver_stamp: mkvers.sh include/cygwin/v
 
 cygrun.exe : cygrun.o $(DLL_IMPORTS) $(w32api_lib)/libuser32.a \
 	     $(w32api_lib)/libshell32.a
-	$(CC) -o $@ -L$(w32api_lib) ${word 1,$^}
+	$(COMPILE_CC) -o $@ -L$(w32api_lib) ${word 1,$^}
 
 #
 
Index: winsup/mingw/ChangeLog
===================================================================
RCS file: /cvs/src/src/winsup/mingw/ChangeLog,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 ChangeLog
--- ChangeLog	2000/02/17 19:38:31	1.1.1.1
+++ ChangeLog	2000/03/29 22:55:29
@@ -1,3 +1,7 @@
+Thu Mar 30 00:44:00 2000  Corinna Vinschen <corinna@vinschen.de>
+
+	* Makefile.in: Add dummy entry to SUBDIRS.
+
 2000-02-03  Mumit Khan  <khan@xraylith.wisc.edu>
 
 	* Snapshot 2000-02-03.
Index: winsup/mingw/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/mingw/Makefile.in,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 Makefile.in
--- Makefile.in	2000/02/17 19:38:31	1.1.1.1
+++ Makefile.in	2000/03/29 22:55:29
@@ -85,7 +85,7 @@ DLLWRAP = @DLLWRAP@
 DLLWRAP_FOR_TARGET = $(DLLWRAP)
 DLLWRAP_FLAGS = --dlltool $(DLLTOOL) --as $(AS) --driver-name $(CC)
 
-SUBDIRS := @SUBDIRS@
+SUBDIRS := @SUBDIRS@ dummy
 
 FLAGS_TO_PASS:=\
 	AS="$(AS)" \
