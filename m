Return-Path: <cygwin-patches-return-7817-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12461 invoked by alias); 20 Feb 2013 14:13:51 -0000
Received: (qmail 12155 invoked by uid 22791); 20 Feb 2013 14:13:17 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 20 Feb 2013 14:13:13 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 1DC4252034F; Wed, 20 Feb 2013 15:13:11 +0100 (CET)
Date: Wed, 20 Feb 2013 14:13:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] ssize_t
Message-ID: <20130220141311.GB27673@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAGvSfezH1=HKNrjzOnRF28riHhfnX8GwYkBHy9SDDK+0_fpK9Q@mail.gmail.com> <CAGvSfeyZP3Lfa88hGEFb4DorpKTLz-tYDO8h=gd5nxxu20DXsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGvSfeyZP3Lfa88hGEFb4DorpKTLz-tYDO8h=gd5nxxu20DXsA@mail.gmail.com>
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
X-SW-Source: 2013-q1/txt/msg00028.txt.bz2

On Feb 20 03:43, Yaakov (Cygwin/X) wrote:
> On Wed, Feb 20, 2013 at 3:32 AM, Yaakov (Cygwin/X) wrote:
> > Here is the patch for cygwin necessary for my newly-posted newlib patch.
> 
> I forgot to mention that this probably requires everything to be rebuilt. :-(

Yes, but it's not exactly surprising.  As soon as our GCC switches to
the large code model (I explained on the developer's list) we will have
to rebuild once more.  And then again, none of these early packages are
for the distro anyway, so we will probably see a few more rebuilds :)

No worries,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat
