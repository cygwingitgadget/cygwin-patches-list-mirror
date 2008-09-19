Return-Path: <cygwin-patches-return-6355-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10191 invoked by alias); 19 Sep 2008 22:17:40 -0000
Received: (qmail 10181 invoked by uid 22791); 19 Sep 2008 22:17:40 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-72-74-94-61.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (72.74.94.61)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 19 Sep 2008 22:17:08 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id B7B6A1C6183; Fri, 19 Sep 2008 18:17:06 -0400 (EDT)
Date: Fri, 19 Sep 2008 22:17:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: strerrno and new errno values
Message-ID: <20080919221706.GB19666@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <48D4226C.1030406@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48D4226C.1030406@byu.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q3/txt/msg00018.txt.bz2

On Fri, Sep 19, 2008 at 04:06:36PM -0600, Eric Blake wrote:
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>OK to apply, to match newlib and in preparation for POSIX 200x?
>
>2008-09-19  Eric Blake  <ebb9@byu.net>
>
>	* errno.cc (_sys_errlist): Add ECANCELED, ENOTRECOVERABLE,
>	EOWNERDEAD.

Yes.  Please apply.

Thanks.

cgf
