Return-Path: <cygwin-patches-return-7218-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15249 invoked by alias); 29 Mar 2011 07:53:31 -0000
Received: (qmail 15235 invoked by uid 22791); 29 Mar 2011 07:53:22 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 29 Mar 2011 07:53:16 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C17F12C0168; Tue, 29 Mar 2011 09:53:13 +0200 (CEST)
Date: Tue, 29 Mar 2011 07:53:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Provide sys/xattr.h
Message-ID: <20110329075313.GF15349@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1301384629.4524.24.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1301384629.4524.24.camel@YAAKOV04>
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
X-SW-Source: 2011-q1/txt/msg00073.txt.bz2

On Mar 29 02:43, Yaakov (Cygwin/X) wrote:
> Historically, the *xattr functions were first provided by SGI libattr
> and prototyped in <attr/xattr.h>.  Later, glibc added them under
> <sys/xattr.h>[1], and (on Linux) libattr still provides the symbols for
> ABI compatibility but they are now just wrappers.
> 
> (FWIW, Darwin also provides these symbols in <sys/xattr.h>[2].)
> 
> This can be seen very clearly in GLib's configure[3], where
> <sys/xattr.h> and libc are tested in tandem, followed by <attr/xattr.h>
> and libattr.  Hence, with only attr/xattr.h present, libattr-devel is
> required not only for building GLib, but the -lattr becomes hardcoded in
> the libtool .la files, meaning that libglib2.0-devel would require
> libattr-devel even though GLib requires no symbols from libattr1.
> 
> I see two ways to resolve this:
> 
> 1) Move include/attr/xattr.h to include/sys/xattr.h, and ship libattr's
> attr/xattr.h in libattr-devel, exactly as is done on Linux:
> 
> 2011-03-29  Yaakov Selkowitz <yselkowitz@...>
> 
> 	* include/attr/xattr.h: Move from here...
> 	* include/sys/xattr.h: ...to here.
> 
> 2) Install a copy of include/attr/xattr.h as <sys/xattr.h>, as in the
> attached patch.

What about just creating a file sys/attr.h which includes attr/attr.h?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
