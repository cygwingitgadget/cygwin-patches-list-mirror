Return-Path: <cygwin-patches-return-6780-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30796 invoked by alias); 18 Oct 2009 09:07:37 -0000
Received: (qmail 30784 invoked by uid 22791); 18 Oct 2009 09:07:36 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 18 Oct 2009 09:07:32 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id D44F26D5598; Sun, 18 Oct 2009 11:07:21 +0200 (CEST)
Date: Sun, 18 Oct 2009 09:07:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Allow to disable root privileges with CYGWIN=noroot
Message-ID: <20091018090721.GB25560@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20091004200843.GK4563@calimero.vinschen.de> <4ACFAE4D.90502@t-online.de> <20091010100831.GA13581@calimero.vinschen.de> <4AD243ED.6080505@t-online.de> <20091013102502.GG11169@calimero.vinschen.de> <4AD4E38A.2050301@t-online.de> <20091014104003.GA24593@calimero.vinschen.de> <1My1yO-0KvdnE0@fwd09.aul.t-online.de> <20091014120237.GA27964@calimero.vinschen.de> <4AD9B646.5000906@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AD9B646.5000906@t-online.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00111.txt.bz2

On Oct 17 14:19, Christian Franke wrote:
> Observation: When Cygwin spawns a process with CreateProcessAsUser(), the 
> child process main thread has a token after startup.
>
> $ ./gettokinfo -t
> OpenThreadToken: 1008
>
> $ ./cygdrop ./gettokinfo -t
> Thread Token
> Type: Impersonation
> Impersonation Level: SecurityImpersonation
> ...
>
> The problem is that some calls (from _cygtls?) to user.reimpersonate() 
> appear between startup and uinfo_init(). uinfo_init() does not call 
> RevertToSelf() after closing the inherited token.
>
> Quick fix:
>
> @@ -155,7 +161,7 @@ uinfo_init ()
>    cygheap->user.curr_token_is_restricted = false;
>    cygheap->user.setuid_to_restricted = false;
>    cygheap->user.set_saved_sid ();      /* Update the original sid */
> -  cygheap->user.reimpersonate ();
> +  cygheap->user.deimpersonate ();
> }
>
> Typo ?

Oversight, it seems.  The reimpersonate call was ok in Cygwin 1.5 since
the process was always running under an impersonation token and
reimpersonate() looked different back then.

Thanks for catching!


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
