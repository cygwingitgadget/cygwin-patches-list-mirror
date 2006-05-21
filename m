Return-Path: <cygwin-patches-return-5862-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7257 invoked by alias); 21 May 2006 21:18:36 -0000
Received: (qmail 7179 invoked by uid 22791); 21 May 2006 21:18:27 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-19.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.19)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 21 May 2006 21:18:03 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id DBA3713C01F; Sun, 21 May 2006 17:18:01 -0400 (EDT)
Date: Sun, 21 May 2006 21:18:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Using newer autoconf in src/winsup directory
Message-ID: <20060521211801.GB26270@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <200605042047.NAA19831@hpsje.cup.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605042047.NAA19831@hpsje.cup.hp.com>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00050.txt.bz2

On Thu, May 04, 2006 at 01:47:25PM -0700, Steve Ellcey wrote:
>I have been working to move the src tree at soureware.org to a newer
>version of autoconf.  The reason for this is so that we can, in turn,
>move to a newer version of libtool.  Would it be possible to rebuild the
>configure scripts in src/winsup with a recent version of autoconf, like
>autoconf 2.59?  Most parts of the src tree have already moved to this
>version.

I tried to rebuild the top-level configure.in with autoconf 2.59 but
there were a few complaints.  If you have patches to deal with the
problems updating to a newer version, they would be appreciated.
Otherwise, I'll probably wait for someone who knows more about autoconf
to offer changes.

cgf
