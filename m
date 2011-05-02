Return-Path: <cygwin-patches-return-7287-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6431 invoked by alias); 2 May 2011 20:11:47 -0000
Received: (qmail 6401 invoked by uid 22791); 2 May 2011 20:11:42 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm22.bullet.mail.bf1.yahoo.com (HELO nm22.bullet.mail.bf1.yahoo.com) (98.139.212.181)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Mon, 02 May 2011 20:11:26 +0000
Received: from [98.139.212.150] by nm22.bullet.mail.bf1.yahoo.com with NNFMP; 02 May 2011 20:11:25 -0000
Received: from [98.139.213.11] by tm7.bullet.mail.bf1.yahoo.com with NNFMP; 02 May 2011 20:11:25 -0000
Received: from [127.0.0.1] by smtp111.mail.bf1.yahoo.com with NNFMP; 02 May 2011 20:11:25 -0000
Received: from cgf.cx (cgf@96.252.118.15 with login)        by smtp111.mail.bf1.yahoo.com with SMTP; 02 May 2011 13:11:24 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 304C94A800A	for <cygwin-patches@cygwin.com>; Mon,  2 May 2011 16:11:24 -0400 (EDT)
Date: Mon, 02 May 2011 20:11:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] pthread_attr_getstack{,addr}, pthread_getattr_np
Message-ID: <20110502201124.GA13011@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1304350389.6972.11.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1304350389.6972.11.camel@YAAKOV04>
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
X-SW-Source: 2011-q2/txt/msg00053.txt.bz2

On Mon, May 02, 2011 at 10:33:09AM -0500, Yaakov (Cygwin/X) wrote:
>This implements pthread_attr_getstack(), pthread_attr_getstackaddr, and
>pthread_getattr_np(), which I need for webkitgtk.
>
>In essence, I added a stackaddr member to pthread_attr, which is
>accessed (slightly differently) by pthread_attr_getstack{,attr},
>behaving just as on Linux.  The bulk of the work is to support
>pthread_getattr_np, which provides the real attributes of the given
>thread, including the real stack address and size.
>
>The pthread_attr_setstack{,addr} setters are not implemented, as I have
>yet to find a way to set the thread stack address on Windows.  For that
>reason I'm not defining _POSIX_THREAD_ATTR_STACKADDR, as the feature is
>not yet (fully) implemented.

Cygwin already plays with the stack address.  It has to for situations
when you call fork() from a thread.

>Patches for winsup/cygwin and winsup/doc, as well as a sample program
>for Cygwin and Linux, attached.

The patch looks good.  Please check in.

Thanks.

cgf
