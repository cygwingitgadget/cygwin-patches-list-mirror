Return-Path: <cygwin-patches-return-7944-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7482 invoked by alias); 20 Jan 2014 06:03:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 7439 invoked by uid 89); 20 Jan 2014 06:03:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mail-lb0-f177.google.com
Received: from mail-lb0-f177.google.com (HELO mail-lb0-f177.google.com) (209.85.217.177) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-SHA encrypted) ESMTPS; Mon, 20 Jan 2014 06:03:00 +0000
Received: by mail-lb0-f177.google.com with SMTP id z5so4453283lbh.8        for <cygwin-patches@cygwin.com>; Sun, 19 Jan 2014 22:02:57 -0800 (PST)
MIME-Version: 1.0
X-Received: by 10.152.44.225 with SMTP id h1mr10810102lam.22.1390197776950; Sun, 19 Jan 2014 22:02:56 -0800 (PST)
Received: by 10.112.43.43 with HTTP; Sun, 19 Jan 2014 22:02:56 -0800 (PST)
Date: Mon, 20 Jan 2014 06:03:00 -0000
Message-ID: <CABDpyCh3VMDmd4Rb64Fz-cb2HzUwtZ0cY9T3xWUC8_O-eqKO6Q@mail.gmail.com>
Subject: [PATCH] Fix parameter passing containing quote/equal to Windows batch command
From: Daniel Dai <daijyc@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=ISO-8859-1
X-IsSubscribed: yes
X-SW-Source: 2014-q1/txt/msg00017.txt.bz2

We notice one issue when running a Windows batch command inside
cygwin. Here is one example.

Simple batch file:
a.bat:
echo %1

Run it under cygwin:
./a.bat a=b
a

./a.bat "a=b"
a

If we pass additional \"
./a.bat "\"a=b\""
"\"a

There seems no way to pass a=b into bat.

Attach quote.patch contains a fix. It does two things:
1. If the parameter contains a equal sign, automatically add quote
(similar to space, tab, new line, quote cygwin already do)
2. If the parameter is already quoted, don't quote again

Patch:
Index: cygwin/winf.cc
==============================
=====================================
RCS file: /cvs/src/src/winsup/cygwin/winf.cc,v
retrieving revision 1.10
diff -u -p -r1.10 winf.cc
--- cygwin/winf.cc      19 Jun 2013 16:00:43 -0000      1.10
+++ cygwin/winf.cc      20 Jan 2014 00:50:15 -0000
@@ -72,11 +72,16 @@ linebuf::fromargv (av& newargv, const ch
     {
       char *p = NULL;
       const char *a;
+      boolean enclosed_with_quote = false;

       a = i ? newargv[i] : (char *) real_path;
       int len = strlen (a);
-      if (len != 0 && !strpbrk (a, " \t\n\r\""))
-       add (a, len);
+      if (len != 0 && a[0] == '\"' && a[len-1] == '\"') {
+        enclosed_with_quote = true;
+      }
+      if (enclosed_with_quote || (len != 0 && !strpbrk (a, " \t\n\r\"="))) {
+        add (a, len);
+      }
       else
        {
          add ("\"", 1);

Thanks,
Daniel
