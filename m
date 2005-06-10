Return-Path: <cygwin-patches-return-5541-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24991 invoked by alias); 10 Jun 2005 17:14:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24979 invoked by uid 22791); 10 Jun 2005 17:14:00 -0000
Received: from c-66-30-17-189.hsd1.ma.comcast.net (HELO cgf.cx) (66.30.17.189)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Fri, 10 Jun 2005 17:14:00 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id B173E13C0A8; Fri, 10 Jun 2005 13:13:59 -0400 (EDT)
Date: Fri, 10 Jun 2005 17:14:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Testing loads of cygwin1.dll from MinGW and MSVC, take3
Message-ID: <20050610171359.GD17201@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1118256244.5031.2661.camel@fulgurite> <SERRANOuabjKoMFYsDS000003d2@SERRANO.CAM.ARTIMI.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SERRANOuabjKoMFYsDS000003d2@SERRANO.CAM.ARTIMI.COM>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q2/txt/msg00137.txt.bz2

On Fri, Jun 10, 2005 at 06:11:38PM +0100, Dave Korn wrote:
>Look, if it's getting complicated and tricky, that argues for a bit of
>a rethink / redesign, doesn't it?

Yes.  I was wondering why we were going down this path when we've both
noted that maybe it wasn't a good idea.

I would still prefer a generic "mingw" solution which is integrated with
the rest of the test suite.

cgf
