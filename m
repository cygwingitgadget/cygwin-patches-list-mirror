Return-Path: <cygwin-patches-return-5399-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14339 invoked by alias); 30 Mar 2005 19:13:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14270 invoked from network); 30 Mar 2005 19:13:10 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 30 Mar 2005 19:13:10 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id D72FB13C8CE; Wed, 30 Mar 2005 14:13:10 -0500 (EST)
Date: Wed, 30 Mar 2005 19:13:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Problem with filenames ending in "." with check_case:strict
Message-ID: <20050330191310.GI4621@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.61.0503211850270.8708@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.61.0503211850270.8708@slinky.cs.nyu.edu>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q1/txt/msg00102.txt.bz2

On Wed, Mar 30, 2005 at 01:51:36PM -0500, Igor Pechtchanski wrote:
>ChangeLog:
>2005-03-21  Igor Pechtchanski  <pechtcha@cs.nyu.edu>
>
>	* path.cc (symlink_info::case_check): Ignore trailing characters
>	in paths when comparing case.

Doesn't this ignore all trailing characters so that "foo" could match "foobbbbb"?

cgf

>Index: winsup/cygwin/path.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
>retrieving revision 1.355
>diff -u -p -r1.355 path.cc
>--- winsup/cygwin/path.cc	12 Mar 2005 02:32:59 -0000	1.355
>+++ winsup/cygwin/path.cc	22 Mar 2005 00:46:23 -0000
>@@ -3217,6 +3217,7 @@ symlink_info::case_check (char *path)
>   WIN32_FIND_DATA data;
>   HANDLE h;
>   char *c;
>+  int len;
> 
>   /* Set a pointer to the beginning of the last component. */
>   if (!(c = strrchr (path, '\\')))
>@@ -3230,7 +3231,8 @@ symlink_info::case_check (char *path)
>       FindClose (h);
> 
>       /* If that part of the component exists, check the case. */
>-      if (strcmp (c, data.cFileName))
>+      len = strlen(data.cFileName);
>+      if (strncmp (c, data.cFileName, len))
> 	{
> 	  case_clash = true;
> 
