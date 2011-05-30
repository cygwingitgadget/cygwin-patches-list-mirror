Return-Path: <cygwin-patches-return-7416-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13629 invoked by alias); 30 May 2011 06:59:27 -0000
Received: (qmail 13618 invoked by uid 22791); 30 May 2011 06:59:27 -0000
X-SWARE-Spam-Status: No, hits=-0.0 required=5.0	tests=AWL,BAYES_50,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm28-vm0.bullet.mail.ne1.yahoo.com (HELO nm28-vm0.bullet.mail.ne1.yahoo.com) (98.138.91.22)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Mon, 30 May 2011 06:59:09 +0000
Received: from [98.138.90.57] by nm28.bullet.mail.ne1.yahoo.com with NNFMP; 30 May 2011 06:59:08 -0000
Received: from [98.138.226.124] by tm10.bullet.mail.ne1.yahoo.com with NNFMP; 30 May 2011 06:59:08 -0000
Received: from [127.0.0.1] by smtp203.mail.ne1.yahoo.com with NNFMP; 30 May 2011 06:59:08 -0000
Received: from cgf.cx (cgf@173.48.46.160 with login)        by smtp203.mail.ne1.yahoo.com with SMTP; 29 May 2011 23:59:07 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 13FA942804D	for <cygwin-patches@cygwin.com>; Mon, 30 May 2011 02:59:05 -0400 (EDT)
Date: Mon, 30 May 2011 06:59:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] tcsetpgrp fails unexpectedly
Message-ID: <20110530065904.GA6348@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20110404164509.706E51ED78AF@scythe.noid.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110404164509.706E51ED78AF@scythe.noid.net>
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
X-SW-Source: 2011-q2/txt/msg00182.txt.bz2

On Mon, Apr 04, 2011 at 09:45:09AM -0700, Tor Perkins wrote:
>2011-03-28  Tor Perkins
>  
>  * fhandler_termios.cc (fhandler_termios::bg_check): Do not return EIO
>  when a process group has no leader as this is allowed and does not imply
>  an orphaned process group.  Add a test for orphaned process groups.

I've checked this in and added missing pieces to the ChangeLog.

Thanks for the patch and apologies for the long delay.

cgf
