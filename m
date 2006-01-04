Return-Path: <cygwin-patches-return-5694-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2729 invoked by alias); 4 Jan 2006 16:20:16 -0000
Received: (qmail 2688 invoked by uid 22791); 4 Jan 2006 16:20:16 -0000
X-Spam-Check-By: sourceware.org
Received: from cgf.cx (HELO cgf.cx) (24.61.23.223)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Wed, 04 Jan 2006 16:20:14 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 134B913C49C; Wed,  4 Jan 2006 11:20:13 -0500 (EST)
Date: Wed, 04 Jan 2006 16:20:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: managed mounts and "
Message-ID: <20060104162013.GA11749@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <loom.20060104T170724-189@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <loom.20060104T170724-189@post.gmane.org>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00003.txt.bz2

On Wed, Jan 04, 2006 at 04:09:03PM +0000, Eric Blake wrote:
>2006-01-04  Eric Blake  <ebb9@byu.net>
>
>	* path.cc (dot_special_chars): Add ", <, >, and |.

This patch did not apply cleanly but I have fixed it up and applied it.
Maybe submitting it as an attachment would help next time?  Also, I
think your previous patch messed with white space in the file so that
also required extra effort to apply.  FYI.

Thanks for this patch.

cgf
