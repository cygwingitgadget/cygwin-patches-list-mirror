Return-Path: <cygwin-patches-return-7150-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21397 invoked by alias); 11 Jan 2011 10:10:33 -0000
Received: (qmail 19872 invoked by uid 22791); 11 Jan 2011 10:10:11 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 11 Jan 2011 10:10:04 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 5351C2CA090; Tue, 11 Jan 2011 11:10:01 +0100 (CET)
Date: Tue, 11 Jan 2011 10:10:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fixes for cfget[io]speed
Message-ID: <20110111101001.GA22609@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1294738575.5256.6.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1294738575.5256.6.camel@YAAKOV04>
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
X-SW-Source: 2011-q1/txt/msg00005.txt.bz2

On Jan 11 03:36, Yaakov (Cygwin/X) wrote:
> I discovered some compliance issues with cfget[io]speed:
> 
> * POSIX requires these to be declared (at least) as functions[1];
> * POSIX requires their argument to be const[1];
> * the macros are not safe for C++ code.
> 
> The following patch fixes these issues, providing that constifying the
> arguments doesn't change the ABI.
> 
> 
> Yaakov
> 
> [1]
> http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/termios.h.html

> 2011-01-11  Yaakov Selkowitz
> 
> 	* termios.cc (cfgetospeed, cfgetispeed): Constify argument per POSIX.
> 	* include/sys/termios.h (cfgetospeed, cfgetispeed): Declare functions.
> 	Move macros after declarations and make conditional on !__cplusplus.

Thanks, applied.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
