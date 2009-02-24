Return-Path: <cygwin-patches-return-6412-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22740 invoked by alias); 24 Feb 2009 23:39:04 -0000
Received: (qmail 22730 invoked by uid 22791); 24 Feb 2009 23:39:03 -0000
X-SWARE-Spam-Status: No, hits=0.1 required=5.0 	tests=AWL,BAYES_00,SARE_MSGID_LONG40,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-bw0-f165.google.com (HELO mail-bw0-f165.google.com) (209.85.218.165)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 24 Feb 2009 23:38:59 +0000
Received: by bwz9 with SMTP id 9so6542518bwz.2         for <cygwin-patches@cygwin.com>; Tue, 24 Feb 2009 15:38:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.122.15 with SMTP id j15mr227842far.74.1235518736242; Tue,  	24 Feb 2009 15:38:56 -0800 (PST)
Date: Tue, 24 Feb 2009 23:39:00 -0000
Message-ID: <83b27df30902241538m1aa5b85bh8e7ebee11e11ece6@mail.gmail.com>
Subject: [PATCH] w32api fixes commctrl.h listview
From: Michael James <james.me@gmail.com>
To: mingw-users@lists.sourceforge.net, cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
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
X-SW-Source: 2009-q1/txt/msg00010.txt.bz2

A simple patch. My application was misbehaving only when built with
mingw. It turned out that this incorrect header value was at fault. I
am also submitting this patch to the mingw patch tracker on
sourceforge.

Does anyone have an estimate on how long these patches take to be
incorporated into the main repository?


Index: include/commctrl.h
===================================================================
RCS file: /cvs/src/src/winsup/w32api/include/commctrl.h,v
retrieving revision 1.66
diff -r1.66 commctrl.h
1059c1059
< #define LVIF_COLUMNS 256
---
> #define LVIF_COLUMNS 512
Index: ChangeLog
===================================================================
RCS file: /cvs/src/src/winsup/w32api/ChangeLog,v
retrieving revision 1.986
diff -r1.986 ChangeLog
0a1,4
> 2009-02-24  Michael James  <james.me@gmail.com>
>
>       * include/commctrl.h (LVIF_COLUMNS): Fix definition.
>
