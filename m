Return-Path: <cygwin-patches-return-5578-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17964 invoked by alias); 19 Jul 2005 21:01:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17936 invoked by uid 22791); 19 Jul 2005 21:01:35 -0000
Received: from c-24-61-23-223.hsd1.ma.comcast.net (HELO cgf.cx) (24.61.23.223)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Tue, 19 Jul 2005 21:01:35 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id A5F2E13C261; Tue, 19 Jul 2005 17:01:34 -0400 (EDT)
Date: Tue, 19 Jul 2005 21:01:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: cygcheck .exe magic
Message-ID: <20050719210134.GD26817@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <loom.20050719T212315-901@post.gmane.org> <20050719200213.GA26440@trixie.casa.cgf.cx> <loom.20050719T222825-989@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <loom.20050719T222825-989@post.gmane.org>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q3/txt/msg00033.txt.bz2

On Tue, Jul 19, 2005 at 08:35:27PM +0000, Eric Blake wrote:
>Christopher Faylor <cgf-no-personal-reply-please <at> cygwin.com> writes:
>>Are you sure this is right?  cygcheck.exe isn't a cygwin program so I'd
>>wonder about the use of the inodes returned from windows stat() call.
>
>You have a point; revised patch attached.  The original worked for me
>in testing, but only because I was short-circuiting when the first stat
>failed, and appending the .exe happened to be the right thing to do.
>Since this is not a cygwin app, there is no .exe magic in stat() to
>counteract, and all we really need to do is see if appending the suffix
>makes stat succeed.

We don't really need stat() to do this checking since we're inspecting
anything in the stat structure.  So, I've rewritten this patch to just
use access() as other parts of cygcheck do.  It's been checked in.

Thanks,
cgf
