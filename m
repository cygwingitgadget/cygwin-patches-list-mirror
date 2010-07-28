Return-Path: <cygwin-patches-return-7044-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 315 invoked by alias); 28 Jul 2010 21:11:45 -0000
Received: (qmail 32767 invoked by uid 22791); 28 Jul 2010 21:11:44 -0000
X-SWARE-Spam-Status: No, hits=-0.8 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE
X-Spam-Check-By: sourceware.org
Received: from mail-pw0-f43.google.com (HELO mail-pw0-f43.google.com) (209.85.160.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 28 Jul 2010 21:11:36 +0000
Received: by pwj6 with SMTP id 6so2387505pwj.2        for <cygwin-patches@cygwin.com>; Wed, 28 Jul 2010 14:11:35 -0700 (PDT)
Received: by 10.142.131.21 with SMTP id e21mr1516362wfd.88.1280351495158;        Wed, 28 Jul 2010 14:11:35 -0700 (PDT)
Received: from xyzzy (tide528.microsoft.com [131.107.0.98])        by mx.google.com with ESMTPS id y16sm26388wff.14.2010.07.28.14.11.34        (version=TLSv1/SSLv3 cipher=RC4-MD5);        Wed, 28 Jul 2010 14:11:34 -0700 (PDT)
From: "Daniel Colascione" <dan.colascione@gmail.com>
To: <cygwin-patches@cygwin.com>
Subject: [PATCH] fix build warnings for functions without return value
Date: Wed, 28 Jul 2010 21:11:00 -0000
Message-ID: <004d01cb2e99$7567c500$60374f00$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;	charset="us-ascii"
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
X-SW-Source: 2010-q3/txt/msg00004.txt.bz2

Stop warnings about function not returning a value; the value is meaningless
anyway, but the compiler can't know that.
Index: cygwin-1.7.5-1/winsup/cygwin/fhandler_tty.cc
===================================================================
--- cygwin-1.7.5-1.orig/winsup/cygwin/fhandler_tty.cc
+++ cygwin-1.7.5-1/winsup/cygwin/fhandler_tty.cc
@@ -221,6 +221,8 @@ process_input (void *)
 	  == line_edit_signalled)
 	tty_master->console->eat_readahead (-1);
     }
+
+  return 0;
 }
 
 bool
@@ -434,6 +436,8 @@ process_ioctl (void *)
 				  : (void *) &ttyp->arg);
       SetEvent (tty_master->ioctl_done_event);
     }
+
+  return 0;
 }
 
 /**********************************************************************/
