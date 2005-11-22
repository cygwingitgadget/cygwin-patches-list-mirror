Return-Path: <cygwin-patches-return-5677-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14641 invoked by alias); 22 Nov 2005 17:25:44 -0000
Received: (qmail 14618 invoked by uid 22791); 22 Nov 2005 17:25:43 -0000
X-Spam-Check-By: sourceware.org
Received: from cgf.cx (HELO cgf.cx) (24.61.23.223)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Tue, 22 Nov 2005 17:25:43 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 8304013C1B0; Tue, 22 Nov 2005 12:25:40 -0500 (EST)
Date: Tue, 22 Nov 2005 17:25:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] add -p option to cygcheck to query website package search
Message-ID: <20051122172540.GA21639@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <42B7215D.309F67EE@dessent.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B7215D.309F67EE@dessent.net>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2005-q4/txt/msg00019.txt.bz2

On Mon, Jun 20, 2005 at 01:04:45PM -0700, Brian Dessent wrote:
>Here is a patch that implements the -p option to cygcheck that was
>mentioned on the list previously.  It uses the WinInet API to hit the
>package-grep.cgi URL on cygwin.com with the search regexp supplied by
>the user.

Five+ months later, I've checked in (most of) this patch to cygcheck.cc
and the documentation.

It seems like the bug fix that was in the patch was no longer needed
since it didn't apply and the code around the fix had changed.

One reason for the delay was that I wanted to do things a little
differently in package-grep.cgi.  I think I've done that, with the help
of HTML::TreeBuilder.  So, there is now a "text" option to this script,
similar to your patch, which will just dump raw text.

Another reason for the delay was that I didn't want to add another way
to overload the old sourceware.org.  However, the new system is
perfectly capable of handling anything we can throw at it for the
foreseeable future, so this seemed like a good time to implement this
functionality.

Other than that, your patch just went in as-is.  I'm going to make a
snapshot with this change in it soon, Brian, so if you have some new
insights after five months, please let me know so that I can incorporate
them.

I apologize for the very long lag time in getting this patch in. I do
appreciate your addition of this functionality to cygcheck.exe.  I hope
that it will be a useful addition to our bag of tech support tricks.

Thanks again.

cgf
