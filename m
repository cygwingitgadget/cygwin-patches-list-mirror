Return-Path: <cygwin-patches-return-5400-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17097 invoked by alias); 30 Mar 2005 19:18:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17055 invoked from network); 30 Mar 2005 19:18:12 -0000
Received: from unknown (HELO slinky.cs.nyu.edu) (128.122.20.14)
  by sourceware.org with SMTP; 30 Mar 2005 19:18:12 -0000
Received: from localhost (localhost [127.0.0.1])
	by slinky.cs.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id j2UJICW3010567
	for <cygwin-patches@cygwin.com>; Wed, 30 Mar 2005 14:18:12 -0500 (EST)
Date: Wed, 30 Mar 2005 19:18:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Problem with filenames ending in "." with check_case:strict
In-Reply-To: <20050330191310.GI4621@trixie.casa.cgf.cx>
Message-ID: <Pine.GSO.4.61.0503301415210.2428@slinky.cs.nyu.edu>
References: <Pine.GSO.4.61.0503211850270.8708@slinky.cs.nyu.edu>
 <20050330191310.GI4621@trixie.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2005-q1/txt/msg00103.txt.bz2

On Wed, 30 Mar 2005, Christopher Faylor wrote:

> On Wed, Mar 30, 2005 at 01:51:36PM -0500, Igor Pechtchanski wrote:
> >ChangeLog:
> >2005-03-21  Igor Pechtchanski  <pechtcha@cs.nyu.edu>
> >
> >	* path.cc (symlink_info::case_check): Ignore trailing characters
> >	in paths when comparing case.
>
> Doesn't this ignore all trailing characters so that "foo" could match
> "foobbbbb"?

It could, but it won't.  The two strings being compared are the original
filename,and the filename returned by Windows when trying to find the
original filename.  If they differ this drastically, the comparison will
never happen.
	Igor

> >Index: winsup/cygwin/path.cc
> >===================================================================
> >RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
> >retrieving revision 1.355
> >diff -u -p -r1.355 path.cc
> >--- winsup/cygwin/path.cc	12 Mar 2005 02:32:59 -0000	1.355
> >+++ winsup/cygwin/path.cc	22 Mar 2005 00:46:23 -0000
> >@@ -3230,7 +3231,8 @@ symlink_info::case_check (char *path)
> >       FindClose (h);
> >
> >       /* If that part of the component exists, check the case. */
> >-      if (strcmp (c, data.cFileName))
> >+      len = strlen(data.cFileName);
> >+      if (strncmp (c, data.cFileName, len))
> > 	{
> > 	  case_clash = true;

-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"The Sun will pass between the Earth and the Moon tonight for a total
Lunar eclipse..." -- WCBS Radio Newsbrief, Oct 27 2004, 12:01 pm EDT
