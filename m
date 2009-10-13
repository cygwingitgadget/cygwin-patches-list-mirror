Return-Path: <cygwin-patches-return-6766-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12853 invoked by alias); 13 Oct 2009 13:43:26 -0000
Received: (qmail 12839 invoked by uid 22791); 13 Oct 2009 13:43:25 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-48-2.bstnma.east.verizon.net (HELO cgf.cx) (173.76.48.2)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 13 Oct 2009 13:43:19 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 139C23B0002 	for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2009 09:43:10 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 0BBD02B352; Tue, 13 Oct 2009 09:43:10 -0400 (EDT)
Date: Tue, 13 Oct 2009 13:43:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: missing va_end calls
Message-ID: <20091013134309.GA925@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AD477DC.9040004@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AD477DC.9040004@byu.net>
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
X-SW-Source: 2009-q4/txt/msg00097.txt.bz2

On Tue, Oct 13, 2009 at 06:51:40AM -0600, Eric Blake wrote:
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>As promised:
>
>2009-10-13  Eric Blake  <ebb9@byu.net>
>
>	* external.cc (cygwin_internal): Use va_end.
>	* fork.cc (child_copy): Likewise.
>	* libc/bsdlib.cc (warn, warnx, err, errx): Likewise.
>	* pinfo.cc (commune_request): Likewise.
>	* strace.cc (strace::prntf, strace_printf): Likewise.

For consistency with a lot of other cygwin code please use "res" rather
than "result" in external.cc.

Other than that please check in.

Thanks.

cgf
