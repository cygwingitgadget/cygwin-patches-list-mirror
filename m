Return-Path: <cygwin-patches-return-5721-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26911 invoked by alias); 25 Jan 2006 10:58:18 -0000
Received: (qmail 26898 invoked by uid 22791); 25 Jan 2006 10:58:18 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Wed, 25 Jan 2006 10:58:17 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 8B929544001; Wed, 25 Jan 2006 11:58:14 +0100 (CET)
Date: Wed, 25 Jan 2006 10:58:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Proposed clarification of the snapshot installation FAQ
Message-ID: <20060125105814.GN8318@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <dpvba1$i83$1@sea.gmane.org> <43C3F412.1010008@cygwin.com> <dq3d00$4o7$1@sea.gmane.org> <Pine.GSO.4.63.0601111200110.9317@access1.cims.nyu.edu> <dq3h09$k5o$1@sea.gmane.org> <Pine.GSO.4.63.0601112136461.9317@access1.cims.nyu.edu> <cb51e2e0601121957p711594fexdf2a87e4395e3059@mail.gmail.com> <20060113041529.GB11985@trixie.casa.cgf.cx> <Pine.GSO.4.63.0601122333160.27020@access1.cims.nyu.edu> <Pine.GSO.4.63.0601122359430.27020@access1.cims.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.63.0601122359430.27020@access1.cims.nyu.edu>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00030.txt.bz2

On Jan 13 00:01, Igor Peshansky wrote:
> On Thu, 12 Jan 2006, Igor Peshansky wrote:
> 
> > On Thu, 12 Jan 2006, Christopher Faylor wrote:
> >
> > > Nevertheless, the advice about using "mv" to rename cygwin1.dll won't
> > > work on every version of Windows and needs to be changed.
> >
> > Hmm, it's worked for me on Win98, Win2k, and WinXP (though I suppose
> > there could be differences on, say, WinNT4 or something)...  I basically
> > wanted to avoid giving too many things to do in Windows Explorer.  But
> > no matter -- I'll submit a patch with this change shortly.
> 
> And here it is.
> 	Igor
> ==============================================================================
> 2006-01-12  Igor Peshansky  <pechtcha@cs.nyu.edu>
> 
> 	* faq-setup.xml (faq.setup.snapshots): Rename DLL using Windows tools.

Applied.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
