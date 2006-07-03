Return-Path: <cygwin-patches-return-5911-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32341 invoked by alias); 3 Jul 2006 13:26:40 -0000
Received: (qmail 32331 invoked by uid 22791); 3 Jul 2006 13:26:40 -0000
X-Spam-Check-By: sourceware.org
Received: from mailproxy-in2.jaist.ac.jp (HELO mailproxy-in2.jaist.ac.jp) (150.65.5.23)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 03 Jul 2006 13:26:35 +0000
Received: from localhost (localhost [127.0.0.1]) by mailproxy-in2.jaist.ac.jp  (JAIST-MAIL) with SMTP id <0J1T00ESBXCA1G@mailproxy-in2.jaist.ac.jp> for  cygwin-patches@cygwin.com; Mon, 03 Jul 2006 22:26:34 +0900 (JST)
Received: from NFORCE1 (nforce1.jaist.ac.jp [150.65.191.58])  by mailproxy-in2.jaist.ac.jp (JAIST-MAIL)  with ESMTP id <0J1T00H54XC1UA@mailproxy-in2.jaist.ac.jp> for  cygwin-patches@cygwin.com; Mon, 03 Jul 2006 22:26:25 +0900 (JST)
Date: Mon, 03 Jul 2006 13:26:00 -0000
From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
Subject: Re: setmetamode
In-reply-to: <20060703114522.GC14901@calimero.vinschen.de>
To: cygwin-patches@cygwin.com
Message-id: <ur712vmyb.fsf@jaist.ac.jp>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="=-=-="
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (windows-nt)
References: <u8xncvv26.fsf@jaist.ac.jp>  <20060703114522.GC14901@calimero.vinschen.de>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00006.txt.bz2


--=-=-=
Content-length: 425

>>> On Mon, 03 Jul 2006 13:45:22 +0200
>>> Corinna Vinschen <corinna-cygwin@cygwin.com> said:

> You didn't add an include/sys/kd.h file.  On Linux this file in turn
> includes linux/kd.h.  Is there a reason that you didn't create it?

No. I just forgot it.
____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology

--=-=-=
Content-Disposition: attachment; filename=kd.h
Content-length: 398

/* sys/kd.h

   Copyright 2006 Red Hat, Inc.

   Written by Kazuhiro Fujieda <fujieda@jaist.ac.jp>

This file is part of Cygwin.

This software is a copyrighted work licensed under the terms of the
Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
details. */

/* sys/kd.h header file for Cygwin.  */

#ifndef _SYS_KD_H
#define _SYS_KD_H

#include <cygwin/kd.h>

#endif /* _SYS_KD_H */

--=-=-=--


