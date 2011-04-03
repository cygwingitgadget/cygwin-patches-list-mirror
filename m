Return-Path: <cygwin-patches-return-7243-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5935 invoked by alias); 3 Apr 2011 22:37:50 -0000
Received: (qmail 5726 invoked by uid 22791); 3 Apr 2011 22:37:49 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-yx0-f171.google.com (HELO mail-yx0-f171.google.com) (209.85.213.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 03 Apr 2011 22:37:43 +0000
Received: by yxe42 with SMTP id 42so2471323yxe.2        for <cygwin-patches@cygwin.com>; Sun, 03 Apr 2011 15:37:42 -0700 (PDT)
Received: by 10.146.216.22 with SMTP id o22mr6226444yag.25.1301870262122;        Sun, 03 Apr 2011 15:37:42 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id c21sm2583217anc.40.2011.04.03.15.37.34        (version=SSLv3 cipher=OTHER);        Sun, 03 Apr 2011 15:37:35 -0700 (PDT)
Subject: [PATCH] fix make after clean
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Content-Type: multipart/mixed; boundary="=-1nAnFAClLmCthE/lQmQi"
Date: Sun, 03 Apr 2011 22:37:00 -0000
Message-ID: <1301870258.3104.11.camel@YAAKOV04>
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
X-SW-Source: 2011-q2/txt/msg00009.txt.bz2


--=-1nAnFAClLmCthE/lQmQi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 215

If you run make clean in winsup/cygwin followed by make -jX, the build
fails because devices.cc is not found; it was removed by make clean but
nothing forced it to be regenerated in time.

Patch attached.


Yaakov


--=-1nAnFAClLmCthE/lQmQi
Content-Disposition: attachment; filename="makefile-devices_cc.patch"
Content-Type: text/x-patch; name="makefile-devices_cc.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 715

2011-04-03  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* Makefile.in (devices.o): New rule with dependency on devices.cc
	to assure that the latter exists and is current.

Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/Makefile.in,v
retrieving revision 1.243
diff -u -r1.243 Makefile.in
--- Makefile.in	1 Apr 2011 19:48:19 -0000	1.243
+++ Makefile.in	3 Apr 2011 21:33:27 -0000
@@ -443,6 +443,9 @@
 $(srcdir)/devices.cc: gendevices devices.in devices.h
 	${wordlist 1,2,$^} $@
 
+devices.o: $(srcdir)/devices.cc
+	$(COMPILE_CXX) -o $@ $<
+
 ${CURDIR}/libc.a: ${LIB_NAME} ./libm.a libpthread.a libutil.a
 	${speclib} -v ${@F}
 

--=-1nAnFAClLmCthE/lQmQi--
