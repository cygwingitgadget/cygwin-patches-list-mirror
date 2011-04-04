Return-Path: <cygwin-patches-return-7269-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26081 invoked by alias); 4 Apr 2011 17:16:01 -0000
Received: (qmail 26061 invoked by uid 22791); 4 Apr 2011 17:15:58 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm4-vm0.bullet.mail.bf1.yahoo.com (HELO nm4-vm0.bullet.mail.bf1.yahoo.com) (98.139.213.129)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Mon, 04 Apr 2011 17:15:51 +0000
Received: from [98.139.212.150] by nm4.bullet.mail.bf1.yahoo.com with NNFMP; 04 Apr 2011 17:15:50 -0000
Received: from [98.139.213.14] by tm7.bullet.mail.bf1.yahoo.com with NNFMP; 04 Apr 2011 17:15:50 -0000
Received: from [127.0.0.1] by smtp114.mail.bf1.yahoo.com with NNFMP; 04 Apr 2011 17:15:49 -0000
Received: from cgf.cx (cgf@96.252.118.15 with login)        by smtp114.mail.bf1.yahoo.com with SMTP; 04 Apr 2011 10:15:35 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id DF02E428013	for <cygwin-patches@cygwin.com>; Mon,  4 Apr 2011 13:15:29 -0400 (EDT)
Date: Mon, 04 Apr 2011 17:16:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] tcsetpgrp fails unexpectedly
Message-ID: <20110404171529.GA6155@ednor.casa.cgf.cx>
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
X-SW-Source: 2011-q2/txt/msg00035.txt.bz2

On Mon, Apr 04, 2011 at 09:45:09AM -0700, Tor Perkins wrote:
>
>
>I think I've found two problems in fhandler_termios::bg_check():
>
>  * Cygwin's tcsetpgrp function will return EIO when the process
>    group for the calling process has no leader.
>
>  * This appears to be caused by a leaderless process group being
>    interpreted as an orphaned process group.
>
>Please find a plain text file attachment that includes a changelog
>entry and a patch.

Thanks for the patch and the report.  I'll take a look at this in detail
in the next couple of days.  However, unfortunately, I think this is a
large enough submission that it requires an assignment form.

See: http://cygwin.com/contrib.html .

Sorry to make you jump through hoops for this.  It's a necessary evil.

cgf
