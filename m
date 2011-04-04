Return-Path: <cygwin-patches-return-7260-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21167 invoked by alias); 4 Apr 2011 11:27:15 -0000
Received: (qmail 21157 invoked by uid 22791); 4 Apr 2011 11:27:15 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-gy0-f171.google.com (HELO mail-gy0-f171.google.com) (209.85.160.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 04 Apr 2011 11:27:11 +0000
Received: by gye5 with SMTP id 5so2637155gye.2        for <cygwin-patches@cygwin.com>; Mon, 04 Apr 2011 04:27:10 -0700 (PDT)
Received: by 10.236.30.100 with SMTP id j64mr10132118yha.106.1301916430448;        Mon, 04 Apr 2011 04:27:10 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id p3sm2239292yhp.89.2011.04.04.04.27.08        (version=SSLv3 cipher=OTHER);        Mon, 04 Apr 2011 04:27:08 -0700 (PDT)
Subject: Re: [PATCH] make <sys/sysmacros.h> compatible with glibc
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
In-Reply-To: <20110404105430.GN3669@calimero.vinschen.de>
References: <1301873845.3104.26.camel@YAAKOV04>	 <20110403235557.GA15529@ednor.casa.cgf.cx>	 <1301875911.3104.39.camel@YAAKOV04>	 <20110404051942.GA30475@ednor.casa.cgf.cx>	 <20110404105430.GN3669@calimero.vinschen.de>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 04 Apr 2011 11:27:00 -0000
Message-ID: <1301916432.3104.76.camel@YAAKOV04>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00026.txt.bz2

On Mon, 2011-04-04 at 12:54 +0200, Corinna Vinschen wrote:
> On Apr  4 01:19, Christopher Faylor wrote:
> > I'll leave it to Corinna but I'd prefer not adding YA export if we can
> > avoid it.
> 
> This is very simple code, so I, too, would prefer to keep it inline.

Alright, do I still bump CYGWIN_VERSION_API_MINOR for only inline
functions?  What about posix.sgml?


Yaakov
 
