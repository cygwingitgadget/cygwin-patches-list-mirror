Return-Path: <cygwin-patches-return-7319-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12905 invoked by alias); 6 May 2011 17:28:42 -0000
Received: (qmail 12895 invoked by uid 22791); 6 May 2011 17:28:41 -0000
X-SWARE-Spam-Status: No, hits=-1.4 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,T_RP_MATCHES_RCVD,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from mailout07.t-online.de (HELO mailout07.t-online.de) (194.25.134.83)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 06 May 2011 17:28:27 +0000
Received: from fwd19.aul.t-online.de (fwd19.aul.t-online.de )	by mailout07.t-online.de with smtp 	id 1QIOpD-0005AF-0X; Fri, 06 May 2011 19:28:23 +0200
Received: from [192.168.2.100] (VTd54ZZ6Qhsv+RdyqfyGDglaIeGdYAmvbPAbfYxT+oOx+MZFnw4CX4-G2ZeRyX7wNC@[79.224.120.104]) by fwd19.aul.t-online.de	with esmtp id 1QIOp7-24qmrA0; Fri, 6 May 2011 19:28:17 +0200
Message-ID: <4DC42FB2.2090302@t-online.de>
Date: Fri, 06 May 2011 17:28:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.17) Gecko/20110123 SeaMonkey/2.0.12
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix access("/proc/registry/HKEY_PERFORMANCE_DATA", R_OK)
References: <4DC2D57C.7020009@t-online.de> <20110505172431.GI32085@calimero.vinschen.de> <4DC311C9.1030401@t-online.de> <20110506071407.GG8245@calimero.vinschen.de>
In-Reply-To: <20110506071407.GG8245@calimero.vinschen.de>
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
X-SW-Source: 2011-q2/txt/msg00085.txt.bz2

Corinna Vinschen wrote:
> On May  5 23:08, Christian Franke wrote:
>    
>>
>> No check in rights, sorry :-)
>>      
> http://sourceware.org/cgi-bin/pdw/ps_form.cgi, project Cygwin, approver me.
>
>    

Done - Thanks!


> However, I just had another look into your patch and I have a problem
> here.  On what system and with what type of user account did you test?
>
> Here's what I get on Windows 2008 and W7:
>
> $ ~/tests/access /proc/registry/HKEY_PERFORMANCE_DATA
> access (/proc/registry/HKEY_PERFORMANCE_DATA, F_OK) = 0
> access (/proc/registry/HKEY_PERFORMANCE_DATA, R_OK) = -1<Permission denied>
> access (/proc/registry/HKEY_PERFORMANCE_DATA, W_OK) = -1<Read-only file system>
> access (/proc/registry/HKEY_PERFORMANCE_DATA, X_OK) = -1<Bad file descriptor>
>
>    

Hmm....

> The result is the same on W7 and 2008.  I tried with a normal user
> account, as well as with an admin account, with full rights as well as
> UAC-restricted.
>
>
>    

Couldn't test new code in Win7 yet.

Test results:

Current code on XP SP3 and cygwin-5.7.9-1 on WIn7:

access("/proc/registry/HKEY_PERFORMANCE_DATA", F_OK)=0
access("/proc/registry/HKEY_PERFORMANCE_DATA", R_OK)=-1 <Bad file 
descriptor>
access("/proc/registry/HKEY_PERFORMANCE_DATA", W_OK)=-1 <Read-only file 
system>
access("/proc/registry/HKEY_PERFORMANCE_DATA", X_OK)=-1 <Bad file 
descriptor>

Current code + patch on XP

access("/proc/registry/HKEY_PERFORMANCE_DATA", F_OK)=0
access("/proc/registry/HKEY_PERFORMANCE_DATA", R_OK)=0
access("/proc/registry/HKEY_PERFORMANCE_DATA", W_OK)=-1 <Read-only file 
system>
access("/proc/registry/HKEY_PERFORMANCE_DATA", X_OK)=0

Admin rights make no difference.

Christian
