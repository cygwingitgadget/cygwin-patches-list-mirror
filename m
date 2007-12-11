Return-Path: <cygwin-patches-return-6185-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30255 invoked by alias); 11 Dec 2007 15:37:10 -0000
Received: (qmail 30245 invoked by uid 22791); 11 Dec 2007 15:37:09 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Tue, 11 Dec 2007 15:37:00 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 12D436D4811; Tue, 11 Dec 2007 16:36:58 +0100 (CET)
Date: Tue, 11 Dec 2007 15:37:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Cygheap page boundary allocation bug.
Message-ID: <20071211153658.GB9398@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0b0d01c83bef$e9364690$2e08a8c0@CAM.ARTIMI.COM> <20071211141852.GA3619@ednor.casa.cgf.cx> <0b1e01c83c01$cb11e2c0$2e08a8c0@CAM.ARTIMI.COM> <20071211143847.GA3719@ednor.casa.cgf.cx> <0b2301c83c09$f075e6d0$2e08a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b2301c83c09$f075e6d0$2e08a8c0@CAM.ARTIMI.COM>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00037.txt.bz2

On Dec 11 15:24, Dave Korn wrote:
>   Applied, thanks.  (Found some problems in w32api's wincrypt.h which I'll
> report to mingw list later today.  Appears to have been there for at least a
> fortnight.  Am I the only one who builds with WINVER >= 0x0501?)

Unlikely but possible.  Cygwin is using _WIN32_WINNT=0x0501 in winsup.h
and it doesn't have a build problem.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
