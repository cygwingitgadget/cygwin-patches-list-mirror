From: Corinna Vinschen <corinna@vinschen.de>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>, Mumit Khan <khan@NanoTech.Wisc.EDU>
Subject: Re: cross compiling patches
Date: Thu, 30 Mar 2000 15:00:00 -0000
Message-id: <38E3D5F2.15B2E3A0@vinschen.de>
References: <200003300046.SAA27482@hp2.xraylith.wisc.edu> <38E30C2A.7B962DE8@vinschen.de>
X-SW-Source: 2000-q1/msg00025.html

Corinna Vinschen wrote:
> 
> Mumit Khan wrote:
> >
> > Chris Faylor <cgf@cygnus.com> writes:
> > >
> > > On thinking about this a little, it seems that the only changes that
> > > need to be made are in mingw.  Mingw needs the header files and libraries
> > > from winsup/w32api but no other directories should need this.  So, I think
> > > that changing the top-level Makefile is not right.  Can we change the mingw
> > > Makefile instead?
> 
> I wonder if there is another trap waiting in this case but let's see. I
> will
> try it today.

Ok, I have checked this out and it's not enough to change only the mingw
Makefile.in:

- In the top level Makefile.in the path to $$s/winsup/cygwin/include is
  needed to compile libiberty. It's missing `io.h' else. I wouldn't
change
  this in the libiberty/Makefile.in because of the current version
problem.
- In winsup/cygwin/Makefile.in `cygrun.exe' has to be compiled with
  $(COMPILE_CC) because the linker stage results in the error
  `-lcygwin not found.' 

> > > I don't know about the dummy change.  It seems ok to me but I'd like to get
> > > Mumit's ok in case he has some other way in mind.
> >
> > I haven't run into this problem, so I'll look into this tonight after I
> > update my local tree. I have no problem changing mingw Makefiles or the
> > configuration files, but let me find out what the real problem is first.

I have included the `dummy' patch for winsup/mingw/Makefile.in once
more.
Mumit, did you had a chance to look into it?

> The problem is the `subdirs' rule in Makefile.in:
> [...]

Corinna
Index: ChangeLog
===================================================================
RCS file: /cvs/src/src/ChangeLog,v
retrieving revision 1.33
diff -u -p -r1.33 ChangeLog
--- ChangeLog	2000/03/30 02:19:55	1.33
+++ ChangeLog	2000/03/30 22:29:15
@@ -1,3 +1,8 @@
+Thu Mar 30 20:28:00 2000  Corinna Vinschen <corinna@vinschen.de>
+
+	* Makefile.in: Add cygwin lib and include paths to CC_FOR_TARGET
+	and CXX_FOR_TARGET.
+
 2000-03-29  Jason Merrill  <jason@casey.cygnus.com>
 
 	* configure.in: -linux-gnu*, not -linux-gnu.
Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/Makefile.in,v
retrieving revision 1.11
diff -u -p -r1.11 Makefile.in
--- Makefile.in	2000/03/10 21:21:16	1.11
+++ Makefile.in	2000/03/30 22:29:16
@@ -215,7 +215,7 @@ CC_FOR_TARGET = ` \
     if [ -f $$r/$(TARGET_SUBDIR)/newlib/Makefile ] ; then \
       case "$(target_canonical)" in \
         i[3456]86-*-cygwin*) \
-          echo $$r/gcc/xgcc -B$$r/gcc/ -B$$r/$(TARGET_SUBDIR)/newlib/ -L$$r/$(TARGET_SUBDIR)/winsup -idirafter $$r/$(TARGET_SUBDIR)/newlib/targ-include -idirafter $$s/winsup/include -idirafter $$s/newlib/libc/include -idirafter $$s/newlib/libc/sys/cygwin -idirafter $$s/newlib/libc/sys/cygwin32 -nostdinc; \
+          echo $$r/gcc/xgcc -B$$r/gcc/ -B$$r/$(TARGET_SUBDIR)/newlib/ -L$$r/$(TARGET_SUBDIR)/winsup -idirafter $$r/$(TARGET_SUBDIR)/newlib/targ-include -idirafter $$s/winsup/include -idirafter $$s/winsup/cygwin/include -idirafter $$s/newlib/libc/include -idirafter $$s/newlib/libc/sys/cygwin -idirafter $$s/newlib/libc/sys/cygwin32 -nostdinc; \
           ;; \
         *) \
           echo $$r/gcc/xgcc -B$$r/gcc/ -idirafter $$r/$(TARGET_SUBDIR)/newlib/targ-include -idirafter $$s/newlib/libc/include -nostdinc; \
@@ -254,7 +254,7 @@ CXX_FOR_TARGET = ` \
     if [ -f $$r/$(TARGET_SUBDIR)/newlib/Makefile ] ; then \
       case "$(target_canonical)" in \
         i[3456]86-*-cygwin*) \
