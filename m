Return-Path: <cygwin-patches-return-6368-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2119 invoked by alias); 2 Dec 2008 11:46:20 -0000
Received: (qmail 2108 invoked by uid 22791); 2 Dec 2008 11:46:20 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 02 Dec 2008 11:45:28 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 300BA6D4356; Tue,  2 Dec 2008 12:46:15 +0100 (CET)
Date: Tue, 02 Dec 2008 11:46:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Encode invalid chars in /proc/registry entries (merge 	from  1.5)
Message-ID: <20081202114615.GB20615@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <493439BA.8@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <493439BA.8@t-online.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00012.txt.bz2

On Dec  1 20:23, Christian Franke wrote:
> This is a 1.5->1.7 merge of my patch from 
> http://sourceware.org/ml/cygwin-patches/2007-q4/msg00017.html
>
> Christian
>
>
> 2008-12-01  Christian Franke  <franke@computer.org>
>
> 	* fhandler_registry.cc (must_encode): New function.
> 	(encode_regname): Ditto.
> 	(decode_regname): Ditto.
> 	(fhandler_registry::exists): Encode name before path compare.
> 	(fhandler_registry::fstat): Pass decoded name to win32 registry call.
> 	(fhandler_registry::readdir): Return encoded name to user.
> 	(fhandler_registry::open): Store decoded name into value_name.
> 	(open_key): Pass decoded name to win32 registry call

Patch applied.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
