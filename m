Return-Path: <cygwin-patches-return-5627-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5222 invoked by alias); 17 Aug 2005 15:32:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5202 invoked by uid 22791); 17 Aug 2005 15:32:43 -0000
Received: from c-24-61-23-223.hsd1.ma.comcast.net (HELO cgf.cx) (24.61.23.223)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Wed, 17 Aug 2005 15:32:43 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id 2A1B113C882; Wed, 17 Aug 2005 11:32:42 -0400 (EDT)
Date: Wed, 17 Aug 2005 15:32:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix for sending SIGHUP when the pty master side is close()-ed
Message-ID: <20050817153242.GD10757@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0508171731330.1696@mordor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0508171731330.1696@mordor>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q3/txt/msg00082.txt.bz2

On Wed, Aug 17, 2005 at 06:30:25PM +0300, Pavel Tsekov wrote:
>The attached patch solves this problem by rearranging the code a bit. It
>tries to be non-intrusive. I offer it for discussion and comments. I hope
>that my description of the problem and the patch will help to resolve the
>issue even if the patch will get rejected in favour of a better one.

It seems like your description and your rearrangement are probably
correct.  This is a classic race.

Want to provide a changelog?

cgf
