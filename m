Return-Path: <cygwin-patches-return-6987-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1397 invoked by alias); 26 Feb 2010 09:39:52 -0000
Received: (qmail 1381 invoked by uid 22791); 26 Feb 2010 09:39:51 -0000
X-SWARE-Spam-Status: No, hits=-2.6 required=5.0 	tests=AWL,BAYES_00
X-Spam-Check-By: sourceware.org
Received: from qw-out-1920.google.com (HELO qw-out-1920.google.com) (74.125.92.147)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 26 Feb 2010 09:39:47 +0000
Received: by qw-out-1920.google.com with SMTP id 14so173455qwa.20         for <cygwin-patches@cygwin.com>; Fri, 26 Feb 2010 01:39:45 -0800 (PST)
Received: by 10.224.96.217 with SMTP id i25mr64747qan.222.1267177185590;         Fri, 26 Feb 2010 01:39:45 -0800 (PST)
Received: from ?127.0.0.1? (S010600112f237275.wp.shawcable.net [24.76.241.98])         by mx.google.com with ESMTPS id 21sm1775341qyk.1.2010.02.26.01.39.44         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Fri, 26 Feb 2010 01:39:44 -0800 (PST)
Message-ID: <4B8796E6.5010202@users.sourceforge.net>
Date: Fri, 26 Feb 2010 09:39:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] define SIGPWR
References: <4B875901.6010906@users.sourceforge.net>  <20100226052655.GA22741@ednor.casa.cgf.cx>  <4B87616D.7050602@users.sourceforge.net>  <4B876413.8040800@users.sourceforge.net> <20100226092035.GB8489@calimero.vinschen.de>
In-Reply-To: <20100226092035.GB8489@calimero.vinschen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
X-SW-Source: 2010-q1/txt/msg00103.txt.bz2

On 2010-02-26 03:20, Corinna Vinschen wrote:
> On Feb 26 00:02, Yaakov S wrote:
>> Corresponding patch for doc/new-features.sgml attached.
> Please apply.

Committed.

>> And how should I handle the kill(1) section of utils/utils.sgml?
>
> -v?

1) Replace SIGLOST with SIGPWR, since only the latter will show up by 
'kill -l'?

2) Add SIGPWR to SIGLOST since they have different strings, but what 
about SIGIO or SIGCLD which are also synonyms but not listed?

3) Add SIGPWR as a parenthetical note to SIGLOST?


Yaakov
