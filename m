Return-Path: <cygwin-patches-return-8658-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 74438 invoked by alias); 15 Dec 2016 13:09:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 73473 invoked by uid 89); 15 Dec 2016 13:09:27 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.4 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, Hx-spam-relays-external:ESMTPA
X-HELO: out3-smtp.messagingengine.com
Received: from out3-smtp.messagingengine.com (HELO out3-smtp.messagingengine.com) (66.111.4.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 15 Dec 2016 13:09:17 +0000
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])	by mailout.nyi.internal (Postfix) with ESMTP id E3C6620622	for <cygwin-patches@cygwin.com>; Thu, 15 Dec 2016 08:09:15 -0500 (EST)
Received: from frontend2 ([10.202.2.161])  by compute6.internal (MEProxy); Thu, 15 Dec 2016 08:09:15 -0500
X-ME-Sender: <xms:-5VSWF27j6Py10gDVKG3LkRsWlJU0nA1XXOxWh76ah3_yMpcq8o2Mg>
Received: from [192.168.1.102] (host86-179-112-226.range86-179.btcentralplus.com [86.179.112.226])	by mail.messagingengine.com (Postfix) with ESMTPA id 8708B24430	for <cygwin-patches@cygwin.com>; Thu, 15 Dec 2016 08:09:15 -0500 (EST)
Subject: Re: [PATCH] Fix some broken links in Cygwin FAQ
To: cygwin-patches@cygwin.com
References: <20161214180208.34760-1-jon.turney@dronecode.org.uk> <20161214220657.GD5890@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <90548463-08bb-d252-4b58-7adc8786569e@dronecode.org.uk>
Date: Thu, 15 Dec 2016 13:09:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161214220657.GD5890@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2016-q4/txt/msg00016.txt.bz2

On 14/12/2016 22:06, Corinna Vinschen wrote:
> On Dec 14 18:02, Jon Turney wrote:
>> GNU no longer encourages the use of documentation mirrors, to avoid
>> referring to obsolete documentation.  Also www.fsf.org/manual/ is
>> just a redirect to www.fsf.org/manual
>
> :)

Bah.

"www.fsf.org/manual/ is just a redirect to www.gnu.org/manual/"

The sentence with this link is repeated, but we get it right once (Q1.3) 
and then wrong (Q3.1)

>> Links to using-utils.html #fragments are no longer correct as each utility
>> is now a separate page, since 646745cb.
>>
>> indiana.edu seems to have moved XLiveCD information, without a redirect.
>>
>> Linking to clean_setup.pl on cygwin.com doesn't work, as direct downloads
>> aren't allowed, so instead state where it can be found on a mirror.
>
> Ack.  Please apply.

Done.
