Return-Path: <cygwin-patches-return-5952-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4996 invoked by alias); 17 Aug 2006 16:17:30 -0000
Received: (qmail 4980 invoked by uid 22791); 17 Aug 2006 16:17:29 -0000
X-Spam-Check-By: sourceware.org
Received: from imo-d06.mx.aol.com (HELO imo-d06.mx.aol.com) (205.188.157.38)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 17 Aug 2006 16:17:23 +0000
Received: from kbarticle889459@aim.com 	by imo-d06.mx.aol.com (mail_out_v38_r7.6.) id s.269.e69c49b (57869) 	 for <cygwin-patches@cygwin.com>; Thu, 17 Aug 2006 12:17:17 -0400 (EDT)
Received: from  lh34ig2hgb (pool-70-20-177-184.phil.east.verizon.net [70.20.177.184]) by air-ia01.mail.aol.com (v111.7) with ESMTP id MAILINIA13-e20d44e4968c92; Thu, 17 Aug 2006 12:17:16 -0400
From: "Charli Li" <KBarticle889459@aim.com>
To: "Cygwin-Patches Mailing List" <cygwin-patches@cygwin.com>
Subject: FW: Patch for script of util-linux-2.12r-2 with zsh.
Date: Thu, 17 Aug 2006 16:17:00 -0000
Message-ID: <LLEBLEDLPAKFHFKGNDBMAEPJCBAA.KBarticle889459@aim.com>
MIME-Version: 1.0
Content-Type: text/plain; 	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-AOL-IP: 70.20.177.184
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00047.txt.bz2

Redirected to the Cygwin-Patches Mailing List.

Charli
>-----Original Message-----
>From: LIM Fung-Chai
>Sent: Thursday, August 17, 2006 8:31 AM
>To: Cygwin Mailing List
>Subject: Patch for script of util-linux-2.12r-2 with zsh.
>
>
>Hi,
>
>Here's a patch to make util-linux-2.12r-2/misc-utils/script work with
>zsh (the best and the greatest :-), and possibly with csh and tcsh as well.
>
>diff -Naur util-linux-2.12r/misc-utils/script.c
>util-linux-2.12r-3/misc-utils/script.c
>--- util-linux-2.12r/misc-utils/script.c        2006-02-24
>11:27:55.000000000 +0800
>+++ util-linux-2.12r-3/misc-utils/script.c      2006-08-17
>20:21:40.734375000 +0800
>@@ -431,8 +431,10 @@
>        (void) tcsetattr(slave, TCSAFLUSH, &tt);
>        (void) ioctl(slave, TIOCSWINSZ, (char *)&win);
> #endif
>+#ifdef __CYGWIN__
>+       (void) login_tty (slave);
>+#else
>        (void) setsid();
>-#ifndef __CYGWIN__
>        (void) ioctl(slave, TIOCSCTTY, 0);
> #endif
> }
>
>Regards,
>LIM Fung-Chai
>
>
