Return-Path: <cygwin-patches-return-7216-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9729 invoked by alias); 29 Mar 2011 07:43:58 -0000
Received: (qmail 9515 invoked by uid 22791); 29 Mar 2011 07:43:56 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-iy0-f171.google.com (HELO mail-iy0-f171.google.com) (209.85.210.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 29 Mar 2011 07:43:51 +0000
Received: by iyi20 with SMTP id 20so5146414iyi.2        for <cygwin-patches@cygwin.com>; Tue, 29 Mar 2011 00:43:50 -0700 (PDT)
Received: by 10.43.55.137 with SMTP id vy9mr6746087icb.174.1301384630413;        Tue, 29 Mar 2011 00:43:50 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id mv26sm3482480ibb.28.2011.03.29.00.43.47        (version=SSLv3 cipher=OTHER);        Tue, 29 Mar 2011 00:43:48 -0700 (PDT)
Subject: Provide sys/xattr.h
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Content-Type: multipart/mixed; boundary="=-2cakAwUejRIOmJo+N9XB"
Date: Tue, 29 Mar 2011 07:43:00 -0000
Message-ID: <1301384629.4524.24.camel@YAAKOV04>
Mime-Version: 1.0
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q1/txt/msg00071.txt.bz2


--=-2cakAwUejRIOmJo+N9XB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 1347

Historically, the *xattr functions were first provided by SGI libattr
and prototyped in <attr/xattr.h>.  Later, glibc added them under
<sys/xattr.h>[1], and (on Linux) libattr still provides the symbols for
ABI compatibility but they are now just wrappers.

(FWIW, Darwin also provides these symbols in <sys/xattr.h>[2].)

This can be seen very clearly in GLib's configure[3], where
<sys/xattr.h> and libc are tested in tandem, followed by <attr/xattr.h>
and libattr.  Hence, with only attr/xattr.h present, libattr-devel is
required not only for building GLib, but the -lattr becomes hardcoded in
the libtool .la files, meaning that libglib2.0-devel would require
libattr-devel even though GLib requires no symbols from libattr1.

I see two ways to resolve this:

1) Move include/attr/xattr.h to include/sys/xattr.h, and ship libattr's
attr/xattr.h in libattr-devel, exactly as is done on Linux:

2011-03-29  Yaakov Selkowitz <yselkowitz@...>

	* include/attr/xattr.h: Move from here...
	* include/sys/xattr.h: ...to here.

2) Install a copy of include/attr/xattr.h as <sys/xattr.h>, as in the
attached patch.


Yaakov

[1] http://packages.debian.org/sid/i386/libc6-dev/filelist
[2] http://developer.apple.com/library/mac/#documentation/Darwin/Reference/ManPages/man2/getxattr.2.html
[3] http://git.gnome.org/browse/glib/tree/configure.ac#n1710


--=-2cakAwUejRIOmJo+N9XB
Content-Disposition: attachment; filename="include-sys-xattr.patch"
Content-Type: text/x-patch; name="include-sys-xattr.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 792

2011-03-29  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* Makefile.in (install-headers): Ship a copy of <attr/xattr.h>
	as <sys/xattr.h> for compatibility with glibc.

Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/Makefile.in,v
retrieving revision 1.241
diff -u -r1.241 Makefile.in
--- Makefile.in	28 Sep 2010 14:49:31 -0000	1.241
+++ Makefile.in	29 Mar 2011 07:16:11 -0000
@@ -329,6 +329,7 @@
 	      $(INSTALL_DATA) $$i $(DESTDIR)$(tooldir)/$$sub/`basename $$i` ; \
 	    done ; \
 	done ; \
+	$(INSTALL_DATA) include/attr/xattr.h $(DESTDIR)$(tooldir)/include/sys/xattr.h
 
 install-man:
 	@$(MKDIRP) $(DESTDIR)$(mandir)/man2 $(DESTDIR)$(mandir)/man3 $(DESTDIR)$(mandir)/man5 $(DESTDIR)$(mandir)/man7

--=-2cakAwUejRIOmJo+N9XB--
