Return-Path: <cygwin-patches-return-6515-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15701 invoked by alias); 18 Apr 2009 13:43:06 -0000
Received: (qmail 15687 invoked by uid 22791); 18 Apr 2009 13:43:05 -0000
X-SWARE-Spam-Status: No, hits=-2.2 required=5.0 	tests=AWL,BAYES_00,HK_OBFDOM,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from ey-out-1920.google.com (HELO ey-out-1920.google.com) (74.125.78.144)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 18 Apr 2009 13:43:00 +0000
Received: by ey-out-1920.google.com with SMTP id 5so358146eyb.20         for <cygwin-patches@cygwin.com>; Sat, 18 Apr 2009 06:42:57 -0700 (PDT)
Received: by 10.210.10.8 with SMTP id 8mr1751403ebj.49.1240062177299;         Sat, 18 Apr 2009 06:42:57 -0700 (PDT)
Received: from ?82.6.108.62? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 5sm5029612eyh.31.2009.04.18.06.42.56         (version=SSLv3 cipher=RC4-MD5);         Sat, 18 Apr 2009 06:42:56 -0700 (PDT)
Message-ID: <49E9DB61.2040506@gmail.com>
Date: Sat, 18 Apr 2009 13:43:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: The Return of Revenge of Son of the Speclib Strikes Back :)
Content-Type: multipart/mixed;  boundary="------------060501080500020006060205"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q2/txt/msg00057.txt.bz2

This is a multi-part message in MIME format.
--------------060501080500020006060205
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 2051

