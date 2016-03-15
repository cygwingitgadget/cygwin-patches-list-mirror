Return-Path: <cygwin-patches-return-8402-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 120755 invoked by alias); 15 Mar 2016 09:41:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 120713 invoked by uid 89); 15 Mar 2016 09:41:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_PASS autolearn=no version=3.3.2 spammy=H*M:cygwin, ACK, 2016-03-15, H*Ad:U*yselkowitz
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Tue, 15 Mar 2016 09:41:44 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])	by mx1.redhat.com (Postfix) with ESMTPS id 4A7B34620F	for <cygwin-patches@cygwin.com>; Tue, 15 Mar 2016 09:41:43 +0000 (UTC)
Received: from [10.10.116.22] (ovpn-116-22.rdu2.redhat.com [10.10.116.22])	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u2F9fgfI023554	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)	for <cygwin-patches@cygwin.com>; Tue, 15 Mar 2016 05:41:42 -0400
Subject: Re: [PATCH] Cygwin: define byteswap.h inlines as macros
To: cygwin-patches@cygwin.com
References: <1458011636-8548-1-git-send-email-yselkowi@redhat.com> <20160315090349.GA7819@calimero.vinschen.de> <56E7D285.7090800@cygwin.com> <20160315092214.GA24361@calimero.vinschen.de>
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
Message-ID: <56E7D8D5.1080205@cygwin.com>
Date: Tue, 15 Mar 2016 09:41:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20160315092214.GA24361@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00108.txt.bz2

On 2016-03-15 04:22, Corinna Vinschen wrote:
> On Mar 15 04:14, Yaakov Selkowitz wrote:
>> On 2016-03-15 04:03, Corinna Vinschen wrote:
>>> On Mar 14 22:13, Yaakov Selkowitz wrote:
>>>> The bswap_* "functions" are macros in glibc, so they may be tested for
>>>> by the preprocessor (e.g. #ifdef bswap_16).
>>> ACK.
>>>
>>> While we're at it, what about converting the types to implicit types
>>> (__uint16_t, __uint32_t, __uint64_t).
>>
>> glibc uses short/int/long long for these, so I think we should leave them.
>
> bits/byteswap.h uses __uint64_t, but you're right for the smaller types.

I was looking at a cross-glibc, so that must be a recent change (unless 
you're not looking at x86_64).

-- 
Yaakov
