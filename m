Return-Path: <cygwin-patches-return-5551-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4967 invoked by alias); 3 Jul 2005 02:06:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4781 invoked by uid 22791); 3 Jul 2005 02:06:44 -0000
Received: from c-24-61-23-223.hsd1.ma.comcast.net (HELO cgf.cx) (24.61.23.223)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Sun, 03 Jul 2005 02:06:44 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id 532DF13C0D2; Sat,  2 Jul 2005 22:06:38 -0400 (EDT)
Date: Sun, 03 Jul 2005 02:06:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] add -p option to cygcheck to query website package search
Message-ID: <20050703020638.GA18348@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <42B7215D.309F67EE@dessent.net> <20050622004924.GA28600@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050622004924.GA28600@trixie.casa.cgf.cx>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q3/txt/msg00006.txt.bz2

On Tue, Jun 21, 2005 at 08:49:24PM -0400, Christopher Faylor wrote:
>On Mon, Jun 20, 2005 at 01:04:45PM -0700, Brian Dessent wrote:
>>Here is a patch that implements the -p option to cygcheck that was
>>mentioned on the list previously.  It uses the WinInet API to hit the
>>package-grep.cgi URL on cygwin.com with the search regexp supplied by
>>the user.
>
>I appreciate your doing this Brian.  I won't be able to really
>investigate this and comment on it until Saturday but I wanted to
>respond to your email, at least so you would know the status.  I think
>that, on a quick inspection, the cygcheck stuff is fine (and I like the
>rewording of the help) but I have a different idea for how to handle
>the package_grep.cgi part but I need to do some more research.

As is probably obvious, I didn't do this last Saturday.

I am going to hold off putting this in 1.5.18 but it will be in 1.5.19,
as soon as I modify the perl script on sourceware.org.

cgf
