Return-Path: <cygwin-patches-return-5636-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19615 invoked by alias); 29 Aug 2005 03:15:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19605 invoked by uid 22791); 29 Aug 2005 03:15:07 -0000
Received: from c-24-61-23-223.hsd1.ma.comcast.net (HELO cgf.cx) (24.61.23.223)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 29 Aug 2005 03:15:07 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id 17D644A8A12; Sun, 28 Aug 2005 23:15:06 -0400 (EDT)
Date: Mon, 29 Aug 2005 03:15:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Subject: Re: [Patch] readdir_r: fix sense of error-test.
Message-ID: <20050829031506.GA32449@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
References: <n2m-g.deqn2t.3vv7q2b.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.deqn2t.3vv7q2b.1@buzzy-box.bavag>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q3/txt/msg00091.txt.bz2

On Sat, Aug 27, 2005 at 09:58:47PM +0200, Bas van Gompel wrote:
>(I'm still getting errors on the following testcase after applying
>this.  (try 0 err=7439xxx))

This is now fixed in CVS, btw.  I had a typo in cygwin.din where I had
readdir_r = readdir.  I discovered this by single stepping into the
place where readdir_r was being called finding that it was going to
readdir instead.

cgf
