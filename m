Return-Path: <cygwin-patches-return-8748-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 118481 invoked by alias); 19 Apr 2017 22:20:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 118466 invoked by uid 89); 19 Apr 2017 22:20:19 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.9 required=5.0 tests=AWL,BAYES_00,CYGWIN_OWNER_BODY,RCVD_IN_DNSWL_LOW,RP_MATCHES_RCVD,SPF_PASS autolearn=no version=3.3.2 spammy=bounced, HTo:U*cygwin-patches, respond, cygwin@cygwin.com
X-HELO: sasl.smtp.pobox.com
Received: from pb-smtp1.pobox.com (HELO sasl.smtp.pobox.com) (64.147.108.70) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 19 Apr 2017 22:20:18 +0000
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CD9C690D1	for <cygwin-patches@cygwin.com>; Wed, 19 Apr 2017 18:20:18 -0400 (EDT)
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])	by pb-smtp1.pobox.com (Postfix) with ESMTP id 43D41690D0	for <cygwin-patches@cygwin.com>; Wed, 19 Apr 2017 18:20:18 -0400 (EDT)
Received: from [192.168.1.4] (unknown [76.215.41.237])	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))	(No client certificate requested)	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A8B65690CF	for <cygwin-patches@cygwin.com>; Wed, 19 Apr 2017 18:20:17 -0400 (EDT)
Subject: Re: [PATCH v2] strace: Fix "over-optimization" flaw in strace.
To: cygwin-patches@cygwin.com
References: <20170418100400.GA29220@calimero.vinschen.de> <20170419160602.3952-1-daniel.santos@pobox.com> <20170419184813.GH30642@calimero.vinschen.de> <c124d390-11ce-7951-2f73-8a8ad21408da@pobox.com>
From: Daniel Santos <daniel.santos@pobox.com>
Message-ID: <cbc8f410-dc59-8427-f221-ab43fb8ff0ca@pobox.com>
Date: Wed, 19 Apr 2017 22:20:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <c124d390-11ce-7951-2f73-8a8ad21408da@pobox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Pobox-Relay-ID: 5E4AC0C6-254E-11E7-BA04-E680B56B9B0B-06139138!pb-smtp1.pobox.com
X-IsSubscribed: yes
X-SW-Source: 2017-q2/txt/msg00019.txt.bz2

On 04/19/2017 05:10 PM, Daniel Santos wrote:
> Thanks. I hope this message goes through. Earlier when I tried to 
> respond with both you and cygwin-patches in the To: header it bounced. 
> I emailed cygwin-owner@cygwin.com about this, is that the right 
> address for mailing list problems?

Actually, any email I send with corinna-cygwin@cygwin.com in the To 
header is bounced.

<cygwin@cygwin.com>:
Mail rejected: List address must be in To: or Cc: headers.
See http://sourceware.org/lists.html#sourceware-list-info for more information.


Daniel
