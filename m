Return-Path: <cygwin-patches-return-7716-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20046 invoked by alias); 3 Sep 2012 10:35:54 -0000
Received: (qmail 15712 invoked by uid 22791); 3 Sep 2012 10:35:34 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 03 Sep 2012 10:35:20 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 082152C00CA; Mon,  3 Sep 2012 12:35:18 +0200 (CEST)
Date: Mon, 03 Sep 2012 10:35:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] suggestion for faster pseudo-reloc.
Message-ID: <20120903103518.GK13401@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <503982F3.9010004@gmail.com> <20120902102718.GC13401@calimero.vinschen.de> <50439CAE.6080603@gmail.com> <50441E6B.7060703@cwilson.fastmail.fm> <504479A3.6080609@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <504479A3.6080609@users.sourceforge.net>
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
X-SW-Source: 2012-q3/txt/msg00037.txt.bz2

On Sep  3 17:34, JonY wrote:
> On 9/3/2012 11:05, Charles Wilson wrote:
> > On 9/2/2012 1:51 PM, Jin-woo Ye wrote:
> >> Now it is clear that this patch would be needed other relevant projects
> >> such as mingw, mingw-w64. thanks for your effort on simplified one.
> > 
> > Yes, while it is not required that all of those systems stay exactly in
> > sync, there has been some effort in ensuring that the pseudo-reloc
> > implementation used by all three remains very similar if not identical.
> > 
> > Please bring this patch to the attention of the mingw.org and
> > mingw64.sf.net people, if it's not too much trouble.
> > 
> > --
> > Chuck
> > 
> > 
> > 
> 
> Original message already forwarded to mingw-w64 devel list. Thanks
> Jin-woo Ye.

Do you want the patch I eventually applied, too?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
