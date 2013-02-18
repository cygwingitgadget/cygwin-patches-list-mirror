Return-Path: <cygwin-patches-return-7809-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18610 invoked by alias); 18 Feb 2013 10:19:33 -0000
Received: (qmail 18586 invoked by uid 22791); 18 Feb 2013 10:19:31 -0000
X-SWARE-Spam-Status: No, hits=-5.4 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,KHOP_SPAMHAUS_DROP,KHOP_THREADED,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mail-ie0-f171.google.com (HELO mail-ie0-f171.google.com) (209.85.223.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 18 Feb 2013 10:19:21 +0000
Received: by mail-ie0-f171.google.com with SMTP id 10so7008439ied.16        for <cygwin-patches@cygwin.com>; Mon, 18 Feb 2013 02:19:20 -0800 (PST)
X-Received: by 10.42.75.6 with SMTP id y6mr5586296icj.30.1361182760863;        Mon, 18 Feb 2013 02:19:20 -0800 (PST)
Received: from YAAKOV04 (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id z1sm8143678igc.1.2013.02.18.02.19.18        (version=SSLv3 cipher=RC4-SHA bits=128/128);        Mon, 18 Feb 2013 02:19:20 -0800 (PST)
Date: Mon, 18 Feb 2013 10:19:00 -0000
From: Yaakov (Cygwin/X) <yselkowitz@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] Fix speclib for x86_64
Message-ID: <20130218041917.7fd9498d@YAAKOV04>
In-Reply-To: <20130217165159.GA2177@ednor.casa.cgf.cx>
References: <20130217044622.1034ae22@YAAKOV04>	<20130217165159.GA2177@ednor.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
X-SW-Source: 2013-q1/txt/msg00020.txt.bz2

On Sun, 17 Feb 2013 11:51:59 -0500, Christopher Faylor wrote:
> >+my $uscore = ($target =~ /^x86_64\-/ ? undef : '_');
> 
> There is no reason to quote the dash here.  But, I would actually prefer
> a substr check since that is a little faster.
> 
> my $uscore = (substr($target, 0, 7) eq 'x86_64-') ? ...

I was just following the syntax already in mkimport:

> my $is64bit = ($target =~ /^x86_64\-/ ? 1 : 0);


Yaakov
