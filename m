Return-Path: <cygwin-patches-return-6522-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19920 invoked by alias); 20 May 2009 14:57:56 -0000
Received: (qmail 19903 invoked by uid 22791); 20 May 2009 14:57:55 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-48-46-134.bstnma.fios.verizon.net (HELO cgf.cx) (173.48.46.134)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 20 May 2009 14:57:49 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 3D30713C023 	for <cygwin-patches@cygwin.com>; Wed, 20 May 2009 10:57:38 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 1503C604337; Wed, 20 May 2009 10:57:39 -0400 (EDT)
Date: Wed, 20 May 2009 14:57:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: avoid compiler warning with DEBUGGING
Message-ID: <20090520145738.GA12742@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4A13FCC7.6010603@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A13FCC7.6010603@byu.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q2/txt/msg00064.txt.bz2

On Wed, May 20, 2009 at 06:51:19AM -0600, Eric Blake wrote:
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>I noticed a complaint about comparing signed and unsigned values, when
>compiling with DEBUGGING enabled.  net.cc also has a lot of trailing blanks.
>
>2009-05-20  Eric Blake  <ebb9@byu.net>
>
>	* net.cc (gethostby_helper): Use correct signedness.

I've applied this even though I couldn't duplicate the problem with gcc 4.
I think that may be a first since gcc 4 is much more picky than gcc 3.4.

Thanks.

cgf
