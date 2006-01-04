Return-Path: <cygwin-patches-return-5695-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6152 invoked by alias); 4 Jan 2006 16:24:40 -0000
Received: (qmail 6142 invoked by uid 22791); 4 Jan 2006 16:24:40 -0000
X-Spam-Check-By: sourceware.org
Received: from cgf.cx (HELO cgf.cx) (24.61.23.223)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Wed, 04 Jan 2006 16:24:39 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id D158A13C49C; Wed,  4 Jan 2006 11:24:37 -0500 (EST)
Date: Wed, 04 Jan 2006 16:24:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Testing loads of cygwin1.dll from MinGW and MSVC, take3
Message-ID: <20060104162437.GB11749@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1118256244.5031.2661.camel@fulgurite> <SERRANOuabjKoMFYsDS000003d2@SERRANO.CAM.ARTIMI.COM> <20050610171359.GD17201@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050610171359.GD17201@trixie.casa.cgf.cx>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00004.txt.bz2

On Fri, Jun 10, 2005 at 01:13:59PM -0400, Christopher Faylor wrote:
>On Fri, Jun 10, 2005 at 06:11:38PM +0100, Dave Korn wrote:
>>Look, if it's getting complicated and tricky, that argues for a bit of
>>a rethink / redesign, doesn't it?
>
>Yes.  I was wondering why we were going down this path when we've both
>noted that maybe it wasn't a good idea.
>
>I would still prefer a generic "mingw" solution which is integrated with
>the rest of the test suite.

I thought waiting six months for this solution was probably long enough
so I've implemented something like this in the current test suite.  So,
after moving stuff out of the cygload directory and into the winsup.api
directory, this means that cygload is run during the normal execution of
the test suite rather than as a separate step.

cgf
