Return-Path: <cygwin-patches-return-7737-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28412 invoked by alias); 21 Oct 2012 11:33:39 -0000
Received: (qmail 28370 invoked by uid 22791); 21 Oct 2012 11:33:28 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Sun, 21 Oct 2012 11:33:23 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 290C02C02AB; Sun, 21 Oct 2012 13:33:20 +0200 (CEST)
Date: Sun, 21 Oct 2012 11:33:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch]: Decouple cygwin building from in-tree mingw/w32api building
Message-ID: <20121021113320.GA2469@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAEwic4ZBrjVPDV1Y3tc6r7baGzxNbrjgj1MUgse6zYSMHiCUhQ@mail.gmail.com> <20121017164440.GA12989@ednor.casa.cgf.cx> <20121017170514.GD10578@calimero.vinschen.de> <20121017193258.GA15271@ednor.casa.cgf.cx> <1350545597.3492.59.camel@YAAKOV04> <20121018083419.GC6221@calimero.vinschen.de> <1350580828.3492.73.camel@YAAKOV04> <20121019092135.GA22432@calimero.vinschen.de> <1350664438.3492.114.camel@YAAKOV04> <20121019184636.GZ25877@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20121019184636.GZ25877@calimero.vinschen.de>
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
X-SW-Source: 2012-q4/txt/msg00014.txt.bz2

On Oct 19 20:46, Corinna Vinschen wrote:
> On Oct 19 11:33, Yaakov (Cygwin/X) wrote:
> > On Fri, 2012-10-19 at 11:21 +0200, Corinna Vinschen wrote:
> > > Other than that, I think it's good to go in after the 1.7.17 release.
> > > I'll try to do the release at some point between now and Monday.
> > 
> > I'll include those changes and post a new patch then.

On second thought... considering that w32api is now Mingw64 based, and
considering that building Cygwin with this Mingw64 built w32api works
fine... what do you guys think about a "once and for all" approach?  Is
it really necessary to keep supporting a build against the old w32api?
What does that buy us apart from added complexity?  Doesn't that also
mean we have to test our builds against both w32api versions as long as
we support it?  I, for one, have no real interest to do so.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
