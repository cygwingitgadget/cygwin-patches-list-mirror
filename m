Return-Path: <cygwin-patches-return-8752-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15446 invoked by alias); 21 Apr 2017 02:17:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 15365 invoked by uid 89); 21 Apr 2017 02:17:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.7 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,RP_MATCHES_RCVD,SPF_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:258, HTo:U*cygwin-patches
X-HELO: sasl.smtp.pobox.com
Received: from pb-smtp2.pobox.com (HELO sasl.smtp.pobox.com) (64.147.108.71) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 21 Apr 2017 02:17:36 +0000
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])	by pb-smtp2.pobox.com (Postfix) with ESMTP id 631DA7F9C5	for <cygwin-patches@cygwin.com>; Thu, 20 Apr 2017 22:17:36 -0400 (EDT)
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5C1237F9C4	for <cygwin-patches@cygwin.com>; Thu, 20 Apr 2017 22:17:36 -0400 (EDT)
Received: from [192.168.1.4] (unknown [76.215.41.237])	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))	(No client certificate requested)	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A2E357F9C3	for <cygwin-patches@cygwin.com>; Thu, 20 Apr 2017 22:17:35 -0400 (EDT)
Subject: Re: [PATCH v2] strace: Fix "over-optimization" flaw in strace.
To: cygwin-patches@cygwin.com
References: <20170418100400.GA29220@calimero.vinschen.de> <20170419160602.3952-1-daniel.santos@pobox.com> <20170419184813.GH30642@calimero.vinschen.de> <c124d390-11ce-7951-2f73-8a8ad21408da@pobox.com> <cbc8f410-dc59-8427-f221-ab43fb8ff0ca@pobox.com> <20170420084542.GA16686@calimero.vinschen.de>
From: Daniel Santos <daniel.santos@pobox.com>
Message-ID: <36fad68f-481b-9da8-93e7-565ef3c14026@pobox.com>
Date: Fri, 21 Apr 2017 02:17:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20170420084542.GA16686@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Pobox-Relay-ID: AF3318E0-2638-11E7-B260-C260AE2156B6-06139138!pb-smtp2.pobox.com
X-IsSubscribed: yes
X-SW-Source: 2017-q2/txt/msg00023.txt.bz2

On 04/20/2017 03:45 AM, Corinna Vinschen wrote:
> Yes, it's a write-only mail address.  Please send stuff only to the
> respective mailing list.

Oh, I see. Thanks for the clarification.

Daniel
