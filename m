Return-Path: <cygwin-patches-return-5484-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3793 invoked by alias); 23 May 2005 13:14:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3663 invoked by uid 22791); 23 May 2005 13:14:04 -0000
Received: from p54941750.dip0.t-ipconnect.de (HELO calimero.vinschen.de) (84.148.23.80)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 23 May 2005 13:14:04 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 78E95544001; Mon, 23 May 2005 15:14:08 +0200 (CEST)
Date: Mon, 23 May 2005 13:14:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: bug in stdint.h
Message-ID: <20050523131408.GA29161@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4291C5A7.9040509@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4291C5A7.9040509@byu.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q2/txt/msg00080.txt.bz2

On May 23 05:59, Eric Blake wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Found a typo in /usr/include/stdint.h:
> 
> 2005-05-23  Eric Blake  <ebb9@byu.net>
> 
> 	* include/stdint.h (INTMAX_C, UINTMAX_C): Fix definition.

Right, thanks for catching this.  Applied.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
