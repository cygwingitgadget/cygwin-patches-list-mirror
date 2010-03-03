Return-Path: <cygwin-patches-return-7002-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13973 invoked by alias); 3 Mar 2010 09:10:59 -0000
Received: (qmail 13956 invoked by uid 22791); 3 Mar 2010 09:10:58 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 03 Mar 2010 09:10:54 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 601A96D42F5; Wed,  3 Mar 2010 10:10:52 +0100 (CET)
Date: Wed, 03 Mar 2010 09:10:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add xdr support
Message-ID: <20100303091052.GB24732@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B764A1F.6060003@cwilson.fastmail.fm>  <4B8D2F9D.4090309@cwilson.fastmail.fm>  <20100302180921.GO5683@calimero.vinschen.de>  <4B8DED87.1080801@cwilson.fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B8DED87.1080801@cwilson.fastmail.fm>
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
X-SW-Source: 2010-q1/txt/msg00118.txt.bz2

On Mar  3 00:03, Charles Wilson wrote:
> Corinna Vinschen wrote:
> > ...and I would *love* to apply the patches, but unfortunately there's a
> > serious, VERY serious problem with this patch.
> > 
> > The patch is missing the related changes to cygwin/posix.sgml and
> > doc/new-features.sgml.
> > 
> > Would you mind to send a second patch for the documentation?
> 
> Well, for new-features, no problem; attached.
> 
> However, the xdr functions are defined by neither SuSv4 nor POSIX,
> AFAICT.  They are defined by (variously) RFCs 1014 [1], 1832 [2], and
> 4506 [3], SVID.4 [4], and LSB [5].  It is also described in the XNFS [6]
> standard.
> 
> But it ain't posix, so...should it really go in posix.sgml?

Yes!  The filename posix.sgml is just historical, it could be better
named api.sgml, I guess, but here we are.  Have a look, it contains
various chapters with all APIs which follow some lead, SUSv4, BSD,
Linux, Solaris, deprecated or "other".  In case of the XDR calls, they
should probably go into the Solaris section, unless you think they fit
better in one of the other sections.

> 2010-03-02  Charles Wilson  <...>
> 
>         * new-features.sgml (ov-new1.7.2): Describe XDR support.

Thanks, added to my local sandbox.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
