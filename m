Return-Path: <cygwin-patches-return-5631-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21015 invoked by alias); 28 Aug 2005 16:32:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21006 invoked by uid 22791); 28 Aug 2005 16:32:18 -0000
Received: from c-24-61-23-223.hsd1.ma.comcast.net (HELO cgf.cx) (24.61.23.223)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Sun, 28 Aug 2005 16:32:18 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id 570BD4A892C; Sun, 28 Aug 2005 12:32:17 -0400 (EDT)
Date: Sun, 28 Aug 2005 16:32:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Subject: Re: [Patch] readdir_r: fix sense of error-test.
Message-ID: <20050828163217.GC22564@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
References: <n2m-g.deqn2t.3vv7q2b.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.deqn2t.3vv7q2b.1@buzzy-box.bavag>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q3/txt/msg00086.txt.bz2

On Sat, Aug 27, 2005 at 09:58:47PM +0200, Bas van Gompel wrote:
>2005-08-27  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>
>
>	*dir.cc (readdir_r): Invert sense on error-test.

Applied.  Thanks.

cgf
