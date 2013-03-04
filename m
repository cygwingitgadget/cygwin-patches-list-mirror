Return-Path: <cygwin-patches-return-7843-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19224 invoked by alias); 4 Mar 2013 13:16:13 -0000
Received: (qmail 17748 invoked by uid 22791); 4 Mar 2013 13:15:51 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 04 Mar 2013 13:15:42 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 75EB1520242; Mon,  4 Mar 2013 14:15:39 +0100 (CET)
Date: Mon, 04 Mar 2013 13:16:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] Fix ONDEE for 64bit
Message-ID: <20130304131539.GE2481@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20130304021224.381b9ec4@YAAKOV04> <20130304105134.GF5468@calimero.vinschen.de> <20130304053936.49484e71@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20130304053936.49484e71@YAAKOV04>
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
X-SW-Source: 2013-q1/txt/msg00054.txt.bz2

On Mar  4 05:39, Yaakov wrote:
> On Mon, 4 Mar 2013 11:51:34 +0100, Corinna Vinschen wrote:
> > That looks good, thanks for catching this problem!  Please apply the
> > Cygwin changes.  I'll rebuild new base packages including the gcc
> > patches soon.
> 
> BTW, at some point the attached patch will also need to be added for
> 4.8.  The libgcj ABI version changes with every GCC major.minor, and
> this define seems to always be missed; a comment to this effect in
> libjava/libtool-version probably wouldn't hurt.
> 
> 
> Yaakov

Thanks, but here's a question:  If the libgcj ABI version really changes
with every GCC major.minor release, wouldn't it then make sense to
change the libgcj DLL versioning scheme so it uses the GCC major.minor
number rather than an arbitrary version number?

In other words, why not cyggcj-4.8.dll?  This would allow easy
automation of Cygwin's LIBGCJ_SONAME, and everybody would know what
GCC version it's based on.


Corinna


-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat
