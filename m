Return-Path: <cygwin-patches-return-7227-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24733 invoked by alias); 30 Mar 2011 19:25:06 -0000
Received: (qmail 24710 invoked by uid 22791); 30 Mar 2011 19:25:04 -0000
X-SWARE-Spam-Status: No, hits=-1.5 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm8.bullet.mail.sp2.yahoo.com (HELO nm8.bullet.mail.sp2.yahoo.com) (98.139.91.78)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Wed, 30 Mar 2011 19:24:59 +0000
Received: from [98.139.91.62] by nm8.bullet.mail.sp2.yahoo.com with NNFMP; 30 Mar 2011 19:24:59 -0000
Received: from [98.136.185.29] by tm2.bullet.mail.sp2.yahoo.com with NNFMP; 30 Mar 2011 19:24:59 -0000
Received: from [127.0.0.1] by smtp110.mail.gq1.yahoo.com with NNFMP; 30 Mar 2011 19:24:59 -0000
Received: from cgf.cx (cgf@72.70.43.165 with login)        by smtp110.mail.gq1.yahoo.com with SMTP; 30 Mar 2011 12:24:58 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 5A5594A801A	for <cygwin-patches@cygwin.com>; Wed, 30 Mar 2011 15:24:57 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id 4D9C42B35F; Wed, 30 Mar 2011 15:24:57 -0400 (EDT)
Date: Wed, 30 Mar 2011 19:25:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: patch for icmp.h
Message-ID: <20110330192457.GC16763@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4D93786B.9050304@bogomips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D93786B.9050304@bogomips.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q1/txt/msg00082.txt.bz2

On Wed, Mar 30, 2011 at 11:37:31AM -0700, John Paul Morrison wrote:
>This patch adds missing icmp types and definitions needs for source 
>compatibility, and it seems to work for raw icmp sockets.
>My only changes is renaming __USE_BSD which is used by Linux. It doesn't 
>look like cygwin has an equivalent and didn't want to add a potentially 
>conflicting #define. The other option would be removing the #ifdef 
>completely.
>
>1. programs that include <netinet/ip_icmp.h> should now compile without 
>errors
>
>2. I compiled and ran a test program myping.c 
>http://www.tenouk.com/Module43a.html and verified with wireshark.
>- when using the Windows XP SP3 machine's correct source IP, myping.c 
>sends a ping on the wire.
>- other fragments are put on the wire but this appears to be a bug in 
>the test program
>- with a spoofed IP address, myping.c errors with sendto() error: 
>Interrupted system call. Seems like a windows issue unrelated to icmp.h
>
>I understand that raw/icmp sockets may be undocumented in Windows; 
>Cygwin and/or windows and/or the myping.c test program may be buggy etc.
>The test program was able to put a valid ICMP echo request on the wire 
>with correct ip and icmp headers in the correct endianness , so at least 
>some raw socket functions are working
>
>
>ChangeLog:
>     2011-03-28    John Paul Morrison <jmorrison@bogomips.com>
>
>             * icmp.h: add missing definitions for icmp
>
>--- snap/usr/include/cygwin/icmp.h    2011-03-27 12:31:43.000000000 -0700
>+++ /usr/include/cygwin/icmp.h    2011-03-28 16:02:20.842491500 -0700
>@@ -1 +1,291 @@
>  /* icmp.h */
>+
>+
>+/* Copyright (C) 1991, 92, 93, 95, 96, 97, 99 Free Software Foundation, 
>Inc.
>+   This file is part of the GNU C Library.
>+
>+   The GNU C Library is free software; you can redistribute it and/or
>+   modify it under the terms of the GNU Lesser General Public
>+   License as published by the Free Software Foundation; either
>+   version 2.1 of the License, or (at your option) any later version.
>+
>+   The GNU C Library is distributed in the hope that it will be useful,
>+   but WITHOUT ANY WARRANTY; without even the implied warranty of
>+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>+   Lesser General Public License for more details.
>+
>+   You should have received a copy of the GNU Lesser General Public
>+   License along with the GNU C Library; if not, write to the Free
>+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
>+   02111-1307 USA.  */
>+
>+#ifndef __CYGWIN_H
>+#define __CYGWIN_H    1

AFAIK, We can't just add GPLed code to Cygwin although recent comments
from RMS regarding header files may have made that murkier.

Regardless, this isn't the right name for this multiple-inclusion
protection define.  The name of the file isn't "cygwin.h".

I am amazed that this would all work without any code changes to Cygwin
itself though.

cgf
