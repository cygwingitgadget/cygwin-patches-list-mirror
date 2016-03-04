Return-Path: <cygwin-patches-return-8374-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 98040 invoked by alias); 4 Mar 2016 09:22:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 98022 invoked by uid 89); 4 Mar 2016 09:22:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.0 required=5.0 tests=BAYES_40,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2 spammy=H*F:U*mail, H*r:192.168.111, forces, 04032016
X-HELO: vae.croxnet.de
Received: from vae.croxnet.de (HELO vae.croxnet.de) (136.243.225.97) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Fri, 04 Mar 2016 09:22:54 +0000
Received: from localhost (localhost [127.0.0.1])	by vae.croxnet.de (Postfix) with ESMTP id 957581B03D67	for <cygwin-patches@cygwin.com>; Fri,  4 Mar 2016 10:21:38 +0100 (CET)
Received: from vae.croxnet.de ([127.0.0.1])	by localhost (vae.croxnet.de [127.0.0.1]) (amavisd-new, port 10024)	with ESMTP id Wq7fMLs_-Oli for <cygwin-patches@cygwin.com>;	Fri,  4 Mar 2016 10:21:38 +0100 (CET)
Received: from [192.168.111.49] (ccnat.nibis.de [213.23.76.246])	by vae.croxnet.de (Postfix) with ESMTPSA id 4F8111B03D66	for <cygwin-patches@cygwin.com>; Fri,  4 Mar 2016 10:21:36 +0100 (CET)
From: Patrick Bendorf <mail@patrick-bendorf.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] ccwrap: fix build with non-english locale set
References: <56D3EF72.20504@patrick-bendorf.de> <20160229103339.GB3525@calimero.vinschen.de> <b818ad6d60ddfd3557c3d9e21efc6344@patrick-bendorf.de> <56D43D9B.5020602@dronecode.org.uk> <20160229125813.GE3525@calimero.vinschen.de> <3ecc67c4a2351cf32f28927eea91fc01@patrick-bendorf.de> <56D466A6.1000003@redhat.com> <56D47828.1090208@patrick-bendorf.de> <56D48611.2040704@dronecode.org.uk> <20160304085606.GA8296@calimero.vinschen.de>
Message-ID: <56D953E9.7040207@patrick-bendorf.de>
Date: Fri, 04 Mar 2016 09:22:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20160304085606.GA8296@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00080.txt.bz2

hi corinna,

i might find some time this weekend. this last few days were just
too much to look into the issue.

patrick

Am 04.03.2016 um 09:56 schrieb Corinna Vinschen:
> Patrick,
>
> On Feb 29 17:55, Jon Turney wrote:
>> On 29/02/2016 16:56, Patrick Bendorf wrote:
>>> thanks eric.
>>> just changed and tested it.
>>> hopefully the last patch for this matter.
>>>
>>> @corinna: as attachment to overcome previous problems.
>> Unfortunately, this still isn't quite right, as it forces the 2nd invocation
>> of the compiler to be with LC_ALL, so localized compiler error messages will
>> not be shown for actual compilation problems.
>>
>> So perhaps the setting of LC_ALL should be in the implicitly forked block
>> after the open('-|') ?
> are you going to look into this by any chance?
>
>
> Thanks,
> Corinna
>
