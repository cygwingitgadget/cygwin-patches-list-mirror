Return-Path: <cygwin-patches-return-7663-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14045 invoked by alias); 25 May 2012 18:43:25 -0000
Received: (qmail 14032 invoked by uid 22791); 25 May 2012 18:43:23 -0000
X-SWARE-Spam-Status: No, hits=2.7 required=5.0	tests=AWL,BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,KHOP_RCVD_TRUST,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mail-pz0-f43.google.com (HELO mail-pz0-f43.google.com) (209.85.210.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 25 May 2012 18:43:10 +0000
Received: by dajz8 with SMTP id z8so1639722daj.2        for <cygwin-patches@cygwin.com>; Fri, 25 May 2012 11:43:10 -0700 (PDT)
Received: by 10.68.204.165 with SMTP id kz5mr77964pbc.80.1337971390226;        Fri, 25 May 2012 11:43:10 -0700 (PDT)
Received: from MarkXPS (dsl-72-19-48-077.cascadeaccess.com. [72.19.48.77])        by mx.google.com with ESMTPS id h10sm9825595pbh.69.2012.05.25.11.43.08        (version=TLSv1/SSLv3 cipher=OTHER);        Fri, 25 May 2012 11:43:09 -0700 (PDT)
Reply-To: "Mark Lofdahl" <mark.lofdahl@gmail.com>
From: "Mark Lofdahl" <mark.lofdahl@gmail.com>
To: <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Ctrl-C and non-Cygwin programs
Date: Fri, 25 May 2012 18:43:00 -0000
Message-ID: <4fbfd2bd.2a04440a.04d9.54ec@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain;	charset="us-ascii"
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
X-SW-Source: 2012-q2/txt/msg00032.txt.bz2

References: <4F73CF37.4020001@elfmimi.jp>

On 28/03/2012 10:55 PM, Ein Terakawa wrote:

>What it does actually is it generates CTRL_BREAK_EVENT with 
>Windows Console API GenerateConsoleCtrlEvent on the arrival of SIGINT.
>And to make this scheme to be functional it is required to specify
>CREATE_NEW_PROCESS_GROUP when creating new non-Cygwin processes.


Is there any way for me to get the old behavior? I rely heavily on the
ability to press ctrl-c in my non-cygwin console app and have that app
receive a CTRL_C_EVENT instead of a CTRL_BREAK_EVENT. Everything worked fine
for me before this patch.

>To my surprise there seem to be no way to generate CTRL_C_EVENT using API.

It is possible to generate a CTRL_C_EVENT, if you pass 0 as the process
group id, in which case the event is passed to all process that share the
console. Don't know if that would work in this situation.
http://msdn.microsoft.com/en-us/library/windows/desktop/ms683155.aspx


Thanks,
Mark Lofdahl
