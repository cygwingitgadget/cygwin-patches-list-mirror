Return-Path: <cygwin-patches-return-7751-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21375 invoked by alias); 24 Oct 2012 09:51:13 -0000
Received: (qmail 21280 invoked by uid 22791); 24 Oct 2012 09:51:01 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 24 Oct 2012 09:50:56 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 577F72C00AF; Wed, 24 Oct 2012 11:50:54 +0200 (CEST)
Date: Wed, 24 Oct 2012 09:51:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch]: Decouple cygwin building from in-tree mingw/w32api building
Message-ID: <20121024095054.GB28666@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20121017170514.GD10578@calimero.vinschen.de> <20121017193258.GA15271@ednor.casa.cgf.cx> <1350545597.3492.59.camel@YAAKOV04> <20121018083419.GC6221@calimero.vinschen.de> <1350580828.3492.73.camel@YAAKOV04> <20121019092135.GA22432@calimero.vinschen.de> <1350664438.3492.114.camel@YAAKOV04> <1350855543.1244.64.camel@YAAKOV04> <20121022122344.GC2469@calimero.vinschen.de> <1351071053.1244.89.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1351071053.1244.89.camel@YAAKOV04>
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
X-SW-Source: 2012-q4/txt/msg00028.txt.bz2

On Oct 24 04:30, Yaakov (Cygwin/X) wrote:
> On Mon, 2012-10-22 at 14:23 +0200, Corinna Vinschen wrote:
> > If the original patch with the aforementioned changes is ok with
> > everybody, I'd apply it asap and remove lsaauth/cyglsa64.dll,
> > lsaauth/make-64bit-version-with-mingw-w64.sh, and utils/mingw.
> 
> Revised patches for winsup/cygwin and winsup/utils attached; I'm going
> to leave the AC_NO_EXECUTABLES part to you, as I'm not in a position to
> test that.

Ok, I'll add them afterwards.

> Before I apply these, are there special procedures for the
> toplevel patch?

Checking in toplevel patches requires global checkin rights.  I can
apply the toplevel patch when you applied the rest.  Other than that,
toplevel patches also have to be kept aligned with the gcc repo.  I'll
make sure to inform the gcc guys.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
