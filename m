Return-Path: <cygwin-patches-return-6998-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7485 invoked by alias); 2 Mar 2010 18:09:29 -0000
Received: (qmail 7471 invoked by uid 22791); 2 Mar 2010 18:09:27 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 02 Mar 2010 18:09:24 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id B8E036D42F5; Tue,  2 Mar 2010 19:09:21 +0100 (CET)
Date: Tue, 02 Mar 2010 18:09:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add xdr support
Message-ID: <20100302180921.GO5683@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B764A1F.6060003@cwilson.fastmail.fm>  <4B8D2F9D.4090309@cwilson.fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B8D2F9D.4090309@cwilson.fastmail.fm>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00114.txt.bz2

On Mar  2 10:32, Charles Wilson wrote:
> Charles Wilson wrote:
> > The attached patch(es) add XDR support to cygwin. eXternal Data
> 
> Now that newlib has accepted the XDR patches, the following simply
> exports those symbols. It also ensures that the (rare) xdr error
> messages are handled by cygwin as they are in glibc: print them to
> stderr (unlike the previous patch, which printed them to cygwin's debug
> strace).
> 
> I know we're in the run-up to 1.7.2, so it may be prudent to delay these
> changes until after that, which is fine by me.

These functions don't interfere with existing functionality at all,
so I don't see a reason to keep them out of 1.7.2...

> 2010-03-02  Charles Wilson  <...>
> 
> 	Add XDR support.
> 	* cygwin.din: Export xdr functions.
> 	* include/cygwin/version.h: Bump version.
> 	* cygxdr.cc: New.
> 	* cygxdr.h: New.
> 	* dcrt0.cc (dll_crt0_1): Print the (rare) xdr-related
> 	error messages to stderr.
> 	* Makefile.in: Add cygxdr.

...and I would *love* to apply the patches, but unfortunately there's a
serious, VERY serious problem with this patch.

The patch is missing the related changes to cygwin/posix.sgml and
doc/new-features.sgml.

Would you mind to send a second patch for the documentation?


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
