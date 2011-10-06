Return-Path: <cygwin-patches-return-7518-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4394 invoked by alias); 6 Oct 2011 17:18:06 -0000
Received: (qmail 4349 invoked by uid 22791); 6 Oct 2011 17:18:05 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm16-vm0.access.bullet.mail.mud.yahoo.com (HELO nm16-vm0.access.bullet.mail.mud.yahoo.com) (66.94.236.19)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Thu, 06 Oct 2011 17:17:51 +0000
Received: from [66.94.237.192] by nm16.access.bullet.mail.mud.yahoo.com with NNFMP; 06 Oct 2011 17:17:50 -0000
Received: from [66.94.237.103] by tm3.access.bullet.mail.mud.yahoo.com with NNFMP; 06 Oct 2011 17:17:50 -0000
Received: from [127.0.0.1] by omp1008.access.mail.mud.yahoo.com with NNFMP; 06 Oct 2011 17:17:50 -0000
Received: (qmail 63757 invoked from network); 6 Oct 2011 17:17:50 -0000
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from cgf.cx (cgf@173.76.45.30 with login)        by smtp103.vzn.mail.bf1.yahoo.com with SMTP; 06 Oct 2011 10:17:49 -0700 PDT
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 79D1E13C0D3	for <cygwin-patches@cygwin.com>; Thu,  6 Oct 2011 13:17:49 -0400 (EDT)
Date: Thu, 06 Oct 2011 17:18:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Allow usage of union wait for wait() functions and macros
Message-ID: <20111006171749.GC22971@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4E8C3828.4010009@t-online.de> <20111005132620.GA8422@ednor.casa.cgf.cx> <4E8CC986.3080001@t-online.de> <20111006023729.GM1955@ednor.casa.cgf.cx> <4E8D8B0D.1060805@t-online.de> <20111006130357.GA20063@ednor.casa.cgf.cx> <4E8DD373.2070008@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E8DD373.2070008@t-online.de>
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
X-SW-Source: 2011-q4/txt/msg00008.txt.bz2

On Thu, Oct 06, 2011 at 06:12:35PM +0200, Christian Franke wrote:
>Christopher Faylor wrote:
>> On Thu, Oct 06, 2011 at 01:03:41PM +0200, Christian Franke wrote:
>>> ...
>>> OK, __INSIDE_CYGWIN__ is not needed here in practice (but possibly in
>>> theory :-)
>> I would rather see as little __INSIDE_CYGWIN__ as possible
>> in external headers.
>
>OK, removed and Cygwin compilation tested.
>
>>> Would the patch with __INSIDE_CYGWIN__ removed be GTG?
>> Yes.
>
>Thanks - patch committed.

Thanks a lot for the patch.

cgf
