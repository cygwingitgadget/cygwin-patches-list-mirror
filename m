Return-Path: <cygwin-patches-return-2920-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 25476 invoked by alias); 3 Sep 2002 12:22:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25462 invoked from network); 3 Sep 2002 12:22:25 -0000
Date: Tue, 03 Sep 2002 05:22:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: procps
Message-ID: <20020903142147.A12899@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <200209031132.43008.chris@atomice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209031132.43008.chris@atomice.net>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00368.txt.bz2

On Tue, Sep 03, 2002 at 11:32:43AM +0100, Christopher January wrote:
> The flaw is actually in the /proc fhandler. The /proc implementation should be 
> compatible with the Linux one and hence Linux /proc-based utilities (e.g. 
> procps). The problem is that procps reports the effective user ID in the user 
> ID column and the /proc fhandler currently reports the effective user ID as 
> the user ID of the calling process (this is probably incorrect).
> The procps utilities have only been modified to compile on Cygwin. They 
> haven't been changed in any other way. Therefore if they report the wrong 
> values it is the /proc fhandler that is at fault, not the procps package, 
> because the /proc fhandler should behave just like the Linux /proc filesystem 
> that the procps utilities were written for.
> Hope that makes sense!

I don't understand that description.  You saw my example.  cygrunsrv
runs under SYSTEM account, uid 18.  /proc/PID/uid reports 18, so why
does procps, which should obviously get it's values from the /proc
interface, doesn't report 18/SYSTEM as uid?

Confused,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
