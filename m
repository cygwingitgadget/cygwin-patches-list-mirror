Return-Path: <cygwin-patches-return-6370-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21143 invoked by alias); 3 Dec 2008 16:40:03 -0000
Received: (qmail 21020 invoked by uid 22791); 3 Dec 2008 16:39:53 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 03 Dec 2008 16:39:17 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 54D536D4356; Wed,  3 Dec 2008 17:40:15 +0100 (CET)
Date: Wed, 03 Dec 2008 16:40:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Minires update
Message-ID: <20081203164015.GZ12905@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <00c701c95563$c4267df0$940410ac@wirelessworld.airvananet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00c701c95563$c4267df0$940410ac@wirelessworld.airvananet.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00014.txt.bz2

On Dec  3 11:25, Pierre A. Humblet wrote:
> This patch syncs the built-in minires with the latest packaged version.
> Also attaching the files to guarantee format preservation.
> 
> Pierre
> 
> 2008-12-03  Pierre A. Humblet  <Pierre.Humblet@ieee.org>
> 
>         * libc/minires.c (open_sock): Set non blocking and close on exec.
>         (res_ninit): Set id pseudo-randomly.
>         (res_nsend): Do not set close on exec. Initialize server from id.
>         Flush socket. Tighten rules for answer acceptance.
>         (res_nmkquery): Update id using current data.

Applied with a very minor change:

> Index: minires.c
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/libc/minires.c,v
> retrieving revision 1.4
> diff -u -p -r1.4 minires.c
> --- minires.c 1 Apr 2008 10:22:33 -0000 1.4
> +++ minires.c 3 Dec 2008 02:57:26 -0000
> @@ -1,6 +1,6 @@
>  /* minires.c.  Stub synchronous resolver for Cygwin.
>  
> -   Copyright 2006 Red Hat, Inc.
> +   Copyright 2008 Red Hat, Inc.

The Copyright should keep the old dates, like this:

      Copyright 2006, 2008 Red Hat, Inc.


Thanks!
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
