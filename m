Return-Path: <cygwin-patches-return-7221-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19197 invoked by alias); 29 Mar 2011 08:04:44 -0000
Received: (qmail 19181 invoked by uid 22791); 29 Mar 2011 08:04:34 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 29 Mar 2011 08:04:28 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 65BF32C0168; Tue, 29 Mar 2011 10:04:25 +0200 (CEST)
Date: Tue, 29 Mar 2011 08:04:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Provide sys/xattr.h
Message-ID: <20110329080425.GH15349@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1301384629.4524.24.camel@YAAKOV04> <20110329075313.GF15349@calimero.vinschen.de> <1301385758.4524.29.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1301385758.4524.29.camel@YAAKOV04>
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
X-SW-Source: 2011-q1/txt/msg00076.txt.bz2

On Mar 29 03:02, Yaakov (Cygwin/X) wrote:
> On Tue, 2011-03-29 at 09:53 +0200, Corinna Vinschen wrote:
> > On Mar 29 02:43, Yaakov (Cygwin/X) wrote:
> > > I see two ways to resolve this:
> > > 
> > > 1) Move include/attr/xattr.h to include/sys/xattr.h, and ship libattr's
> > > attr/xattr.h in libattr-devel, exactly as is done on Linux:
> > > 
> > > 2) Install a copy of include/attr/xattr.h as <sys/xattr.h>, as in the
> > > attached patch.
> > 
> > What about just creating a file sys/attr.h which includes attr/attr.h?
> 
> Right, that should do it as well.  I was so fixed on the Linux situation
> (where you have two practically identical headers from different
> sources) that I couldn't think of anything else.  I think it's time for
> bed.

No worries.  I've checked that in and will create the 1.7.9 release now.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
