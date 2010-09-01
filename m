Return-Path: <cygwin-patches-return-7072-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15916 invoked by alias); 1 Sep 2010 18:18:29 -0000
Received: (qmail 15892 invoked by uid 22791); 1 Sep 2010 18:18:28 -0000
X-SWARE-Spam-Status: No, hits=-0.8 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f43.google.com (HELO mail-ew0-f43.google.com) (209.85.215.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 01 Sep 2010 18:18:22 +0000
Received: by ewy1 with SMTP id 1so6071101ewy.2        for <cygwin-patches@cygwin.com>; Wed, 01 Sep 2010 11:18:19 -0700 (PDT)
Received: by 10.213.105.77 with SMTP id s13mr12149518ebo.50.1283365099414;        Wed, 01 Sep 2010 11:18:19 -0700 (PDT)
Received: from [192.168.0.3] (141.191.216.81.static.g-hn.siw.siwnet.net [81.216.191.141])        by mx.google.com with ESMTPS id a48sm16485848eei.0.2010.09.01.11.18.15        (version=TLSv1/SSLv3 cipher=RC4-MD5);        Wed, 01 Sep 2010 11:18:16 -0700 (PDT)
Message-ID: <4C7E98E5.4040301@gmail.com>
Date: Wed, 01 Sep 2010 18:18:00 -0000
From: Magnus Holmgren <magnushol@gmail.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Faster process initialization
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
X-SW-Source: 2010-q3/txt/msg00032.txt.bz2

This patch speeds up process initialization on 64-bit systems. Maybe
the comment "Initialize signal processing here ..." should be re-worded
or removed completely.

The speed difference can be noticeable.
"while (true); do date; done | uniq -c" manages more than 3 times more
"date" executions per second on my system.


2010-09-01  Magnus Holmgren  <magnushol@gmail.com>

	* dcrt0.cc (dll_crt0_0): Remove call to sigproc_init. It creates
	a thread, and execution of that thread can be delayed during
	DLL init, slowing things down (seen on 64-bit systems).
	(dll_crt0_1): Always call sigproc_init.


Index: src/winsup/cygwin/dcrt0.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dcrt0.cc,v
retrieving revision 1.382
diff -u -p -r1.382 dcrt0.cc
--- src/winsup/cygwin/dcrt0.cc  30 Aug 2010 23:23:28 -0000      1.382
+++ src/winsup/cygwin/dcrt0.cc  1 Sep 2010 17:49:26 -0000
@@ -740,11 +740,9 @@ dll_crt0_0 ()
         }
      }

-  /* Initialize signal processing here, early, in the hopes that the creation
-     of a thread early in the process will cause more predictability in memory
-     layout for the main thread. */
-  if (!dynamically_loaded)
-    sigproc_init ();
+  /* Don't initialize signal processing here. It creates a thread, and
+     execution of threads created during DLL initialization can be
+     delayed (e.g., on 64-bit Windows Vista and Windows 7) */

    user_data->threadinterface->Init ();

@@ -789,8 +787,10 @@ dll_crt0_1 (void *)
  {
    extern void initial_setlocale ();

-  if (dynamically_loaded)
-    sigproc_init ();
+  /* Initialize signal processing here, early, in the hopes that the creation
+     of a thread early in the process will cause more predictability in memory
+     layout for the main thread. */
+  sigproc_init ();
    check_sanity_and_sync (user_data);

    /* Initialize malloc and then call user_shared_initialize since it relies

-- 
   Magnus