[ Let's try again in the right place, shall we? ]

  The new speclibs libraries work great, but there's one piece of
unanticipated fallout: the libtool func_win32_libid() tests can no longer
identify them as import libraries.  Which is fair enough, since they aren't,
they are now indirect references to import libraries; but we want it to treat
them the same anyway.

  Here's one possible approach: I add a dummy member to the archives just in
order to trip libtool's "nm | grep ' I '" test.  I repurposed the
as-far-as-I-can-tell currently unused "--static" option to speclib to mean
"bodily shove this object into the generated library".

  As usual, I don't speak perl good, which is why I add $static to the
%extract hash before invoking ar and remove it again afterward.  If I just
unconditionally tagged ", $static" on the end of the invocation, it would fail
if no --static option was supplied, giving ar an empty string as an argv
member, and I didn't know how to conditionally add it as an argument only when
defined, so it was either this or cut-and-paste two versions of the
invocation, one mentioning $static and the other not, with an if defined
$static to choose between them; I would welcome being shown a better way to do
this if there is one.

  I'm currently putting the attached through a full build / install/ rebuild
DLL, binutils and gcc cycle, but it already fixed the failure to build libjava
as a DLL that I've been getting on GCC HEAD with the new speclib libraries.

  What do you think?  Reasonable approach?  Reasonable implementation?
Problems with either?  Ok for head?

winsup/cygwin/ChangeLog

	* magicimportsym.s:  New file.
	* Makefile.in (speclib):  Add --static option to invocation
	naming magicimportsym.o
	(${CURDIR}/libc.a):  Add magicimportsym.o to dependencies.
	(${CURDIR}/libm.a):  Likewise.
	(libpthread.a):  Likewise.
	(libutil.a):  Likewise.
	(libdl.a):  Likewise.
	(libresolv.a):  Likewise.
	* speclib:  Repurpose --static option to add an archive member
	unconditionally.

    cheers,
      DaveK



--------------060501080500020006060205
Content-Type: text/x-c;
 name="magic-import-symbol-patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="magic-import-symbol-patch.diff"
Content-length: 3533

Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/Makefile.in,v
retrieving revision 1.225
diff -p -u -r1.225 Makefile.in
--- Makefile.in	12 Apr 2009 04:14:31 -0000	1.225
+++ Makefile.in	18 Apr 2009 13:33:03 -0000
@@ -112,6 +112,7 @@ speclib=\
 	--exclude='(?i:dll)' \
 	--exclude='reloc' \
 	--exclude='^_main$$' \
+	--static=magicimportsym.o \
 	$^
 
 # Some things want these from libc, but they have their own static
@@ -439,22 +440,22 @@ shared.o: shared_info_magic.h
 $(srcdir)/devices.cc: gendevices devices.in devices.h
 	${wordlist 1,2,$^} $@
 
-${CURDIR}/libc.a: ${LIB_NAME} ./libm.a libpthread.a libutil.a
+${CURDIR}/libc.a: ${LIB_NAME} ./libm.a libpthread.a libutil.a magicimportsym.o
 	${speclib} -v ${@F}
 
-${CURDIR}/libm.a: ${LIB_NAME} $(LIBM)
+${CURDIR}/libm.a: ${LIB_NAME} $(LIBM) magicimportsym.o
 	${speclib} ${@F}
 
-libpthread.a: ${LIB_NAME} pthread.o thread.o
+libpthread.a: ${LIB_NAME} pthread.o thread.o magicimportsym.o
 	${speclib} ${@F}
 
-libutil.a: ${LIB_NAME} bsdlib.o
+libutil.a: ${LIB_NAME} bsdlib.o magicimportsym.o
 	${speclib} ${@F}
 
-libdl.a: ${LIB_NAME} dlfcn.o
+libdl.a: ${LIB_NAME} dlfcn.o magicimportsym.o
 	${speclib} ${@F}
 
-libresolv.a: ${LIB_NAME} minires.o
+libresolv.a: ${LIB_NAME} minires.o magicimportsym.o
 	${speclib} ${@F}
 
 ${EXTRALIBS}: lib%.a: %.o
Index: magicimportsym.s
===================================================================
RCS file: magicimportsym.s
diff -N magicimportsym.s
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ magicimportsym.s	18 Apr 2009 13:33:03 -0000
@@ -0,0 +1,21 @@
+/* magicimportsym.s
+
+   Copyright 2009 Red Hat, Inc.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+/* In order for libtool to identify the speclib-generated libraries
+   as being import libraries, (which they aren't technically, but
+   serve in the stead of import libraries for our purposes), we need
+   to ensure there is at least one symbol tagged as an import symbol
+   when they are dumped with nm.  This file adds that required import,
+   in a dummy member that we expect never to be actually pulled into
+   any final link.
+*/
+
+	.section	.idata$7
+	.global	____dummy_libspecmagic_a_iname
+____dummy_libspecmagic_a_iname:	.asciz	"magic_speclib_import_library"
+
Index: speclib
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/speclib,v
retrieving revision 1.20
diff -p -u -r1.20 speclib
--- speclib	12 Apr 2009 05:11:08 -0000	1.20
+++ speclib	18 Apr 2009 13:33:03 -0000
@@ -12,10 +12,11 @@ my $inverse;
 my @exclude;
 
 my ($ar, $as, $nm, $objcopy);
-GetOptions('exclude=s'=>\@exclude, 'static!'=>\$static, 'v!'=>\$inverse,
+GetOptions('exclude=s'=>\@exclude, 'static=s'=>\$static, 'v!'=>\$inverse,
 	   'ar=s'=>\$ar, 'as=s'=>\$as,'nm=s'=>\$nm, 'objcopy=s'=>\$objcopy);
 
 $_ = File::Spec->rel2abs($_) for @ARGV;
+$static = File::Spec->rel2abs($static) if defined($static);
 
 my $libdll = shift;
 my $lib =  pop;
@@ -50,7 +51,9 @@ chdir $dir;
 my $res = system $ar, 'x', $libdll, sort keys %extract;
 die "$0: $ar extraction exited with non-zero status\n" if $res;
 unlink $lib;
+$extract{$static} = 1 if defined($static);
 $res = system $ar, 'crus', $lib, sort keys %extract;
+delete $extract{$static} if defined($static);
 unlink keys %extract;
 die "$0: ar creation of $lib exited with non-zero status\n" if $res;
 exit 0;


--------------060501080500020006060205--
