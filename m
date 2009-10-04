Return-Path: <cygwin-patches-return-6688-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7155 invoked by alias); 4 Oct 2009 19:58:10 -0000
Received: (qmail 7145 invoked by uid 22791); 4 Oct 2009 19:58:09 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 04 Oct 2009 19:58:05 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 6381A6D55B9; Sun,  4 Oct 2009 21:57:54 +0200 (CEST)
Date: Sun, 04 Oct 2009 19:58:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] Update build flags for new compiler feature
Message-ID: <20091004195754.GI4563@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AC66C72.7070102@gmail.com> <20091002221933.GB12372@ednor.casa.cgf.cx> <20091003120854.GA22019@calimero.vinschen.de> <4AC74BB5.9060503@gmail.com> <20091003130644.GJ7193@calimero.vinschen.de> <4AC75235.1070403@gmail.com> <4AC84E5A.7040203@gmail.com> <20091004112648.GE4563@calimero.vinschen.de> <4AC8AC37.4050306@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AC8AC37.4050306@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00019.txt.bz2

On Oct  4 15:07, Dave Korn wrote:
> Corinna Vinschen wrote:
> 
> > Since I have a running gcc-4.34 now, do you still want me to do that?
> > Plaese keep in mind that I'm a lazy cow...
> 
>   Efficient use of resources != laziness.  No, I wouldn't suggest doing that,
> what you ended up with by hacking the header files should (in theory, anyway)
> be the same as what you would get if the autoconf tests had done it for you.
> 
>   Now that all the related mysteries are solved, I'll go ahead and commit that
> patch to the build flags.  (I just thought it would be kind of wrong of me to
> leave HEAD in a state where the one and only actual RedHat staffer working on
> the project couldn't compile it!)

Cool, thank you!


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