-          echo $$r/gcc/xgcc -B$$r/gcc/ -B$$r/$(TARGET_SUBDIR)/newlib/ -L$$r/$(TARGET_SUBDIR)/winsup -idirafter $$r/$(TARGET_SUBDIR)/newlib/targ-include -idirafter $$s/winsup/include -idirafter $$s/newlib/libc/include -idirafter $$s/newlib/libc/sys/cygwin -idirafter $$s/newlib/libc/sys/cygwin32 -nostdinc; \
+          echo $$r/gcc/xgcc -B$$r/gcc/ -B$$r/$(TARGET_SUBDIR)/newlib/ -L$$r/$(TARGET_SUBDIR)/winsup -idirafter $$r/$(TARGET_SUBDIR)/newlib/targ-include -idirafter $$s/winsup/include -idirafter $$s/winsup/cygwin/include -idirafter $$s/newlib/libc/include -idirafter $$s/newlib/libc/sys/cygwin -idirafter $$s/newlib/libc/sys/cygwin32 -nostdinc; \
           ;; \
         *) \
           echo $$r/gcc/xgcc -B$$r/gcc/ -idirafter $$r/$(TARGET_SUBDIR)/newlib/targ-include -idirafter $$s/newlib/libc/include -nostdinc; \
Index: winsup/cygwin/ChangeLog
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/ChangeLog,v
retrieving revision 1.42
diff -u -p -r1.42 ChangeLog
--- ChangeLog	2000/03/30 03:51:30	1.42
+++ ChangeLog	2000/03/30 22:29:19
@@ -1,3 +1,7 @@
+Thu Mar 30 23:51:00 2000  Corinna Vinschen <corinna@vinschen.de>
+
+	* Makefile.in: Substitute CC by COMPILE_CC in cygrun.exe rule.
+
 Wed Mar 29 22:49:56 2000  Christopher Faylor <cgf@cygnus.com>
 
 	* fhandler.h (select_record): Explicitly zero elements of this class.
Index: winsup/cygwin/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/Makefile.in,v
retrieving revision 1.4
diff -u -p -r1.4 Makefile.in
--- Makefile.in	2000/03/28 21:49:16	1.4
+++ Makefile.in	2000/03/30 22:29:19
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
+++ ChangeLog	2000/03/30 22:29:20
@@ -1,3 +1,8 @@
+Thu Mar 30 00:44:00 2000  Corinna Vinschen <corinna@vinschen.de>
+
+	* Makefile.in: Add dummy entry to SUBDIRS.
+	Add link path to winsup/w32api/lib to DLL_CC_STUFF.
+
 2000-02-03  Mumit Khan  <khan@xraylith.wisc.edu>
 
 	* Snapshot 2000-02-03.
Index: winsup/mingw/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/mingw/Makefile.in,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 Makefile.in
--- Makefile.in	2000/02/17 19:38:31	1.1.1.1
+++ Makefile.in	2000/03/30 22:29:21
@@ -85,7 +85,7 @@ DLLWRAP = @DLLWRAP@
 DLLWRAP_FOR_TARGET = $(DLLWRAP)
 DLLWRAP_FLAGS = --dlltool $(DLLTOOL) --as $(AS) --driver-name $(CC)
 
-SUBDIRS := @SUBDIRS@
+SUBDIRS := @SUBDIRS@ dummy
 
 FLAGS_TO_PASS:=\
 	AS="$(AS)" \
@@ -137,6 +137,7 @@ xx_$(THREAD_DLL_NAME) xx_mingwthrd.def: 
 DLL_OFILES        = mthr.o mthr_init.o
 DLL_CC_STUFF      = -B./ -mdll $(MNO_CYGWIN) -Wl,--image-base,0x6FBC0000 \
 		    -Wl,--entry,_DllMainCRTStartup@12 \
+		    -L$(objdir)/../w32api/lib \
                     $(DLL_OFILES)
 DLL_DLLTOOL_STUFF = --as=$(AS) --dllname $(THREAD_DLL_NAME) \
                     --def mingwthrd.def \
