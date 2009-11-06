Return-Path: <cygwin-patches-return-6815-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16735 invoked by alias); 6 Nov 2009 17:39:33 -0000
Received: (qmail 16724 invoked by uid 22791); 6 Nov 2009 17:39:33 -0000
X-SWARE-Spam-Status: No, hits=-1.3 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_JMF_BR
X-Spam-Check-By: sourceware.org
Received: from mailout08.t-online.de (HELO mailout08.t-online.de) (194.25.134.20)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 06 Nov 2009 17:39:28 +0000
Received: from fwd05.aul.t-online.de  	by mailout08.t-online.de with smtp  	id 1N6SmT-0003DF-05; Fri, 06 Nov 2009 18:39:25 +0100
Received: from [10.3.2.2] (bHcOMgZSghb9QhV+phvEKW-9HXxFyp1RcNajPl1RY5FsOv5bqBx5aYqwPc4RAwUw9m@[217.235.173.103]) by fwd05.aul.t-online.de 	with esmtp id 1N6SmJ-1NWU520; Fri, 6 Nov 2009 18:39:15 +0100
Message-ID: <4AF45F43.3090401@t-online.de>
Date: Fri, 06 Nov 2009 17:39:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090825 SeaMonkey/1.1.18
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Allow to disable root privileges  with CYGWIN=noroot
References: <4AC8F299.1020303@t-online.de> <20091004195723.GH4563@calimero.vinschen.de> <20091004200843.GK4563@calimero.vinschen.de> <4ACFAE4D.90502@t-online.de> <20091010100831.GA13581@calimero.vinschen.de> <4AD243ED.6080505@t-online.de> <20091013102502.GG11169@calimero.vinschen.de> <4AD4E38A.2050301@t-online.de> <20091014104003.GA24593@calimero.vinschen.de> <1My1yO-0KvdnE0@fwd09.aul.t-online.de> <20091014120237.GA27964@calimero.vinschen.de> <4AF367BA.2000005@cwilson.fastmail.fm>
In-Reply-To: <4AF367BA.2000005@cwilson.fastmail.fm>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
X-SW-Source: 2009-q4/txt/msg00146.txt.bz2

Charles Wilson wrote:
> Corinna Vinschen wrote:
>   
>> On Oct 14 13:24, Christian Franke wrote:
>>     
>>> Corinna Vinschen wrote:
>>>       
>>>> Cool.  Another interesting option could be to remove the domain admins
>>>> group as well, if the user is a domain user and, of course, removing
>>>> any single user right, similar to the "capsh" tool under SELinux.
>>>>
>>>>         
>>> Yes, makes sense.
>>>
>>>
>>>       
>>>> I'm just not sure if that tool should be part of the Cygwin package or
>>>> a package of its own right.  I'm leaning towards the latter choice.
>>>>
>>>>
>>>>         
>>> ... or add it to the cygutils package ?
>>>       
>> Sure, if Chuck likes the idea.
>>     
>
> I've no objections to incorporating this/these utilities into cygutils.
>  Take a look at
> http://cygwin.com/cgi-bin/cvsweb.cgi/cygutils/HOW-TO-CONTRIBUTE?rev=1.11&cvsroot=cygwin-apps
> to see how best to integrate the tool(s) into cygutils.
>   

I will provide a patch to add the 'cygdrop' tool soon.


Thanks,
Christian
