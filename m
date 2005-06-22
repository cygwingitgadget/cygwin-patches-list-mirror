Return-Path: <cygwin-patches-return-5543-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15450 invoked by alias); 22 Jun 2005 00:49:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15434 invoked by uid 22791); 22 Jun 2005 00:49:25 -0000
Received: from c-66-30-17-189.hsd1.ma.comcast.net (HELO cgf.cx) (66.30.17.189)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Wed, 22 Jun 2005 00:49:25 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id 4A4314A8347; Tue, 21 Jun 2005 20:49:24 -0400 (EDT)
Date: Wed, 22 Jun 2005 00:49:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] add -p option to cygcheck to query website package search
Message-ID: <20050622004924.GA28600@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <42B7215D.309F67EE@dessent.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B7215D.309F67EE@dessent.net>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q2/txt/msg00139.txt.bz2

On Mon, Jun 20, 2005 at 01:04:45PM -0700, Brian Dessent wrote:
>
>Here is a patch that implements the -p option to cygcheck that was mentioned on
>the list previously.  It uses the WinInet API to hit the package-grep.cgi URL on
>cygwin.com with the search regexp supplied by the user.

I appreciate your doing this Brian.  I won't be able to really investigate this
and comment on it until Saturday but I wanted to respond to your email, at least
so you would know the status.  I think that, on a quick inspection, the cygcheck
stuff is fine (and I like the rewording of the help) but I have a different idea
for how to handle the package_grep.cgi part but I need to do some more research.

cgf
