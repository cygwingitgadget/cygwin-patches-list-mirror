Return-Path: <cygwin-patches-return-7756-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6314 invoked by alias); 24 Oct 2012 13:23:56 -0000
Received: (qmail 6288 invoked by uid 22791); 24 Oct 2012 13:23:38 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 24 Oct 2012 13:23:33 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id AC5282C00AF; Wed, 24 Oct 2012 15:23:30 +0200 (CEST)
Date: Wed, 24 Oct 2012 13:23:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch]: Decouple cygwin building from in-tree mingw/w32api building
Message-ID: <20121024132330.GB31527@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20121018083419.GC6221@calimero.vinschen.de> <1350580828.3492.73.camel@YAAKOV04> <20121019092135.GA22432@calimero.vinschen.de> <1350664438.3492.114.camel@YAAKOV04> <1350855543.1244.64.camel@YAAKOV04> <20121022122344.GC2469@calimero.vinschen.de> <1351071053.1244.89.camel@YAAKOV04> <20121024095054.GB28666@calimero.vinschen.de> <20121024100140.GA31527@calimero.vinschen.de> <1351074380.1244.94.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1351074380.1244.94.camel@YAAKOV04>
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
X-SW-Source: 2012-q4/txt/msg00033.txt.bz2

On Oct 24 05:26, Yaakov (Cygwin/X) wrote:
> On Wed, 2012-10-24 at 12:01 +0200, Corinna Vinschen wrote:
> > > Checking in toplevel patches requires global checkin rights.  I can
> > > apply the toplevel patch when you applied the rest.  Other than that,
> > > toplevel patches also have to be kept aligned with the gcc repo.  I'll
> > > make sure to inform the gcc guys.
> > 
> > Oh btw., if that wasn't clear:  Please apply all but toplevel.
> 
> Done.  While you're at it, perhaps you could bump this patch as well:
> 
> http://gcc.gnu.org/ml/gcc-patches/2011-07/msg01578.html

I'd hazard the guess that a ping in the context of the thread would
make more sense...


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
