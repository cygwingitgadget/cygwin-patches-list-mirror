Return-Path: <cygwin-patches-return-7064-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28997 invoked by alias); 9 Aug 2010 22:38:43 -0000
Received: (qmail 28984 invoked by uid 22791); 9 Aug 2010 22:38:42 -0000
X-SWARE-Spam-Status: No, hits=-50.8 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE
X-Spam-Check-By: sourceware.org
Received: from mail-qw0-f43.google.com (HELO mail-qw0-f43.google.com) (209.85.216.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 09 Aug 2010 22:38:37 +0000
Received: by qwd6 with SMTP id 6so10863063qwd.2        for <cygwin-patches@cygwin.com>; Mon, 09 Aug 2010 15:38:36 -0700 (PDT)
Received: by 10.229.250.133 with SMTP id mo5mr7745004qcb.99.1281393515415;        Mon, 09 Aug 2010 15:38:35 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [24.76.240.202])        by mx.google.com with ESMTPS id q8sm4348981qcs.36.2010.08.09.15.38.34        (version=SSLv3 cipher=RC4-MD5);        Mon, 09 Aug 2010 15:38:35 -0700 (PDT)
Subject: [PATCH] adjust to mingw sysroot
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Content-Type: multipart/mixed; boundary="=-CpgcaewRKC9Ts1pFar1s"
Date: Mon, 09 Aug 2010 22:38:00 -0000
Message-ID: <1281393516.6576.29.camel@YAAKOV04>
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
X-SW-Source: 2010-q3/txt/msg00024.txt.bz2


--=-CpgcaewRKC9Ts1pFar1s
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 307

winsup/utils/mingw will break once mingw-* moves into a sysroot.  The
attached patch allows for the sysroot without (hopefully) breaking
pre-sysroot installations.

It may be a bit premature to commit this, but this transition will
otherwise break the Cygwin build so I didn't want any surprises.


Yaakov


--=-CpgcaewRKC9Ts1pFar1s
Content-Disposition: attachment; filename="winsup-utils-mingw-sysroot.patch"
Content-Type: text/x-patch; name="winsup-utils-mingw-sysroot.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 647

2010-08-09  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* mingw: Use sysroot, if present, for mingw_dir.

Index: mingw
===================================================================
RCS file: /cvs/src/src/winsup/utils/mingw,v
retrieving revision 1.6
diff -u -r1.6 mingw
--- mingw	10 Aug 2009 01:55:14 -0000	1.6
+++ mingw	9 Aug 2010 21:40:59 -0000
@@ -18,7 +18,11 @@
          /*-mingw32 /usr/*-mingw32 /*-mingw* /usr/*-mingw*; do
     case "$d" in
 	*\**)	continue ;;
-	*)	mingw_dir=$d; break;
+	*)	if [ -d "$d"/sys-root/mingw ]; then
+		    mingw_dir=$d/sys-root/mingw
+		else
+		    mingw_dir=$d;
+		fi; break;
     esac
 done
 

--=-CpgcaewRKC9Ts1pFar1s--
