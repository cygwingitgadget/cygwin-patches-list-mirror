From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Revert lib/Makefile.in to functional version
Date: Thu, 20 Dec 2001 20:41:00 -0000
Message-ID: <20011221044100.GA10296@redhat.com>
X-SW-Source: 2001-q4/msg00346.html
Message-ID: <20011220204100.dmVTlVaJoeN8XSJolkg3s2TGWy-lvFPyG0WdSuN9Cb4@z>

The patch below reverts erroneous sections of lib/Makefile.in to
functionality.

We've gone back and forth about this section of code for a while.  The
bottom line is that it did not do the right thing for cross toolchains.
This has caused me much grief within Red Hat so I need to change this on
sourceware.  If I don't do this, I will have to complicate my
sourceware->red hat merge script unnecessarily to accomodate what is
essentially breakage on sourceware.

If I understood the rationale for the previous Makefile.in behavior, I
would attempt to accomodate it and fix it for people who want to build
cross toolchains.  Since I don't, I have reverted it.

I would appreciate it if this section of the Makefile remain as is
unless any change is specifically tested in a native and cross
compilation environment.

Thanks,
cgf

2001-12-20  Christopher Faylor  <cgf@redhat.com>

	* lib/Makefile.in: Revert inst_installdir definitions to working
	versions.

Index: lib/Makefile.in
===================================================================
RCS file: /cvs/uberbaum/winsup/w32api/lib/Makefile.in,v
retrieving revision 1.18
diff -u -p -r1.18 Makefile.in
--- Makefile.in	2001/11/04 20:38:00	1.18
+++ Makefile.in	2001/12/21 04:35:09
@@ -19,7 +19,6 @@ host_alias = @host_alias@
 build_alias = @build_alias@
 target_alias = @target_alias@
 prefix = @prefix@
-config_prefix = @prefix@
 includedir:=@includedir@
 
 program_transform_name = @program_transform_name@
@@ -37,22 +36,9 @@ tooldir:=$(exec_prefix)/$(target_alias)
 endif
 datadir = @datadir@
 infodir = @infodir@
-#FIXME.  The inst_includedir and inst_libdir need to be modified to use
-#$(tooldir)/usr/include/w32api and $(tooldir)/usr/lib/w32api for the dist 
-#targets.
 ifneq (,$(findstring cygwin,$(target_alias)))
-ifeq ($(build_alias),$(host_alias))
-ifeq ($(prefix),$(config_prefix))
-inst_includedir:=$(tooldir)/include/w32api
-inst_libdir:=$(tooldir)/lib/w32api
-else
 inst_includedir:=$(tooldir)/include/w32api
 inst_libdir:=$(tooldir)/lib/w32api
-endif
-else
-inst_includedir:=$(includedir)
-inst_libdir:=$(libdir)
-endif
 else
 inst_includedir:=$(includedir)
 inst_libdir:=$(libdir)
