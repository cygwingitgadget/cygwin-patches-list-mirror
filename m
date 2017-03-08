Return-Path: <cygwin-patches-return-8709-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 116421 invoked by alias); 8 Mar 2017 14:26:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 116409 invoked by uid 89); 8 Mar 2017 14:26:21 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-11.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, H*F:D*org.uk, Hx-spam-relays-external:ESMTPA
X-HELO: out1-smtp.messagingengine.com
Received: from out1-smtp.messagingengine.com (HELO out1-smtp.messagingengine.com) (66.111.4.25) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 08 Mar 2017 14:26:20 +0000
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])	by mailout.nyi.internal (Postfix) with ESMTP id 2653820B83	for <cygwin-patches@cygwin.com>; Wed,  8 Mar 2017 09:26:19 -0500 (EST)
Received: from frontend1 ([10.202.2.160])  by compute6.internal (MEProxy); Wed, 08 Mar 2017 09:26:19 -0500
X-ME-Sender: <xms:ixTAWJ5N_WbTw0y6aqzP9B4NLmQklk1WRUmXcGu6Vn2NZtv8wi89Hw>
Received: from [192.168.1.102] (host86-184-210-90.range86-184.btcentralplus.com [86.184.210.90])	by mail.messagingengine.com (Postfix) with ESMTPA id CCAFB7E41F	for <cygwin-patches@cygwin.com>; Wed,  8 Mar 2017 09:26:18 -0500 (EST)
Subject: Re: [PATCH] Export timingsafe_bcmp and timingsafe_memcmp
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20170307123841.16476-1-jon.turney@dronecode.org.uk>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <772958b5-ab74-4325-cb3f-dd52efc0711a@dronecode.org.uk>
Date: Wed, 08 Mar 2017 14:26:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20170307123841.16476-1-jon.turney@dronecode.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2017-q1/txt/msg00050.txt.bz2

On 07/03/2017 12:38, Jon Turney wrote:
> ---
>  winsup/cygwin/common.din               |  2 ++
>  winsup/cygwin/include/cygwin/version.h |  3 ++-
>  winsup/cygwin/release/2.7.2            | 12 ++++++++++++
>  winsup/doc/posix.xml                   |  2 ++
>  4 files changed, 18 insertions(+), 1 deletion(-)
>  create mode 100644 winsup/cygwin/release/2.7.2

per IRC, applied, after correcting for the next release probably being 
2.7.1.
