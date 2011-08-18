Return-Path: <cygwin-patches-return-7480-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10926 invoked by alias); 18 Aug 2011 19:21:43 -0000
Received: (qmail 10889 invoked by uid 22791); 18 Aug 2011 19:21:24 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 18 Aug 2011 19:21:09 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id AE9DA2C00F4; Thu, 18 Aug 2011 21:21:06 +0200 (CEST)
Date: Thu, 18 Aug 2011 19:21:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix warning in winsup/cygserver
Message-ID: <20110818192106.GC4955@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1313693651.4916.6.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1313693651.4916.6.camel@YAAKOV04>
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
X-SW-Source: 2011-q3/txt/msg00056.txt.bz2

On Aug 18 13:54, Yaakov (Cygwin/X) wrote:
> 	* sysv_shm.cc (ACCESSPERMS): Remove to fix redefined warning, as
> 	this is now defined in <sys/stat.h>.

Please apply.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
