Return-Path: <cygwin-patches-return-6831-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2287 invoked by alias); 11 Nov 2009 15:11:34 -0000
Received: (qmail 2209 invoked by uid 22791); 11 Nov 2009 15:11:32 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-42-77.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.42.77)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 11 Nov 2009 15:11:29 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id DCB433B0002 	for <cygwin-patches@cygwin.com>; Wed, 11 Nov 2009 10:11:18 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 94D7D2B352; Wed, 11 Nov 2009 10:11:18 -0500 (EST)
Date: Wed, 11 Nov 2009 15:11:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] add get_nprocs, get_nprocs_conf
Message-ID: <20091111151118.GA8857@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AFA6675.6070408@users.sourceforge.net>  <20091111094119.GA3564@calimero.vinschen.de>  <4AFA907E.1050408@users.sourceforge.net>  <4AFAB42C.1020404@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AFAB42C.1020404@byu.net>
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
X-SW-Source: 2009-q4/txt/msg00162.txt.bz2

On Wed, Nov 11, 2009 at 05:55:08AM -0700, Eric Blake wrote:
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>According to Yaakov (Cygwin/X) on 11/11/2009 3:22 AM:
>> On 11/11/2009 03:41, Corinna Vinschen wrote:
>>> Thanks, but, wouldn't it be simpler to implement them as macros in
>>> sys/sysinfo.h?
>> 
>> Implementing them as macros won't help an autoconf AC_CHECK_FUNC or
>> cmake CHECK_FUNCTION_EXISTS test.
>
>Also, the upcomining coreutils 8.1 will be adding nproc(1), to make
>scripting for parallel jobs easier by exposing these functions to shell
>users.  +1 on the concept from me, although why does sys/sysinfo.h have to
>forward to cygwin/sysinfo.h, rather than directly declaring the two functions?

Ditto on the +1 and the question.

cgf
