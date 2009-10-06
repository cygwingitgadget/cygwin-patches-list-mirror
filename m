Return-Path: <cygwin-patches-return-6721-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26996 invoked by alias); 6 Oct 2009 18:24:47 -0000
Received: (qmail 26983 invoked by uid 22791); 6 Oct 2009 18:24:46 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-48-2.bstnma.east.verizon.net (HELO cgf.cx) (173.76.48.2)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 06 Oct 2009 18:24:34 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 79F5A3B0002 	for <cygwin-patches@cygwin.com>; Tue,  6 Oct 2009 14:24:24 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 776162B352; Tue,  6 Oct 2009 14:24:24 -0400 (EDT)
Date: Tue, 06 Oct 2009 18:24:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fix tcgetpgrp output
Message-ID: <20091006182424.GE18135@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20091006090853.GJ12789@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091006090853.GJ12789@calimero.vinschen.de>
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
X-SW-Source: 2009-q4/txt/msg00052.txt.bz2

On Tue, Oct 06, 2009 at 11:08:53AM +0200, Corinna Vinschen wrote:
>Hi,
>
>
>I'd like to have your opinion for this patch before I check it in, since
>I'm not sure this is the right way to fix it.
>
>When I debugged the luit/tcsh problem yesterday, I found that the
>tcgetpgrp function does not behave as advertised.
>
>Per POSIX, the tcgetpgrp function returns the pgrp ID only if the file
>descriptor references the controlling tty of the process.  If the
>process has no ctty, or if the descriptor references another tty not
>being the controlling tty, the function is supposed to set errno to
>ENOTTY and return -1.

Ouch.  I can't believe that behavior has lasted for so long.

The patch looks good to me.

cgf
