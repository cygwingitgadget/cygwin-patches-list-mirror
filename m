Return-Path: <cygwin-patches-return-7530-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31878 invoked by alias); 13 Oct 2011 14:43:19 -0000
Received: (qmail 31837 invoked by uid 22791); 13 Oct 2011 14:42:58 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 13 Oct 2011 14:42:44 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C30352CBDB1; Thu, 13 Oct 2011 16:42:41 +0200 (CEST)
Date: Thu, 13 Oct 2011 14:43:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add cygwin_internal CW_GET_MODULE_PATH_FOR_ADDR
Message-ID: <20111013144241.GA22854@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4E96F392.9030605@cwilson.fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4E96F392.9030605@cwilson.fastmail.fm>
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
X-SW-Source: 2011-q4/txt/msg00020.txt.bz2

On Oct 13 10:20, Charles Wilson wrote:
> >From discussions with Bruno Haible about the slowness of full relocation
> support in libintl and libiconv, he said:
> 
> >   - The Cygwin API only allows me to get _all_ file names behind all
> >     addresses across the entire current process, and this is slow.
> 
> (talking about parsing /proc/self/maps)
> 
> >   - It would be useful to have a Cygwin API that gives me the file
> >     file name behind one particular address in the current process.
> >     This should not be that slow.
> 
> This patch is a proof of concept for the latter.  Naturally, it needs
> additional work -- updating version.h, real changelog entries,
> documentation somewhere, etc.  But...is it worth the effort?  Is
> something like this likely to be accepted?

The first and foremost question is, what is the relocation support
in libintl trying to accomplish?  Why does a internationalization
library has to know the path of a module based on an address?
Is that a functionality required on other POSIX systems?

Can we discuss this on cygwin-developers first, please?  So far I doubt
that this makes any sense on Cygwin.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
