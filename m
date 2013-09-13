Return-Path: <cygwin-patches-return-7896-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21777 invoked by alias); 13 Sep 2013 17:10:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 21756 invoked by uid 89); 13 Sep 2013 17:10:46 -0000
Received: from mail-pa0-f50.google.com (HELO mail-pa0-f50.google.com) (209.85.220.50) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-SHA encrypted) ESMTPS; Fri, 13 Sep 2013 17:10:46 +0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-3.1 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,FREEMAIL_FROM autolearn=ham version=3.3.2
X-HELO: mail-pa0-f50.google.com
Received: by mail-pa0-f50.google.com with SMTP id fb10so2771949pad.37        for <cygwin-patches@cygwin.com>; Fri, 13 Sep 2013 10:10:44 -0700 (PDT)
X-Received: by 10.68.137.1 with SMTP id qe1mr14762719pbb.25.1379092244111;        Fri, 13 Sep 2013 10:10:44 -0700 (PDT)
Received: from [192.168.0.101] (S0106000cf16f58b1.wp.shawcable.net. [24.79.212.134])        by mx.google.com with ESMTPSA id sy10sm19326280pac.15.1969.12.31.16.00.00        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);        Fri, 13 Sep 2013 10:10:43 -0700 (PDT)
Message-ID: <52334717.6070803@users.sourceforge.net>
Date: Fri, 13 Sep 2013 17:10:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] cygcheck: xz packages
Content-Type: multipart/mixed; boundary="------------000601080001060606030703"
X-SW-Source: 2013-q3/txt/msg00003.txt.bz2

This is a multi-part message in MIME format.
--------------000601080001060606030703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 69

cygcheck needs fixing wrt .tar.xz packages; patch attached.


Yaakov

--------------000601080001060606030703
Content-Type: text/x-patch;
 name="cygcheck-xz-pkgs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cygcheck-xz-pkgs.patch"
Content-length: 675

2013-09-13  Yaakov Selkowitz  <yselkowitz@...>

	* dump_setup.cc (find_tar_ext): Allow .tar.xz packages.

Index: dump_setup.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/dump_setup.cc,v
retrieving revision 1.27
diff -u -p -r1.27 dump_setup.cc
--- dump_setup.cc	21 Jan 2013 16:28:27 -0000	1.27
+++ dump_setup.cc	13 Sep 2013 17:08:42 -0000
@@ -46,7 +46,7 @@ find_tar_ext (const char *path)
     return 0;
   if (*p == '.')
     {
-      if (strcmp (p, ".tar.gz") != 0)
+      if (!(strcmp (p, ".tar.gz") == 0 || strcmp (p, ".tar.xz") == 0))
 	return 0;
     }
   else if (--p <= path || strcmp (p, ".tar.bz2") != 0)

--------------000601080001060606030703--
