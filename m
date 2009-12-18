Return-Path: <cygwin-patches-return-6876-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25373 invoked by alias); 18 Dec 2009 00:10:48 -0000
Received: (qmail 25363 invoked by uid 22791); 18 Dec 2009 00:10:47 -0000
X-SWARE-Spam-Status: No, hits=-0.9 required=5.0 	tests=AWL,BAYES_00,SARE_MSGID_LONG40,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-pw0-f59.google.com (HELO mail-pw0-f59.google.com) (209.85.160.59)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 18 Dec 2009 00:10:41 +0000
Received: by pwj20 with SMTP id 20so1894799pwj.18         for <cygwin-patches@cygwin.com>; Thu, 17 Dec 2009 16:10:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.142.9.22 with SMTP id 22mr2071843wfi.264.1261095040178; Thu,  	17 Dec 2009 16:10:40 -0800 (PST)
Date: Fri, 18 Dec 2009 00:10:00 -0000
Message-ID: <b4864b490912171610k4c462d43p1298b0b1116af018@mail.gmail.com>
Subject: Re: [Patch] ps command returns 1 if PID not found
From: Ryan Dortmans <ryandort.cygwin@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=ISO-8859-1
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00207.txt.bz2

>Sorry but returning 1 doesn't make sense and it isn't the way that linux
>works.  It actually returns 0.

dortmans> /bin/ps -p 4549 ; echo "Return val: $?"
  PID TTY          TIME CMD
 4549 ?        00:00:00 sshd
Return val: 0
dortmans> /bin/ps -p 1111 ; echo "Return val: $?"
  PID TTY          TIME CMD
Return val: 1

dortmans> /bin/ps --version
procps version 3.2.3

I get these results in Solaris Unix and Red Hat Linux. The above
commands were executed on a Red Hat Linux system.

Cheers,

Ryan Dortmans
