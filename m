Return-Path: <cygwin-patches-return-7803-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9807 invoked by alias); 17 Feb 2013 13:42:03 -0000
Received: (qmail 9677 invoked by uid 22791); 17 Feb 2013 13:41:48 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Sun, 17 Feb 2013 13:41:43 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 0C70552034F; Sun, 17 Feb 2013 14:41:41 +0100 (CET)
Date: Sun, 17 Feb 2013 13:42:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] Fix speclib for x86_64
Message-ID: <20130217134141.GA12844@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20130217044622.1034ae22@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20130217044622.1034ae22@YAAKOV04>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2013-q1/txt/msg00014.txt.bz2

On Feb 17 04:46, Yaakov wrote:

> 2013-02-16  Yaakov Selkowitz  <yselkowitz@...>
> 
> 	* Makefile.in (libcygwin.a): Move --target flag from here...
> 	(toolopts): to here, to be used by both mkimport and speclib.
> 	* speclib: Omit leading underscore in symbol names on x86_64.

The Makefile patch is fine, but for the speclib change I wonder why
we should omit the leading underscore.  If you remove the underscore,
you're polluting the application namespace.  Is there really a good
reason to do that?  Did I miss something?


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat
