Return-Path: <cygwin-patches-return-5661-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28894 invoked by alias); 14 Oct 2005 02:16:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28828 invoked by uid 22791); 14 Oct 2005 02:16:09 -0000
Received: from c-24-61-23-223.hsd1.ma.comcast.net (HELO cgf.cx) (24.61.23.223)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Fri, 14 Oct 2005 02:16:09 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id 1CFF213C101; Fri, 14 Oct 2005 02:15:58 +0000 (UTC)
Date: Fri, 14 Oct 2005 02:16:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] Create directories with 755 instead of 644.
Message-ID: <20051014021558.GA4476@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <434EC646.2070800@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <434EC646.2070800@acm.org>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q4/txt/msg00003.txt.bz2

On Thu, Oct 13, 2005 at 01:40:38PM -0700, David Rothenberger wrote:
>I attempted to build the Cygwin DLL from CVS today and encountered 
>permission denied errors from the install target in winsup/cygwin. The 
>problem appears to be that directories are precreated using "install -m 
>644". With 644 permissions, subsequent install calls to copy files to 
>those directories fail.

Sigh.  Yes, this is a recent problem.

>The following patch fixed the problem for me.

Your patch translates to using "install -m 644 -m 755".

I'll check in a variation which just uses install -d, as I intended.

>ChangeLog for winsup/cygwin:
>
>2005-10-13  David Rothenberger <daveroth@acm.org>
>
>	* Makefile.in:  Create directories with 755 permissions.

Thanks for the patch.

cgf
