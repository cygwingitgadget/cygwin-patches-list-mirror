Return-Path: <cygwin-patches-return-7278-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1394 invoked by alias); 11 Apr 2011 02:03:02 -0000
Received: (qmail 1350 invoked by uid 22791); 11 Apr 2011 02:03:00 -0000
X-SWARE-Spam-Status: No, hits=-1.6 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm12-vm0.bullet.mail.ac4.yahoo.com (HELO nm12-vm0.bullet.mail.ac4.yahoo.com) (98.139.53.198)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Mon, 11 Apr 2011 02:02:55 +0000
Received: from [98.139.52.194] by nm12.bullet.mail.ac4.yahoo.com with NNFMP; 11 Apr 2011 02:02:53 -0000
Received: from [74.6.228.50] by tm7.bullet.mail.ac4.yahoo.com with NNFMP; 11 Apr 2011 02:02:53 -0000
Received: from [127.0.0.1] by smtp109.mail.ac4.yahoo.com with NNFMP; 11 Apr 2011 02:02:53 -0000
Received: from cgf.cx (cgf@96.252.118.15 with login)        by smtp109.mail.ac4.yahoo.com with SMTP; 10 Apr 2011 19:02:53 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 751D64A801A	for <cygwin-patches@cygwin.com>; Sun, 10 Apr 2011 22:02:53 -0400 (EDT)
Date: Mon, 11 Apr 2011 02:03:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] implement /proc/swaps
Message-ID: <20110411020253.GA8284@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1302487196.4944.9.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1302487196.4944.9.camel@YAAKOV04>
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
X-SW-Source: 2011-q2/txt/msg00044.txt.bz2

On Sun, Apr 10, 2011 at 08:59:56PM -0500, Yaakov (Cygwin/X) wrote:
>This patch implements /proc/swaps, as found on Linux[1]:
>
>$ cat /proc/swaps
>Filename				Type		Size	Used	Priority
>/cygdrive/c/pagefile.sys                file            4192440 16376   0
>/cygdrive/d/pagefile.sys                file            4192440 14208   0
>
>(The first line is tab-delineated, the following lines use spaces.)
>
>If there is no paging file on the system (a legal but discouraged
>configuration), then only the header line is displayed.
>
>According to Microsoft[2], there's no simple way to set or determine
>which paging file will be used at any given time.  Therefore I list all
>paging files with priority 0.
>
>Patches for winsup/cygwin and winsup/doc attached.

Looks reasonable.  Please check in.

Thanks!

cgf
