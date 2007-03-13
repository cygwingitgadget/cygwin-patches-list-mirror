Return-Path: <cygwin-patches-return-6039-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21218 invoked by alias); 13 Mar 2007 13:22:26 -0000
Received: (qmail 21207 invoked by uid 22791); 13 Mar 2007 13:22:24 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Tue, 13 Mar 2007 13:22:16 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 9E6206D42F9; Tue, 13 Mar 2007 14:22:13 +0100 (CET)
Date: Tue, 13 Mar 2007 13:22:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: compile warning in cygwin/stat.h
Message-ID: <20070313132213.GE24859@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <45F69971.4000604@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45F69971.4000604@byu.net>
User-Agent: Mutt/1.4.2.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q1/txt/msg00020.txt.bz2

On Mar 13 06:30, Eric Blake wrote:
> 	* include/cygwin/stat.h (S_TYPEISSHM, S_TYPEISSEM, S_TYPEISSHM):
> 	Avoid compiler warnings.

Thanks, applied.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
