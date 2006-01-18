Return-Path: <cygwin-patches-return-5716-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20654 invoked by alias); 18 Jan 2006 12:52:01 -0000
Received: (qmail 20625 invoked by uid 22791); 18 Jan 2006 12:51:58 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Wed, 18 Jan 2006 12:51:53 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 3DAE4544001; Wed, 18 Jan 2006 13:51:50 +0100 (CET)
Date: Wed, 18 Jan 2006 12:52:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Remove debug printf from cygpath.cc
Message-ID: <20060118125150.GA12941@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <SERRANOAeys8FSA4Ale000001a5@SERRANO.CAM.ARTIMI.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SERRANOAeys8FSA4Ale000001a5@SERRANO.CAM.ARTIMI.COM>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00025.txt.bz2

On Jan 18 12:30, Dave Korn wrote:
> 
> 
>   Obvious fix for stray debug-printf, as mentioned on the main list.
> http://cygwin.com/ml/cygwin/2006-01/msg00792.html
> 
>   (Am about to see if I have perms to check it in.)
> 
> 
> 2006-01-18  Dave Korn  <dave.korn@artimi.com>
> 
> 	* cygpath.cc (dowin):  Remove stray debugging printf statement.

Thanks for doing this,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
