Return-Path: <cygwin-patches-return-2190-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24891 invoked by alias); 15 May 2002 12:22:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24862 invoked from network); 15 May 2002 12:21:57 -0000
Date: Wed, 15 May 2002 05:22:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: Security patches
Message-ID: <20020515142156.O2671@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <3.0.5.32.20020513232509.007f6350@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020513232509.007f6350@mail.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00174.txt.bz2

On Mon, May 13, 2002 at 11:25:09PM -0400, Pierre A. Humblet wrote:
> Hello Corinna,
> 
> This is the third installment. It fixes:
> 1) non-cygwin child processes always get the correct primary group
> 2) tighter check of whether an existing token should be reused
> 3) impersonated tasks now have access to their own token

What applications did you use for testing?  Just curious...

> There is another set of changes I'd like to make to address 
> two issues:
> [...]
> I don't know the history and motivation of this design, but
> it doesn't seem that clean. I would propose instead one of 

It is not that clean but the history is only a rudimentary
support of groups at all.  It was difficult enough to learn
how to change user context w/o password at all and how to
manipulate a token in a useful way.  No doubt, it's somewhat
unclean.

> 1) when ntsec is off, setuid() succeeds while doing almost nothing.
> The danger is that a privileged process will never give up
> its privileges.
> 2) setuid() and setgid() return in error on NT if ntsec isn't set.
> 3) no matter ntsec, setuid() / setgid() behave basically as they do 
> today when ntsec is set. They fail if the passwd file doesn't contain SIDs. 
> I would vote for 3, not seeing the advantage of 2.
> What's your opinion?

I agree. 3) is the way to go.  I've no example handy but switching
to 2) might break apps which work fine on the commandline otherwise.

I'm looking through your patches (including your today's security.cc
update).  I will apply them perhaps tomorrow, trying to understand
them first.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
