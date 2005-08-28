Return-Path: <cygwin-patches-return-5635-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4072 invoked by alias); 28 Aug 2005 21:42:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4054 invoked by uid 22791); 28 Aug 2005 21:42:49 -0000
Received: from c-24-61-23-223.hsd1.ma.comcast.net (HELO cgf.cx) (24.61.23.223)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Sun, 28 Aug 2005 21:42:49 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id 6725D4A8973; Sun, 28 Aug 2005 17:42:48 -0400 (EDT)
Date: Sun, 28 Aug 2005 21:42:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Subject: Re: [Patch] readdir_r: fix sense of error-test.
Message-ID: <20050828214248.GA26787@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
References: <n2m-g.deqn2t.3vv7q2b.1@buzzy-box.bavag> <20050828171644.GA23108@trixie.casa.cgf.cx> <n2m-g.deth4p.3vv9c19.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.deth4p.3vv9c19.1@buzzy-box.bavag>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q3/txt/msg00090.txt.bz2

On Sun, Aug 28, 2005 at 11:22:30PM +0200, Bas van Gompel wrote:
>Op Sun, 28 Aug 2005 13:16:44 -0400 schreef Christopher Faylor
>in <20050828171644.GA23108@trixie.casa.cgf.cx>:
>:  On Sat, Aug 27, 2005 at 09:58:47PM +0200, Bas van Gompel wrote:
>: > If you want to see why this really does not require a copyright-
>: > assignment, view the diff with testsuite/winsup.api/ltp/readdir01.c,
>: > and remove all parts which are just comments.
>:
>:   Btw, you can't just grab someone else's source code and put your
>:  own copyright on it.
>
>Right. Any suggestion as to how better approach this?

I don't know.

Maybe put something like "adapted for readdir_r by ..." in the initial
comment.

cgf
