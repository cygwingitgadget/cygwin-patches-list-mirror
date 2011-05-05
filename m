Return-Path: <cygwin-patches-return-7309-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13693 invoked by alias); 5 May 2011 17:25:10 -0000
Received: (qmail 13513 invoked by uid 22791); 5 May 2011 17:24:47 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 05 May 2011 17:24:33 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 1D1572C0578; Thu,  5 May 2011 19:24:31 +0200 (CEST)
Date: Thu, 05 May 2011 17:25:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix access("/proc/registry/HKEY_PERFORMANCE_DATA", R_OK)
Message-ID: <20110505172431.GI32085@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4DC2D57C.7020009@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4DC2D57C.7020009@t-online.de>
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
X-SW-Source: 2011-q2/txt/msg00075.txt.bz2

On May  5 18:51, Christian Franke wrote:
> This patch fixes access("/proc/registry/HKEY_PERFORMANCE_DATA",
> R_OK) which always fails with EBADF.
> 
> Christian
> 

> 2011-05-05  Christian Franke  <...>
> 
> 	* security.cc (check_registry_access): Handle missing
> 	security descriptor of HKEY_PERFORMANCE_DATA.

Do you have check in rights?  If so, please check in.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
