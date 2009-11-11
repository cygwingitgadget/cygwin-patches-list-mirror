Return-Path: <cygwin-patches-return-6828-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8850 invoked by alias); 11 Nov 2009 09:41:40 -0000
Received: (qmail 8831 invoked by uid 22791); 11 Nov 2009 09:41:37 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 11 Nov 2009 09:41:31 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 1E7756D41A0; Wed, 11 Nov 2009 10:41:20 +0100 (CET)
Date: Wed, 11 Nov 2009 09:41:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] add get_nprocs, get_nprocs_conf
Message-ID: <20091111094119.GA3564@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AFA6675.6070408@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AFA6675.6070408@users.sourceforge.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00159.txt.bz2

On Nov 11 01:23, Yaakov S wrote:
> get_nprocs and get_nprocs_conf are GNU extensions which do the same
> thing as sysconf(_SC_NPROCESSORS_CONF/_ONLN).[1]
> 
> Patch attached.

Thanks, but, wouldn't it be simpler to implement them as macros in
sys/sysinfo.h?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
