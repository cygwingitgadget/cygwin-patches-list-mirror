Return-Path: <cygwin-patches-return-7208-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13985 invoked by alias); 16 Mar 2011 19:24:20 -0000
Received: (qmail 13973 invoked by uid 22791); 16 Mar 2011 19:24:19 -0000
X-SWARE-Spam-Status: No, hits=-1.2 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,T_RP_MATCHES_RCVD,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from mailout04.t-online.de (HELO mailout04.t-online.de) (194.25.134.18)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 16 Mar 2011 19:24:14 +0000
Received: from fwd01.aul.t-online.de (fwd01.aul.t-online.de )	by mailout04.t-online.de with smtp 	id 1PzwKP-000642-Pp; Wed, 16 Mar 2011 20:24:17 +0100
Received: from [192.168.2.100] (Tz4PLUZTrh6EQc0jIIEBzK-4Zzj-2GBPHUKjyruO6YY-AJO6JdIRx5xrPMaucRQgeD@[79.224.110.131]) by fwd01.aul.t-online.de	with esmtp id 1PzwKA-1H9stk0; Wed, 16 Mar 2011 20:24:02 +0100
Message-ID: <4D810E53.30402@t-online.de>
Date: Wed, 16 Mar 2011 19:24:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.17) Gecko/20110123 SeaMonkey/2.0.12
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Ensure that the default ACL contains the standard entries
References: <4D02A41C.8030406@t-online.de> <20101211204653.GA26611@calimero.vinschen.de> <4D07E02A.2020202@t-online.de> <20101215141149.GW10566@calimero.vinschen.de> <4D090D12.6020407@t-online.de> <20101216111024.GX10566@calimero.vinschen.de> <20110311115553.GF7064@calimero.vinschen.de>
In-Reply-To: <20110311115553.GF7064@calimero.vinschen.de>
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
X-SW-Source: 2011-q1/txt/msg00063.txt.bz2

Hi Corinna,

Corinna Vinschen wrote:
> Hi Christian,
>
> On Dec 16 12:10, Corinna Vinschen wrote:
>    
>>
>> - Fix acl(2) by handling deny ACEs at all.
>>
>> - Implement the POSIX 1003.1e functions (maybe simply in terms of
>>    the existing Solaris API).
>>
>> - Add missing Solaris ACL functions (acl_get, facl_get, acl_set, facl_set,
>>    acl_fromtext, acl_totext, acl_free, acl_strip, acl_trivial).
>>
>> - Add Solaris NFSv4 ACLs, which, coincidentally, are almost equivalent
>>    to Windows ACLs.  This would work nicely for NTFS ACLs, of course.
>>    See http://docs.sun.com/app/docs/doc/819-2252/acl-5?l=en&a=view
>>
>> - Last but not least:  Actually handle "mask".
>>      
> did you have any further look into any of these points?
>
>
>    

Sorry no - open-source-time was too limited for these rather complex 
issues :-)

Christian
