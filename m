Return-Path: <cygwin-patches-return-5762-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22498 invoked by alias); 17 Feb 2006 11:31:05 -0000
Received: (qmail 22483 invoked by uid 22791); 17 Feb 2006 11:31:04 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Fri, 17 Feb 2006 11:31:03 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 960D2544001; Fri, 17 Feb 2006 12:31:00 +0100 (CET)
Date: Fri, 17 Feb 2006 11:31:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygcheck: follow symbolic links
Message-ID: <20060217113100.GT26541@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.63.0602131341020.17217@access1.cims.nyu.edu> <20060216160637.GQ26541@calimero.vinschen.de> <Pine.GSO.4.63.0602161116540.22053@access1.cims.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.63.0602161116540.22053@access1.cims.nyu.edu>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00071.txt.bz2

On Feb 16 12:26, Igor Peshansky wrote:
> On Thu, 16 Feb 2006, Corinna Vinschen wrote:
> > - Most of your patch should go into path.cc so it can be reused, for
> >   instance in strace.
> 
> Agreed -- that's why I put that TODO in there. :-)  Should I move it in
> the next iteration of the patch?

Please move it now.  I don't think it's non-trivial enough to justify
multiple iterations.

> > - Couldn't you just reuse the readlink implementation in ../cygwin/path.cc
> >   as is, to avoid having to different implementations?
> 
> Umm, most of that code is very general purpose, and has too much extra
> stuff in it.  I basically used part of it (symlink_info::check_shortcut)
> for my implementation.  I wanted something lightweight and easy to
> understand (also, the code in path.cc doesn't check for PE headers, so I
> had to write that part anyway).

Well, what I meant isn't readlink but symlink_info::check_shortcut and
cmp_shortcut_header.  It would be helpful if the rules to identify a
symlink are identical, wouldn't it?  As for the PE headers, that's fine.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
