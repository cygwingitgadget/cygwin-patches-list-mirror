Return-Path: <cygwin-patches-return-5213-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1061 invoked by alias); 16 Dec 2004 15:51:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 887 invoked from network); 16 Dec 2004 15:51:31 -0000
Received: from unknown (HELO cygbert.vinschen.de) (80.132.119.93)
  by sourceware.org with SMTP; 16 Dec 2004 15:51:31 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id D609A5808D; Thu, 16 Dec 2004 16:53:39 +0100 (CET)
Date: Thu, 16 Dec 2004 15:51:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to allow trailing dots on managed mounts
Message-ID: <20041216155339.GA16474@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <41C1A1F4.CD3CC833@phumblet.no-ip.org> <20041216150040.GA23488@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041216150040.GA23488@trixie.casa.cgf.cx>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q4/txt/msg00214.txt.bz2

On Dec 16 10:00, Christopher Faylor wrote:
> On Thu, Dec 16, 2004 at 09:55:48AM -0500, Pierre A. Humblet wrote:
> >Here is an untested patch.
> >I hope Mark can test it (on managed and unmanaged mounts,
> >including basenames consisting entirely of dots and spaces)
> >and possibly make adjustments, without having to file the 
> >paperwork.
> >
> >Pierre
> >
> >	* path.cc (path_conv::check): Do not strip trailing dots and spaces.
> >	* fhandler.cc (fhandler_base::open): Strip trailing dots and spaces.
> 
> Is it correct to assume that only fhandler_base::open cares about
> trailing dots?

So far, yes.  But somehow moving this code into open() looks a bit like
a step backwards to me.  The general direction is to do more stuff using
NT functions, isn't it?  So in the long run we would get the same problem
in other code paths as well.

Since the mount code is called from path_conv anyway, wouldn't it be
better to pass the information "managed mount or not" up to path_conv?
Actually, the information should be "don't mangle pathnames further" or
some such.  This would allow a new mount point type along the lines of
"NTFS/Posix", which would allow to use unchanged pathnames in mounted NTFS
directories.  This would not only affect trailing dots and spaces, also
"aux.c" comes to mind.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
