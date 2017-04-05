Return-Path: <cygwin-patches-return-8731-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 74209 invoked by alias); 5 Apr 2017 11:03:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 74149 invoked by uid 89); 5 Apr 2017 11:03:17 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-3.7 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2 spammy=H*M:aaa5, gir, HTo:U*cygwin-patches, Hx-spam-relays-external:ESMTPA
X-HELO: out1-smtp.messagingengine.com
Received: from out1-smtp.messagingengine.com (HELO out1-smtp.messagingengine.com) (66.111.4.25) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 05 Apr 2017 11:03:16 +0000
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])	by mailout.nyi.internal (Postfix) with ESMTP id 8353220BAA	for <cygwin-patches@cygwin.com>; Wed,  5 Apr 2017 07:03:16 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])  by compute6.internal (MEProxy); Wed, 05 Apr 2017 07:03:16 -0400
X-ME-Sender: <xms:9M7kWBAr1hG8BYNkc8hxekuFbDSmPbfhnWSYpN17FBbKXY5AGuwisw>
Received: from [192.168.1.102] (host86-179-113-198.range86-179.btcentralplus.com [86.179.113.198])	by mail.messagingengine.com (Postfix) with ESMTPA id 26F47243CE	for <cygwin-patches@cygwin.com>; Wed,  5 Apr 2017 07:03:16 -0400 (EDT)
Subject: Re: [PATCH] Make ldd stop after any non-continuable exception
To: cygwin-patches@cygwin.com
References: <20170404175110.171404-1-jon.turney@dronecode.org.uk> <20170405074234.GA31927@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <a4e6a546-aaa5-5ea7-4523-38486b850c14@dronecode.org.uk>
Date: Wed, 05 Apr 2017 11:03:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170405074234.GA31927@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2017-q2/txt/msg00002.txt.bz2

On 05/04/2017 08:42, Corinna Vinschen wrote:
> On Apr  4 18:51, Jon Turney wrote:
>> Ensure that ldd always stops when the exception is flagged as
>> non-continuable.
>>
>> Also arrange for ldd to exit with a non-zero exit code if something went
>> wrong which prevented us from listing all dynamic dependencies.
>
> Patch is ok.  In what situation occurs this?

So...

Running the meson test suite on AppVeyor, some of the GNOME gir tests 
hang.  It looks like g-ir-scanner tries to discover something by 
building an executable, then running ldd on it, which was looping like this.

I can't reproduce it locally :(

