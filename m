Return-Path: <cygwin-patches-return-5852-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16579 invoked by alias); 19 May 2006 15:30:34 -0000
Received: (qmail 16568 invoked by uid 22791); 19 May 2006 15:30:33 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-19.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.19)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 19 May 2006 15:30:33 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 7998213C020; Fri, 19 May 2006 11:30:31 -0400 (EDT)
Date: Fri, 19 May 2006 15:30:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Open sockets non-overlapped?
Message-ID: <20060519153031.GB30564@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <ba40711f0605190819h4dfc5870l18a1919149a4f2d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba40711f0605190819h4dfc5870l18a1919149a4f2d9@mail.gmail.com>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00040.txt.bz2

On Fri, May 19, 2006 at 11:19:45AM -0400, Lev Bishop wrote:
>Here's a trivial little patch for your consideration (while I wait for
>my copyright assignment to go through).
>
>It makes it so that cygwin sockets can be passed usefully to windows
>processes. Eg:
>$ cmd /c dir > /dev/tcp/localhost/5001

AFAIK, /dev/tcp/localhost is neither a linux nor a cygwin construction.

In any event, it will be a while before this patch can be reviewed since
Corinna is in the hospital for a couple of weeks and won't be able to look
at cygwin stuff.

cgf
