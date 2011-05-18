Return-Path: <cygwin-patches-return-7374-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1946 invoked by alias); 18 May 2011 01:21:09 -0000
Received: (qmail 1916 invoked by uid 22791); 18 May 2011 01:21:08 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm27.bullet.mail.bf1.yahoo.com (HELO nm27.bullet.mail.bf1.yahoo.com) (98.139.212.186)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Wed, 18 May 2011 01:20:53 +0000
Received: from [98.139.212.144] by nm27.bullet.mail.bf1.yahoo.com with NNFMP; 18 May 2011 01:20:52 -0000
Received: from [98.139.213.4] by tm1.bullet.mail.bf1.yahoo.com with NNFMP; 18 May 2011 01:20:52 -0000
Received: from [127.0.0.1] by smtp104.mail.bf1.yahoo.com with NNFMP; 18 May 2011 01:20:52 -0000
Received: from cgf.cx (cgf@173.48.46.160 with login)        by smtp104.mail.bf1.yahoo.com with SMTP; 17 May 2011 18:20:52 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id A8B0B42804C	for <cygwin-patches@cygwin.com>; Tue, 17 May 2011 21:20:51 -0400 (EDT)
Date: Wed, 18 May 2011 01:21:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] error.h
Message-ID: <20110518012051.GA3616@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1305678052.6192.5.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1305678052.6192.5.camel@YAAKOV04>
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
X-SW-Source: 2011-q2/txt/msg00140.txt.bz2

On Tue, May 17, 2011 at 07:20:47PM -0500, Yaakov (Cygwin/X) wrote:
>This patch series adds error.h and the error(3) functions, a GNU
>extension:
>
>http://www.kernel.org/doc/man-pages/online/pages/man3/error.3.html
>
>I implemented this within Cygwin itself instead of newlib, because it is
>a GNU extension which depends on program_invocation_name, another GNU
>extension available only in Cygwin.
>
>Patches for winsup/cygwin and winsup/doc, the new error.h header, and a
>test application, attached.
>
>
>Yaakov
>

>http://www.kernel.org/doc/man-pages/online/pages/man3/error.3.html
>
>2011-05-17  Yaakov Selkowitz  <yselkowitz@...>
>
>	* cygwin.din (error): Export.
>	(error_at_line): Export.
>	(error_message_count): Export.
>	(error_one_per_line): Export.
>	(error_print_progname): Export.
>	* errno.cc (error_message_count): Define.
>	(error_one_per_line): Define.
>	(error_print_progname): Define.
>	(_verror): New static function.
>	(error): New function.
>	(error_at_line): New function.
>	* posix.sgml (std-gnu): Add error, error_at_line.
>	* include/error.h: New header.
>	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.

Looks good.  Please check in.

cgf
