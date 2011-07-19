Return-Path: <cygwin-patches-return-7433-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20081 invoked by alias); 19 Jul 2011 07:44:24 -0000
Received: (qmail 20034 invoked by uid 22791); 19 Jul 2011 07:44:02 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 19 Jul 2011 07:43:46 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D81712CA503; Tue, 19 Jul 2011 09:43:43 +0200 (CEST)
Date: Tue, 19 Jul 2011 07:44:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] add getconf(1)
Message-ID: <20110719074343.GA15263@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1311042021.7348.26.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1311042021.7348.26.camel@YAAKOV04>
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
X-SW-Source: 2011-q3/txt/msg00009.txt.bz2

Hi Yaakov,

On Jul 18 21:20, Yaakov (Cygwin/X) wrote:
> This patch adds getconf(1) as required by POSIX:

This looks good.  I'm just wondering... on one hand the code seems to
have nothing Cygwin-specifc and could be packed as an external package
like any other POSIX tool, on the other hand I can see how it belongs to
the Cygwin utils given that getconf on Linux is part of glibc.  I'm
inclined to stick it into utils for the latter reason.  Chris?  What's
your stance?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
