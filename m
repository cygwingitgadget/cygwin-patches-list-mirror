Return-Path: <cygwin-patches-return-7375-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8982 invoked by alias); 18 May 2011 03:35:53 -0000
Received: (qmail 8854 invoked by uid 22791); 18 May 2011 03:35:52 -0000
X-SWARE-Spam-Status: No, hits=-1.0 required=5.0	tests=AWL,BAYES_40,DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from out5.smtp.messagingengine.com (HELO out5.smtp.messagingengine.com) (66.111.4.29)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 18 May 2011 03:35:37 +0000
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])	by gateway1.messagingengine.com (Postfix) with ESMTP id 25804208E6	for <cygwin-patches@cygwin.com>; Tue, 17 May 2011 23:35:36 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])  by compute4.internal (MEProxy); Tue, 17 May 2011 23:35:36 -0400
Received: from [192.168.1.3] (user-0c6se63.cable.mindspring.com [24.110.56.195])	by mail.messagingengine.com (Postfix) with ESMTPSA id C4F574042B2;	Tue, 17 May 2011 23:35:35 -0400 (EDT)
Message-ID: <4DD33E74.9030408@cwilson.fastmail.fm>
Date: Wed, 18 May 2011 03:35:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] error.h
References: <1305678052.6192.5.camel@YAAKOV04>
In-Reply-To: <1305678052.6192.5.camel@YAAKOV04>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00141.txt.bz2

On 5/17/2011 8:20 PM, Yaakov (Cygwin/X) wrote:
> This patch series adds error.h and the error(3) functions, a GNU
> extension:
> 
> http://www.kernel.org/doc/man-pages/online/pages/man3/error.3.html
> 
> I implemented this within Cygwin itself instead of newlib, because it is
> a GNU extension which depends on program_invocation_name, another GNU
> extension available only in Cygwin.
> 
> Patches for winsup/cygwin and winsup/doc, the new error.h header, and a
> test application, attached.

Shouldn't the definitions in error.h be guarded by #ifdef GNU_SOURCE or
something -- or are we relying on error.h itself, as a non-standard
header, "hiding" the symbols implicitly?   E.g. if you don't want the
functions, don't include <error.h>?

--
Chuck
