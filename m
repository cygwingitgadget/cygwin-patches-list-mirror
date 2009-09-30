Return-Path: <cygwin-patches-return-6661-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18271 invoked by alias); 30 Sep 2009 09:22:01 -0000
Received: (qmail 18260 invoked by uid 22791); 30 Sep 2009 09:22:00 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 30 Sep 2009 09:21:56 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id D6B2F6D5598; Wed, 30 Sep 2009 11:21:45 +0200 (CEST)
Date: Wed, 30 Sep 2009 09:22:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [1.7] rename/renameat error
Message-ID: <20090930092145.GA30404@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20090923140905.GA2527@ednor.casa.cgf.cx> <20090923160846.GA18954@calimero.vinschen.de> <20090923164127.GB3172@ednor.casa.cgf.cx> <4ABC39A1.1060702@byu.net> <20090925151114.GA23857@ednor.casa.cgf.cx> <4ABD5A4A.9060603@byu.net> <20090926145748.GA8697@ednor.casa.cgf.cx> <4AC25D6C.4010106@byu.net> <20090929193534.GK7193@calimero.vinschen.de> <4AC2BE07.1070501@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AC2BE07.1070501@byu.net>
User-Agent: Mutt/1.5.19 (2009-02-20)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00115.txt.bz2

On Sep 29 20:10, Eric Blake wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> According to Corinna Vinschen on 9/29/2009 1:35 PM:
> > On Sep 29 13:18, Eric Blake wrote:
> >> I missed one corner case in my testing; how about this followup?
> >>
> >> 2009-09-29  Eric Blake  <ebb9@byu.net>
> >>
> >> 	* syscalls.cc (rename): Fix regression on rename("dir","d/").
> > 
> > Looks ok to me.  Isn't that partly covered by the next if, though?
> > YA piece of code lacking comments it seems.
> 
> I added a few comments before committing.  The difference between the two
> lines is that only the first one rejects rename("file","file2/"), and only
> the second rejects rename("dir","file"); both lines are needed.

Uh, right.  Thanks for adding the comments!


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
