Return-Path: <cygwin-patches-return-5064-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 805 invoked by alias); 17 Oct 2004 23:33:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 796 invoked from network); 17 Oct 2004 23:33:43 -0000
Date: Sun, 17 Oct 2004 23:33:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] cygcheck: pretty_id misbehaving.
Message-ID: <20041017233423.GA8780@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <n2m-g.ckm5nu.3vvc0mv.1@buzzy-box.bavag> <20041014173621.GG22814@trixie.casa.cgf.cx> <n2m-g.ckol7v.3vshjpb.1@buzzy-box.bavag> <20041015135904.GD29569@trixie.casa.cgf.cx> <n2m-g.ckprr1.3vvf2a7.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.ckprr1.3vvf2a7.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00065.txt.bz2

On Sat, Oct 16, 2004 at 02:14:33AM +0200, Bas van Gompel wrote:
>Op Fri, 15 Oct 2004 09:59:04 -0400 schreef Christopher Faylor
>jj:  or to negate
>:  sz repeatedly inside of a loop.
>
>My plan was to not negate sz at all, use the printf format-flag ``-''.

Yes.  I get it.  This is a difference of opinion.

>Also, space needs to be allocated for the trailing `\0` on uid and
>gid, and notice there isn't a space at the end of the printf format.

I keep making this stupid mistake.  I have, again, checked in a variation
of your fix.  I think I got it right this time.

Thanks,
cgf
