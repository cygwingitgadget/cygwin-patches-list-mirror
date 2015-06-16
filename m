Return-Path: <cygwin-patches-return-8169-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16377 invoked by alias); 16 Jun 2015 09:22:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 16365 invoked by uid 89); 16 Jun 2015 09:22:09 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2
X-HELO: out5-smtp.messagingengine.com
Received: from out5-smtp.messagingengine.com (HELO out5-smtp.messagingengine.com) (66.111.4.29) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Tue, 16 Jun 2015 09:22:08 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])	by mailout.nyi.internal (Postfix) with ESMTP id 920C420D3F	for <cygwin-patches@cygwin.com>; Tue, 16 Jun 2015 05:22:06 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])  by compute5.internal (MEProxy); Tue, 16 Jun 2015 05:22:06 -0400
Received: from [192.168.1.102] (unknown [86.141.128.210])	by mail.messagingengine.com (Postfix) with ESMTPA id 2D81368009D	for <cygwin-patches@cygwin.com>; Tue, 16 Jun 2015 05:22:06 -0400 (EDT)
Message-ID: <557FEAB9.5040404@dronecode.org.uk>
Date: Tue, 16 Jun 2015 09:22:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/8] winsup/doc: Some preparatory XML fixes
References: <1434371793-3980-1-git-send-email-jon.turney@dronecode.org.uk> <1434371793-3980-4-git-send-email-jon.turney@dronecode.org.uk> <20150615170445.GC26901@calimero.vinschen.de>
In-Reply-To: <20150615170445.GC26901@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2015-q2/txt/msg00070.txt.bz2

On 15/06/2015 18:04, Corinna Vinschen wrote:
> On Jun 15 13:36, Jon TURNEY wrote:
>> Remove the inconsistent .exe suffix in strace and umount usage lines.
>>
>> Consistently refer to cross-references outside utils.xml as being in the Cygwin
>> User's Guide.  This helps to generate sensible looking references in generated
>> manpages.
>
> ... but it generates a bit of clutter in the HTML user guide itself.
> Any chance to add those *only* to the man pages?

Ok, I'll look into how to do that.
