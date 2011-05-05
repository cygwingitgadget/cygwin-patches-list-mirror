Return-Path: <cygwin-patches-return-7312-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31830 invoked by alias); 5 May 2011 21:08:48 -0000
Received: (qmail 31818 invoked by uid 22791); 5 May 2011 21:08:48 -0000
X-SWARE-Spam-Status: No, hits=-1.4 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,T_RP_MATCHES_RCVD,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from mailout09.t-online.de (HELO mailout09.t-online.de) (194.25.134.84)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 05 May 2011 21:08:34 +0000
Received: from fwd03.aul.t-online.de (fwd03.aul.t-online.de )	by mailout09.t-online.de with smtp 	id 1QI5mh-0006Od-Ap; Thu, 05 May 2011 23:08:31 +0200
Received: from [192.168.2.100] (bLQrBrZ6rhD-hBfOoyn0znD-R6sxruSEqf-7ovboeaOCXplgpChqhsWgAlEyYPuwhz@[79.224.120.104]) by fwd03.aul.t-online.de	with esmtp id 1QI5ma-23Iomu0; Thu, 5 May 2011 23:08:24 +0200
Message-ID: <4DC311C9.1030401@t-online.de>
Date: Thu, 05 May 2011 21:08:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.17) Gecko/20110123 SeaMonkey/2.0.12
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix access("/proc/registry/HKEY_PERFORMANCE_DATA", R_OK)
References: <4DC2D57C.7020009@t-online.de> <20110505172431.GI32085@calimero.vinschen.de>
In-Reply-To: <20110505172431.GI32085@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-SW-Source: 2011-q2/txt/msg00078.txt.bz2

Corinna Vinschen wrote:
> On May  5 18:51, Christian Franke wrote:
>    
>> This patch fixes access("/proc/registry/HKEY_PERFORMANCE_DATA",
>> R_OK) which always fails with EBADF.
>>
>> Christian
>>
>>      
>    
>> 2011-05-05  Christian Franke<...>
>>
>> 	* security.cc (check_registry_access): Handle missing
>> 	security descriptor of HKEY_PERFORMANCE_DATA.
>>      
> Do you have check in rights?  If so, please check in.
>
>    

No check in rights, sorry :-)

Christian
