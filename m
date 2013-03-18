Return-Path: <cygwin-patches-return-7857-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7558 invoked by alias); 18 Mar 2013 10:10:21 -0000
Received: (qmail 7336 invoked by uid 22791); 18 Mar 2013 10:09:32 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 18 Mar 2013 10:09:27 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 8EED55203B8; Mon, 18 Mar 2013 11:09:24 +0100 (CET)
Date: Mon, 18 Mar 2013 10:10:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] Fix ONDEE for 64bit
Message-ID: <20130318100924.GA15206@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20130305084950.GB16361@calimero.vinschen.de> <20130305031430.5ff522eb@YAAKOV04> <20130305093009.GD16361@calimero.vinschen.de> <20130305093850.GE16361@calimero.vinschen.de> <20130315051819.2ce99a0b@YAAKOV04> <20130315102655.GD1360@calimero.vinschen.de> <20130315165640.14bdcb71@YAAKOV04> <20130316104515.GA30245@calimero.vinschen.de> <20130317041825.42371500@YAAKOV04> <20130317184909.1b7a838a@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20130317184909.1b7a838a@YAAKOV04>
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
X-SW-Source: 2013-q1/txt/msg00068.txt.bz2

On Mar 17 18:49, Yaakov wrote:
> On Sun, 17 Mar 2013 04:18:25 -0500, Yaakov (Cygwin/X) wrote:
> > I also discovered two more gcc macros which were missing updates for
> > x86_64-cygwin.  I have added those patches, and incorporated your x86_64
> > patches into mine, into a 4.8 branch of my gcc port:
> > 
> > http://cygwin-ports.git.sourceforge.net/git/gitweb.cgi?p=cygwin-ports/gcc;a=shortlog;h=refs/heads/4.8
> > 
> > I am building native and 32-to-64 compilers with this patchset now.
> 
> libgcj needs some work, and gnat will have to wait until I can get a
> native gnat 4.8, but the current tip of this branch builds successfully
> for C/C++/Fortran/ObjC/ObjC++.

Do you have a full diff relative to GCC HEAD?


Thanks.
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat
