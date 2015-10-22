Return-Path: <cygwin-patches-return-8259-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 127770 invoked by alias); 22 Oct 2015 15:38:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 127735 invoked by uid 89); 22 Oct 2015 15:38:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.2 required=5.0 tests=AWL,BAYES_50,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=no version=3.3.2
X-Spam-User: qpsmtpd, 2 recipients
X-HELO: mout.gmx.net
Received: from mout.gmx.net (HELO mout.gmx.net) (212.227.15.15) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Thu, 22 Oct 2015 15:38:55 +0000
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0Lp3x6-1aU95L1CIG-00eqBt; Thu, 22 Oct 2015 17:38:51 +0200
Date: Thu, 22 Oct 2015 15:38:00 -0000
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Corinna Vinschen <corinna-cygwin@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Allow overriding the home directory via the HOME variable
In-Reply-To: <20151021183209.GF17374@calimero.vinschen.de>
Message-ID: <alpine.DEB.1.00.1510221731250.31610@s15462909.onlinehome-server.info>
References: <0Lg1Tn-1YnzUw0ScN-00pcgi@mail.gmx.com> <20151021183209.GF17374@calimero.vinschen.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-UI-Out-Filterresults: notjunk:1;V01:K0:zXkQHSF9Hag=:2cvPfAWDXRHFTMgZmQSO0e x/F6Z/suzLBsKV9Ud92wijtuUGU8GwcLPOC+vV7OcIVn0T394248BzCylFcml6FljXguvuwYQ oyQzYwaqR4mSJbsknxKyA+i8Cp9UXHBfqSpvg0Im9O0incZvdOwx02bICrAYFRKvIhHw4YFt4 l5yNAiHuPunFuNJ8hsAwhKCXvQdxapvUjRrG2wGc1eASMYTgoCTjdOdHLljc9umwTdr2i3o6W kXCjHwVHSOmpylJcwSrBar8SGXv2usXp2ERCMq5tkV2/tQY2Wk7llBjF62TnsZzm8DmT7d+fL h7BWSZgYMxfkuu1pAoGrI3e3CQGNil068/4JesAP3HOqU/7cyQr5ewBZ9gEU8vFs0Nw7Sw8k7 1Mu2Mw8w5exI5nHM6qqCQJtMXbefl/ahQicmrIW/pxPbo2VZsao2XHWzXPoLJMpQDW8dqBRm1 mCuKKxBENvVAM13bGkIuQiohRq/WhFD0+6zgohgTXzPwsbwOhlJ/zo7+i6bqbY5KuSQVwDcLM g6aV0e20uzW7oyRh9gynB9KZk7euextWunR4bXXDzCan7AgDkonNRKPFt/v2KejONqWv1S7iD zlmhPsy6almIqvowvHjstbvALJflLfLfu9gP+Dx9RDkRIhz+bJi+fUqK9+l6Q0K7IkMTQ2wKx QoB6t8dG4pqJhs8UDhA2kc458xAAELETO0WjPlzSGxG37eYvj7wNztXPmObJsDk2WLXHNrY9/ MSsRo6U5MkeC4ZGIpqIdAQb2zv1nGnTsblBQQRN0GHe5F2AxYOPrS3zY8WCcajbMGXcM/HCFS WXKWWug
X-IsSubscribed: yes
X-SW-Source: 2015-q4/txt/msg00012.txt.bz2

Hi Corinna,

On Wed, 21 Oct 2015, Corinna Vinschen wrote:

> On Sep 16 15:06, Johannes Schindelin wrote:
> > 	* uinfo.cc (cygheap_pwdgrp::get_home): Offer an option in
> > 	nsswitch.conf that let's the environment variable HOME (or
> > 	HOMEDRIVE & HOMEPATH, or USERPROFILE) define the home
> > 	directory.
> > 
> > 	* ntsec.xml: Document the `env` schema.
> > 
> > Detailed comments:
> > 
> > In the context of Git for Windows, it is a well-established technique
> > to let the `$HOME` variable define where the current user's home
> > directory is, falling back to `$HOMEDRIVE$HOMEPATH` and `$USERPROFILE`.
> > 
> > The idea is that we want to share user-specific settings between
> > programs, whether they be Cygwin, MSys2 or not.  Unfortunately, we
> > cannot blindly activate the "db_home: windows" setting because in some
> > setups, the user's home directory is set to a hidden directory via an
> > UNC path (\\share\some\hidden\folder$) -- something many programs
> > cannot handle correctly.
> 
> -v, please.  Which applications can't handle that?  Why do we have to
> care?

Oh, the first one that comes to mind is `cmd.exe`. You cannot start
`cmd.exe` with a UNC working directory without getting complaints.

> > The established technique is to allow setting the user's home directory
> > via the environment variables mentioned above.  This has the additional
> > advantage that it is much faster than querying the Windows user database.
> 
> But it's wrong.  We discussed this a couple of times on the Cygwin ML.
> The underlying functionality generically implements the passwd entries.
> Your "env" setting will return the same $HOME setting in the pw_dir
> field for every user account.

No, it will not, because most users are not administrators. So they can
only set environment variables for themselves.

In most cases, `HOME` will not even be defined, but `HOMEDRIVE` and
`HOMEPATH` will, and they will be correct.

> All user accounts will have the same home dir as your current user.  And
> the value is unreliable, too.  If another user logs in, all accounts
> will have another $HOME, the one from the now logged in user.  This is
> so wrong and potentially dangerous that I don't think this belongs into
> Cygwin, sorry.

I ask you to reconsider. I am not trying to make this the default. And I
*need* a way to heed the `HOME` variable set by the user. For
backwards-compatibility with Git for Windows 1.x, where users frequently
adjusted the `HOME` variable to fix problems with MSys not handling their
home directory properly.

The patch itself is so simple that it cannot possibly cause a maintenance
burden, and by offering this feature as opt-in, users who are in need of
that feature can easily use it -- in Cygwin, MSys2, and yes, in Git for
Windows.

It would bring a major benefit to us.

Ciao,
Johannes
