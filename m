Return-Path: <cygwin-patches-return-4994-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30992 invoked by alias); 24 Sep 2004 08:06:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30980 invoked from network); 24 Sep 2004 08:06:54 -0000
Date: Fri, 24 Sep 2004 08:06:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fake POSIX behaviour in seteuid/setegid
Message-ID: <20040924080750.GA9050@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20040923162537.GA944@cygbert.vinschen.de> <3.0.5.32.20040923223513.0082d3f0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040923223513.0082d3f0@incoming.verizon.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q3/txt/msg00146.txt.bz2

Hi Pierre,

On Sep 23 22:35, Pierre A. Humblet wrote:
> At 06:25 PM 9/23/2004 +0200, Corinna Vinschen wrote:
> >[about security fake]
> The patch does what you describe. The gid patch does not allow privileged
> users to change the gids any way they want, which is unusual.

Hmm, well, yes.  Changing the gid should be possible as often as you like
as long as your real or effective uid is equal to the original uid.
So, if we follow this through, the test in gid should check for the uid,
not the gid.  That would come closer, wouldn't it?

> What surprised me is that OpenSSH takes the trouble to check if reversion is
> impossible, although it's the standard POSIX behavior (well, not quite. POSIX
> mentions "appropriate privileges" of the process). There must be cases where
> it can be a problem. I assume it's not risky in Cygwin, because there will 
> soon be an exec that will insure security.

Note that this code is not only in portable OpenSSH, but also in the
stock OpenBSD version!

OpenSSH == paranoia :-)

> Given that there might be issues, I think it's not good practice to mask the
> real behavior when programs try to find what it is.

ACK.

Actually it was a team member of the OpenSSH team who asked me in PM,
what stops Cygwin to enforce this.  The argumentation was based on
portability, not on security.

I'm also not entirely convinced that this step is really going into
the right direction.  But I thin we should look on both sides of the
medal :-)

> Let me sleep on this!

Ok!

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
