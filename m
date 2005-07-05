Return-Path: <cygwin-patches-return-5554-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28784 invoked by alias); 5 Jul 2005 20:53:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28771 invoked by uid 22791); 5 Jul 2005 20:53:44 -0000
Received: from c-24-61-23-223.hsd1.ma.comcast.net (HELO cgf.cx) (24.61.23.223)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Tue, 05 Jul 2005 20:53:44 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id 893D313C12A; Tue,  5 Jul 2005 16:53:34 -0400 (EDT)
Date: Tue, 05 Jul 2005 20:53:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: cygcheck exit status
Message-ID: <20050705205334.GA12357@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <loom.20050705T224501-8@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <loom.20050705T224501-8@post.gmane.org>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q3/txt/msg00009.txt.bz2

On Tue, Jul 05, 2005 at 08:49:06PM +0000, Eric Blake wrote:
>@@ -1677,7 +1681,7 @@ main (int argc, char **argv)
>       {
>        if (i)
>          puts ("");
>-       cygcheck (argv[i]);
>+       ok &= cygcheck (argv[i]);

Why are you anding the result here?  Why not just set ok = cygcheck (...)?

cgf
