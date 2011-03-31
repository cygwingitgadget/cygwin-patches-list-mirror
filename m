Return-Path: <cygwin-patches-return-7232-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6585 invoked by alias); 31 Mar 2011 13:10:10 -0000
Received: (qmail 3911 invoked by uid 22791); 31 Mar 2011 13:09:54 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 31 Mar 2011 13:09:47 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id DBAD52C0302; Thu, 31 Mar 2011 15:09:44 +0200 (CEST)
Date: Thu, 31 Mar 2011 13:10:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] compile cyglsa with mingw-w64
Message-ID: <20110331130944.GH13484@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1301546273.2936.6.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1301546273.2936.6.camel@YAAKOV04>
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
X-SW-Source: 2011-q1/txt/msg00087.txt.bz2

On Mar 30 23:37, Yaakov (Cygwin/X) wrote:
> The mingw-w64 toolchain can now be used in place of MSVC to build
> cyglsa64.dll.  I didn't integrate this into the Makefile because that
> would make the toolchain a hard build-time requirement, and I don't
> think that is desirable at this time.
> 
> Patch and new file attached.
> 
> 
> Yaakov
> 
> 2011-03-30  Yaakov Selkowitz  <...>
> 
> 	* cyglsa.c: Fix compilation with MinGW-w64 toolchains.
> 	* make-64bit-version-with-mingw-w64.sh: New file.

Thank you, that's a nice change.  I've just applied it.  I'll go
a step further and drop the "build with Visual C" stuff entirely.
I've also another change in the loop which removes the dependency
to advapi32, which I'll apply later today.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
