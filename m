Return-Path: <cygwin-patches-return-6658-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24896 invoked by alias); 30 Sep 2009 00:35:07 -0000
Received: (qmail 24886 invoked by uid 22791); 30 Sep 2009 00:35:07 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-qy0-f183.google.com (HELO mail-qy0-f183.google.com) (209.85.221.183)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 30 Sep 2009 00:35:03 +0000
Received: by qyk13 with SMTP id 13so4432043qyk.18         for <cygwin-patches@cygwin.com>; Tue, 29 Sep 2009 17:35:02 -0700 (PDT)
Received: by 10.224.50.137 with SMTP id z9mr4781076qaf.83.1254270901654;         Tue, 29 Sep 2009 17:35:01 -0700 (PDT)
Received: from ?192.168.0.101? (S010600112f237275.wp.shawcable.net [24.76.241.98])         by mx.google.com with ESMTPS id 4sm87187qwe.5.2009.09.29.17.34.59         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Tue, 29 Sep 2009 17:35:00 -0700 (PDT)
Message-ID: <4AC2A7B5.3070105@users.sourceforge.net>
Date: Wed, 30 Sep 2009 00:35:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.4pre) Gecko/20090915 Thunderbird/3.0b4
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] --std=c89 error in sys/signal.h
References: <4AC2732D.5090304@users.sourceforge.net> <20090929223320.GA8901@ednor.casa.cgf.cx>
In-Reply-To: <20090929223320.GA8901@ednor.casa.cgf.cx>
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
X-SW-Source: 2009-q3/txt/msg00112.txt.bz2

On 29/09/2009 17:33, Christopher Faylor wrote:
>> I see two possible solutions:
>>
>> 1) Unconditionally #include<sys/types.h>  in<sys/signal.h>  (newlib), OR
>> 2) #include<sys/types.h>  in<cygwin/signal.h>.
>>
>> Since this appears to be Cygwin specific, I went for the latter.  Patch
>> attached.
>
> WDLD?

On IRC:

cygwinports: cgf: wtf WDLD?
cgf: What Does Linux Do?
cgf: I adapted it from Dave Korn.
cygwinports: sounds like a candidate for OLOCA

Anyway, to answer the question, AFAICS in glibc, <signal.h> #include 
<bits/types.h> unconditionally[1].  (<sys/signal.h> is just one line: 
#include <signal.h> [2])

So should I take the first route, patching newlib instead?


Yaakov

[1] http://repo.or.cz/w/glibc.git?a=blob;f=signal/signal.h;hb=HEAD
[2] http://repo.or.cz/w/glibc.git?a=blob;f=signal/sys/signal.h;hb=HEAD
