Return-Path: <cygwin-patches-return-7802-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2925 invoked by alias); 17 Feb 2013 11:50:33 -0000
Received: (qmail 2902 invoked by uid 22791); 17 Feb 2013 11:50:32 -0000
X-SWARE-Spam-Status: No, hits=-4.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,KHOP_SPAMHAUS_DROP,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE,TW_DB,TW_XD
X-Spam-Check-By: sourceware.org
Received: from mail-ia0-f180.google.com (HELO mail-ia0-f180.google.com) (209.85.210.180)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 17 Feb 2013 11:50:06 +0000
Received: by mail-ia0-f180.google.com with SMTP id f27so4565546iae.11        for <cygwin-patches@cygwin.com>; Sun, 17 Feb 2013 03:50:06 -0800 (PST)
X-Received: by 10.50.5.134 with SMTP id s6mr5025563igs.98.1361101806247;        Sun, 17 Feb 2013 03:50:06 -0800 (PST)
Received: from YAAKOV04 (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id ee5sm1161030igc.0.2013.02.17.03.50.04        (version=SSLv3 cipher=RC4-SHA bits=128/128);        Sun, 17 Feb 2013 03:50:05 -0800 (PST)
Date: Sun, 17 Feb 2013 11:50:00 -0000
From: Yaakov (Cygwin/X) <yselkowitz@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH 64bit] Fix speclib for x86_64
Message-ID: <20130217044622.1034ae22@YAAKOV04>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/bqVAyzjzYdtUge9yYxlhMbi"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2013-q1/txt/msg00013.txt.bz2


--MP_/bqVAyzjzYdtUge9yYxlhMbi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Content-length: 0


--MP_/bqVAyzjzYdtUge9yYxlhMbi
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=cygwin-speclib-64bit.patch
Content-length: 2598

2013-02-16  Yaakov Selkowitz  <yselkowitz@...>

	* Makefile.in (libcygwin.a): Move --target flag from here...
	(toolopts): to here, to be used by both mkimport and speclib.
	* speclib: Omit leading underscore in symbol names on x86_64.

Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/Makefile.in,v
retrieving revision 1.257.2.14
diff -u -p -r1.257.2.14 Makefile.in
--- Makefile.in	15 Feb 2013 13:36:35 -0000	1.257.2.14
+++ Makefile.in	17 Feb 2013 05:15:10 -0000
@@ -123,7 +123,7 @@ LIBGMON_A:=libgmon.a
 CYGWIN_START:=crt0.o
 GMON_START:=gcrt0.o
 
-toolopts:=--ar=${AR} --as=${AS} --nm=${NM} --objcopy=${OBJCOPY} 
+toolopts:=--target=${target_alias} --ar=${AR} --as=${AS} --nm=${NM} --objcopy=${OBJCOPY}
 speclib=\
     ${srcdir}/speclib ${toolopts} \
 	--exclude='cygwin' \
@@ -434,7 +434,7 @@ $(TEST_DLL_NAME): $(LDSCRIPT) dllfixdbg 
 
 # Rule to build libcygwin.a
 $(LIB_NAME): $(LIBCOS) | $(TEST_DLL_NAME) 
-	${srcdir}/mkimport --target=$(target_alias) ${toolopts} ${NEW_FUNCTIONS} $@ cygdll.a $^
+	${srcdir}/mkimport ${toolopts} ${NEW_FUNCTIONS} $@ cygdll.a $^
 
 ${STATIC_LIB_NAME}: mkstatic ${TEST_DLL_NAME}
 	perl -d $< -x ${EXCLUDE_STATIC_OFILES} --library=${LIBC} --library=${LIBM} --ar=${AR} $@ cygwin.map
Index: speclib
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/speclib,v
retrieving revision 1.25
diff -u -p -r1.25 speclib
--- speclib	11 Feb 2011 18:00:55 -0000	1.25
+++ speclib	17 Feb 2013 05:15:10 -0000
@@ -11,16 +11,17 @@ my $static;
 my $inverse;
 my @exclude;
 
-my ($ar, $as, $nm, $objcopy);
+my ($target, $ar, $as, $nm, $objcopy);
 GetOptions('exclude=s'=>\@exclude, 'static!'=>\$static, 'v!'=>\$inverse,
-	   'ar=s'=>\$ar, 'as=s'=>\$as,'nm=s'=>\$nm, 'objcopy=s'=>\$objcopy);
+	   'target=s'=>\$target, 'ar=s'=>\$ar, 'as=s'=>\$as,'nm=s'=>\$nm, 'objcopy=s'=>\$objcopy);
 
 $_ = File::Spec->rel2abs($_) for @ARGV;
 
 my $libdll = shift;
 my $lib =  pop;
+my $uscore = ($target =~ /^x86_64\-/ ? undef : '_');
 (my $iname = basename $lib) =~ s/\.a$//o;
-$iname = '_' . $iname . '_dll_iname';
+$iname = $uscore . $iname . '_dll_iname';
 
 open my $nm_fd, '-|', $nm, '-Apg', '--defined-only', @ARGV, $libdll or
   die "$0: execution of $nm for object files failed - $!\n";
@@ -34,7 +35,7 @@ $exclude_regex = qr/$exclude_regex/;
 my $dllname;
 while (<$nm_fd>) {
     study;
-    if (/ I _(.*)_dll_iname/o) {
+    if (/ I _?(.*)_dll_iname/o) {
 	$dllname = $1;
     } else {
 	my ($file, $member, $symbol) = m%^([^:]*):([^:]*(?=:))?.* T (.*)%o;

--MP_/bqVAyzjzYdtUge9yYxlhMbi--
