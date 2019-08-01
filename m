Return-Path: <cygwin-patches-return-9542-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 70138 invoked by alias); 1 Aug 2019 09:29:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 69785 invoked by uid 89); 1 Aug 2019 09:29:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-5.7 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=UD:cygwin.com, cygwincom, cygwin.com, retry
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 01 Aug 2019 09:29:29 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 11:28:45 +0200
Received: from fril0049.wamas.com ([172.28.42.244])	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1ht7O8-0006VK-OM; Thu, 01 Aug 2019 11:28:44 +0200
Subject: Re: [PATCH v2 0/2] silent fork retry with shm (broke emacs-X11)
To: cygwin-patches@cygwin.com
References: <20190730160754.GZ11632@calimero.vinschen.de> <20190731103531.559-1-michael.haubenwallner@ssi-schaefer.com> <20190731165913.GB11632@calimero.vinschen.de> <72d7798e-de3c-4e21-33bf-074e06e3e11d@cornell.edu>
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Openpgp: preference=signencrypt
Message-ID: <600ae389-cdf7-b3f6-f7f1-2bdff2ef221c@ssi-schaefer.com>
Date: Thu, 01 Aug 2019 09:29:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <72d7798e-de3c-4e21-33bf-074e06e3e11d@cornell.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SW-Source: 2019-q3/txt/msg00062.txt.bz2

On 7/31/19 7:25 PM, Ken Brown wrote:
> On 7/31/2019 12:59 PM, Corinna Vinschen wrote:
>> On Jul 31 12:35, Michael Haubenwallner wrote:
>>> On 7/30/19 6:07 PM, Corinna Vinschen wrote:
>>>> On Jul 30 17:22, Michael Haubenwallner wrote:
>>>>> Hi,
>>>>>
>>>>> following up
>>>>> https://cygwin.com/ml/cygwin-patches/2019-q2/msg00155.html
>>>>>
>>>>> It turns out that fixup_shms_after_fork does require the child pinfo to
>>>>> be "remember"ed, while the fork retry to be silent on failure requires
>>>>> the child to not be "attach"ed yet.
>>>>>
>>>>> As current pinfo.remember performs both "remember" and "attach" at once,
>>>>> the first patch does introduce pinfo.remember_without_attach, to not
>>>>> change current behaviour of pinfo.remember and keep patches small.
>>>>>
>>>>> However, my first thought was to clean up pinfo API a little and have
>>>>> remember not do both "remember+attach" at once, but introduce some new
>>>>> remember_and_attach method instead.  But then, when 'bool detach' is
>>>>> true, the "_and_attach" does feel wrong.
>>>>
>>>> I'd prefer to drop the reattach call from remember, calling both of them
>>>> where appropriate.
>>>>
>>>
>>> Fine with me, even if that looks a little more complicated for spawn.
>>
>> Pushed, with just a small formatting tweak.
> 
> I can confirm that this fixes the problem I reported in 
> https://cygwin.com/ml/cygwin-patches/2019-q2/msg00155.html.
> 

Corinna, Ken: Thanks a lot!
/haubi/
