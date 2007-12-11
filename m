Return-Path: <cygwin-patches-return-6184-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26590 invoked by alias); 11 Dec 2007 15:30:20 -0000
Received: (qmail 26580 invoked by uid 22791); 11 Dec 2007 15:30:20 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Tue, 11 Dec 2007 15:30:15 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 396EB6D4831; Tue, 11 Dec 2007 16:30:13 +0100 (CET)
Date: Tue, 11 Dec 2007 15:30:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Cygheap page boundary allocation bug.
Message-ID: <20071211153013.GA9398@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0b0d01c83bef$e9364690$2e08a8c0@CAM.ARTIMI.COM> <20071211141852.GA3619@ednor.casa.cgf.cx> <0b1e01c83c01$cb11e2c0$2e08a8c0@CAM.ARTIMI.COM> <20071211143847.GA3719@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071211143847.GA3719@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00036.txt.bz2

On Dec 11 09:38, Christopher Faylor wrote:
> On Tue, Dec 11, 2007 at 02:26:17PM -0000, Dave Korn wrote:
> >On 11 December 2007 14:19, Christopher Faylor wrote:
> >
> >> On Tue, Dec 11, 2007 at 12:18:17PM -0000, Dave Korn wrote:
> >>> 2007-12-11  Dave Korn  <dave.korn@artimi.com>
> >>> 
> >>> 	* cygheap.cc (_csbrk):  Don't request zero bytes from VirtualAlloc,
> >>> 	as windows treats that as an invalid parameter and returns an error.
> >> 
> >> Ok.
> >
> >  Trunk or cr-0x5f1 branch or both or ... ?
> 
> Trunk.  If Corinna wants it on the branch I'm sure she'll apply it.

Yup, will do.

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
