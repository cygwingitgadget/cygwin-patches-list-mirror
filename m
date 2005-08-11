Return-Path: <cygwin-patches-return-5617-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24090 invoked by alias); 11 Aug 2005 17:03:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24048 invoked by uid 22791); 11 Aug 2005 17:03:42 -0000
Received: from c-24-61-23-223.hsd1.ma.comcast.net (HELO cgf.cx) (24.61.23.223)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Thu, 11 Aug 2005 17:03:42 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id B237C13C092; Thu, 11 Aug 2005 13:03:40 -0400 (EDT)
Date: Thu, 11 Aug 2005 17:03:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: Fix for errant tcgetattr() behavior
Message-ID: <20050811170340.GD6935@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <42FB831B.6090108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42FB831B.6090108@gmail.com>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q3/txt/msg00072.txt.bz2

On Thu, Aug 11, 2005 at 10:55:55AM -0600, Troy Curtiss wrote:
>Way back in 02/01/2003, a patch of mine was applied that enhanced 
>tcsetattr() to handle setting baud rate B0 correctly (ie. dropping DTR, 
>leave actual baud rate alone), but added some incorrect behavior in 
>tcgetattr().  The correct behavior, I believe, should be as follows:
>
>1) When a baud rate of B0 is passed to tcsetattr(), it should not change 
>the actual baud rate, but instead drop DTR.
>2) In tcgetattr(), the presently set baud rate should be returned, 
>regardless of the state of DTR.
>
>My earlier patch broke #2.  The attached patch fixes this error, and 
>tcgetattr() now returns the correct baud rate regardless of DTR state.  
>Thanks,
>
>Changelog entry:
>* fhandler_serial.cc (fhandler_serial::tcgetattr):  Make tcgetattr() 
>return current baud rate regardless of current DTR state.

Applied with a minor ChangeLog tweak.

Thanks.

cgf
