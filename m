Return-Path: <cygwin-patches-return-5757-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18168 invoked by alias); 16 Feb 2006 15:09:07 -0000
Received: (qmail 18158 invoked by uid 22791); 16 Feb 2006 15:09:07 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Thu, 16 Feb 2006 15:09:04 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 92F81544001; Thu, 16 Feb 2006 16:09:01 +0100 (CET)
Date: Thu, 16 Feb 2006 15:09:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add -p option to ps command
Message-ID: <20060216150901.GP26541@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20060216075828.fb30e530d17747c2b054d625b8945d88.f6da7960fc.wbe@email.secureserver.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060216075828.fb30e530d17747c2b054d625b8945d88.f6da7960fc.wbe@email.secureserver.net>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00066.txt.bz2

On Feb 16 07:58, Jerry D. Hedden wrote:
> Thanks.  I realized one minor oversight.  Using -p should imply -a so
> that even if the PID is not owned by the current user, it will still
> get listed.  I've attached a patch for this (just a one line addition)
> that builds on top of the previous patch (i.e., apply it against
> version 1.20 of ps.cc).  Thanks again.

> Index: src/winsup/utils/ps.cc
> ===================================================================
> --- ps.cc  1.20
> +++ ps.cc
> @@ -286,6 +286,7 @@
>  	break;
>        case 'p':
>  	proc_id = atoi (optarg);
> +	aflag = 1;
>  	break;
>        case 's':
>  	sflag = 1;

What about the ChangeLog entry?  http://cygwin.com/contrib.html


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
