Return-Path: <cygwin-patches-return-7861-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25604 invoked by alias); 22 Mar 2013 10:17:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 25217 invoked by uid 89); 22 Mar 2013 10:15:06 -0000
X-Spam-SWARE-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,TW_GC autolearn=ham version=3.3.1
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.84/v0.84-167-ge50287c) with ESMTP; Fri, 22 Mar 2013 10:15:03 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 161B45203F8; Fri, 22 Mar 2013 11:15:00 +0100 (CET)
Date: Fri, 22 Mar 2013 10:17:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] Fix ONDEE for 64bit
Message-ID: <20130322101500.GA23965@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20130305093009.GD16361@calimero.vinschen.de> <20130305093850.GE16361@calimero.vinschen.de> <20130315051819.2ce99a0b@YAAKOV04> <20130315102655.GD1360@calimero.vinschen.de> <20130315165640.14bdcb71@YAAKOV04> <20130316104515.GA30245@calimero.vinschen.de> <20130317041825.42371500@YAAKOV04> <20130317184909.1b7a838a@YAAKOV04> <20130318100924.GA15206@calimero.vinschen.de> <20130322022351.6b6cefe1@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20130322022351.6b6cefe1@YAAKOV04>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SW-Source: 2013-q1/txt/msg00072.txt.bz2

On Mar 22 02:23, Yaakov wrote:
> On Mon, 18 Mar 2013 11:09:24 +0100, Corinna Vinschen wrote:
> > On Mar 17 18:49, Yaakov wrote:
> > > On Sun, 17 Mar 2013 04:18:25 -0500, Yaakov (Cygwin/X) wrote:
> > > > I also discovered two more gcc macros which were missing updates for
> > > > x86_64-cygwin.  I have added those patches, and incorporated your x86_64
> > > > patches into mine, into a 4.8 branch of my gcc port:
> > > > 
> > > > http://cygwin-ports.git.sourceforge.net/git/gitweb.cgi?p=cygwin-ports/gcc;a=shortlog;h=refs/heads/4.8
> > > > 
> > > > I am building native and 32-to-64 compilers with this patchset now.
> > > 
> > > libgcj needs some work, and gnat will have to wait until I can get a
> > > native gnat 4.8, but the current tip of this branch builds successfully
> > > for C/C++/Fortran/ObjC/ObjC++.
> > 
> > Do you have a full diff relative to GCC HEAD?
> 
> I've been focusing on 4.8 right now, so what I have is in the
> aforementioned branch (which I updated just yesterday).  Working on
> upstream HEAD will have to wait a few weeks.

Ok, cool.

Thanks for all your hard work to get the test distro into a working
state!


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat
