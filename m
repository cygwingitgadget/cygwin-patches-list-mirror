Return-Path: <cygwin-patches-return-7059-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2628 invoked by alias); 9 Aug 2010 03:46:04 -0000
Received: (qmail 2618 invoked by uid 22791); 9 Aug 2010 03:46:03 -0000
X-SWARE-Spam-Status: No, hits=-50.9 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE
X-Spam-Check-By: sourceware.org
Received: from mail-gx0-f171.google.com (HELO mail-gx0-f171.google.com) (209.85.161.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 09 Aug 2010 03:45:56 +0000
Received: by gxk6 with SMTP id 6so5484576gxk.2        for <cygwin-patches@cygwin.com>; Sun, 08 Aug 2010 20:45:55 -0700 (PDT)
Received: by 10.100.7.17 with SMTP id 17mr17209975ang.21.1281325555184;        Sun, 08 Aug 2010 20:45:55 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [24.76.240.202])        by mx.google.com with ESMTPS id w6sm7626472anb.23.2010.08.08.20.45.53        (version=SSLv3 cipher=RC4-MD5);        Sun, 08 Aug 2010 20:45:54 -0700 (PDT)
Subject: Re: [PATCH] define RTLD_LOCAL
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
In-Reply-To: <4C5E6C39.6000802@sh.cvut.cz>
References: <1281246553.1344.24.camel@YAAKOV04>	 <4C5E6C39.6000802@sh.cvut.cz>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 09 Aug 2010 03:46:00 -0000
Message-ID: <1281325555.5484.39.camel@YAAKOV04>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q3/txt/msg00019.txt.bz2

On Sun, 2010-08-08 at 10:35 +0200, VÃ¡clav Haisman wrote:
> Is it not undefined in Cygwin because Windows cannot support the behaviour?
> AFAIK once you do LoadLibrary(A.dll) then any subsequent reference to A.dll
> and its exports will be satisfied from the already loaded A.dll. IOW, Windows
> cannot satisfy "The object's symbols shall not be made available for the
> relocation processing of any other object," as specified by [2].

Remember that Cygwin's dlopen() does nothing with the second argument,
so none of RTLD_* actually affect behaviour.  According to your logic,
we shouldn't define one of RTLD_LAZY or RTLD_NOW, because they can't
both be true, so our dlopen() isn't fulfilling its meaning.  We define
both anyway, and I don't see this as any different.

Secondly, on Linux, RTLD_LOCAL is essentially the default, so lots
(most?) software intended primarily for Linux which passes neither it
nor RTLD_GLOBAL is probably expecting RTLD_LOCAL behaviour anyway.
Therefore actually defining RTLD_LOCAL isn't a notable change.

Thirdly, several times I have seen the following:

#ifndef RTLD_LOCAL
#define RTLD_LOCAL 0
#endif

So they're clearly not too concerned about specific behaviour, they just
don't require RTLD_GLOBAL and therefore specify the opposite.  Defining
RTLD_LOCAL ourselves just saves us from patching this in to other
software.


Yaakov

