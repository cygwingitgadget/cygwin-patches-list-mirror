Return-Path: <cygwin-patches-return-6364-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5273 invoked by alias); 28 Nov 2008 09:11:54 -0000
Received: (qmail 5261 invoked by uid 22791); 28 Nov 2008 09:11:53 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 28 Nov 2008 09:10:42 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 09BE06D4308; Fri, 28 Nov 2008 10:10:50 +0100 (CET)
Date: Fri, 28 Nov 2008 09:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Add dirent.d_type support to  Cygwin 1.7 ?
Message-ID: <20081128091049.GA12905@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <492DBE7E.7020100@t-online.de> <20081126221012.GA15970@ednor.casa.cgf.cx> <492DD7D0.6050001@t-online.de> <20081127093023.GA9487@calimero.vinschen.de> <1L5eGn-03rme80@fwd09.aul.t-online.de> <20081127111502.GF30831@calimero.vinschen.de> <492F1424.5000004@t-online.de> <20081128021554.GF16768@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20081128021554.GF16768@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00008.txt.bz2

On Nov 27 21:15, Christopher Faylor wrote:
> On Thu, Nov 27, 2008 at 10:41:56PM +0100, Christian Franke wrote:
> > Corinna Vinschen wrote:
> >> The logic sounds ok to me.  I just don't think we need a warning and the 
> >> condition could be simplified accordingly.
> >>
> >>   
> >
> > New patch below. Conditionals removed as suggested by cgf.
> >
> > Define of _DIRENT_HAVE_D_TYPE still there - google code search finds 
> > several projects using this instead of a ./configure check.
> >
> >
> > 2008-11-27  Christian Franke  <franke@computer.org>
> >
> > 	* dir.cc (readdir_worker): Initialize dirent.d_type and __d_unused1.
> > 	* fhandler_disk_file.cc (fhandler_disk_file::readdir_helper):
> > 	Set dirent.d_type based on FILE_ATTRIBUTE_*.
> > 	* include/sys/dirent.h: Define _DIRENT_HAVE_D_TYPE.
> > 	(struct dirent): Add d_type. Adjust __d_unused1 size to preserve layout.
> > 	[_DIRENT_HAVE_D_TYPE]: Enable DT_* declarations.
> 
> If Corinna's ok with this then so am I.

Yep.  Applied with just a minor change to the ChangeLog entry.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
