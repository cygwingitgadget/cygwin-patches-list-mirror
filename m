Return-Path: <cygwin-patches-return-7046-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21885 invoked by alias); 28 Jul 2010 23:19:49 -0000
Received: (qmail 21874 invoked by uid 22791); 28 Jul 2010 23:19:47 -0000
X-SWARE-Spam-Status: No, hits=-0.9 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE
X-Spam-Check-By: sourceware.org
Received: from mail-px0-f171.google.com (HELO mail-px0-f171.google.com) (209.85.212.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 28 Jul 2010 23:19:43 +0000
Received: by pxi10 with SMTP id 10so2513458pxi.2        for <cygwin-patches@cygwin.com>; Wed, 28 Jul 2010 16:19:41 -0700 (PDT)
Received: by 10.114.110.2 with SMTP id i2mr15837865wac.193.1280359181665;        Wed, 28 Jul 2010 16:19:41 -0700 (PDT)
Received: from xyzzy (tide532.microsoft.com [131.107.0.102])        by mx.google.com with ESMTPS id d38sm226192wam.20.2010.07.28.16.19.40        (version=TLSv1/SSLv3 cipher=RC4-MD5);        Wed, 28 Jul 2010 16:19:40 -0700 (PDT)
From: "Daniel Colascione" <dan.colascione@gmail.com>
To: <cygwin-patches@cygwin.com>
References: <004d01cb2e99$7567c500$60374f00$@gmail.com> <20100728224433.GA11483@ednor.casa.cgf.cx>
In-Reply-To: <20100728224433.GA11483@ednor.casa.cgf.cx>
Subject: RE: [PATCH] fix build warnings for functions without return value
Date: Wed, 28 Jul 2010 23:19:00 -0000
Message-ID: <000601cb2eab$52022a30$f6067e90$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q3/txt/msg00006.txt.bz2

> From: cygwin-patches-owner@cygwin.com [mailto:cygwin-patches-
>
> I don't see why this is needed.  Cygwin uses -Werror by default so, if gcc
4.3.4
> emitted warnings we wouldn't be able to build a release or make a
snapshot.

It's because Cygwin uses -Werror that I had to patch the source. I'm
compiling with '-Os -march=native', which must tickle a different part of
the optimizer and thereby produce this warning. (One of the nice things
about clang is reportedly that it produces the same warnings no matter what
the optimizer does.) Besides, the current code is technically undefined and
the patch removes that undefined behavior --- which could start producing
warnings for the current build at any time.
