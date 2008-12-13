Return-Path: <cygwin-patches-return-6391-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19921 invoked by alias); 13 Dec 2008 09:11:07 -0000
Received: (qmail 19910 invoked by uid 22791); 13 Dec 2008 09:11:06 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 13 Dec 2008 09:10:15 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 469A96D4356; Sat, 13 Dec 2008 10:12:46 +0100 (CET)
Date: Sat, 13 Dec 2008 09:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Avoid duplicate names in /proc/registry (which may 	crash     find)
Message-ID: <20081213091246.GN32197@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <493C1DF7.6090905@t-online.de> <20081208114800.GW12905@calimero.vinschen.de> <20081208115433.GX12905@calimero.vinschen.de> <49417625.4030209@t-online.de> <20081212152000.GA32492@calimero.vinschen.de> <494287F4.2080505@byu.net> <20081212161304.GK32197@calimero.vinschen.de> <49428EA4.5090402@byu.net> <20081212164007.GL32197@calimero.vinschen.de> <4942A03A.5060104@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4942A03A.5060104@t-online.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00035.txt.bz2

On Dec 12 18:32, Christian Franke wrote:
> Why not encode "@" as a reserved name like it is already done for "." and 
> ".." (which appear as "%2E" and "%2E.")? This would provide backward 
> compatibility and consistency with current conversions:
>
> @ - default value
> %40 - named key or value
> %40%val - named value if key exists
>
> I will post a patch.

Perfect.


Thamks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
