Return-Path: <cygwin-patches-return-8370-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 62726 invoked by alias); 29 Feb 2016 17:55:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 62709 invoked by uid 89); 29 Feb 2016 17:55:48 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.4 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2 spammy=overcome, invocation, HTo:U*cygwin-patches, Hx-spam-relays-external:ESMTPA
X-HELO: out2-smtp.messagingengine.com
Received: from out2-smtp.messagingengine.com (HELO out2-smtp.messagingengine.com) (66.111.4.26) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Mon, 29 Feb 2016 17:55:47 +0000
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])	by mailout.nyi.internal (Postfix) with ESMTP id 1AA02206F5	for <cygwin-patches@cygwin.com>; Mon, 29 Feb 2016 12:55:45 -0500 (EST)
Received: from frontend2 ([10.202.2.161])  by compute1.internal (MEProxy); Mon, 29 Feb 2016 12:55:45 -0500
Received: from [192.168.1.102] (host86-184-210-93.range86-184.btcentralplus.com [86.184.210.93])	by mail.messagingengine.com (Postfix) with ESMTPA id 94C2E6800F2	for <cygwin-patches@cygwin.com>; Mon, 29 Feb 2016 12:55:44 -0500 (EST)
Subject: Re: [PATCH] ccwrap: fix build with non-english locale set
References: <56D3EF72.20504@patrick-bendorf.de> <20160229103339.GB3525@calimero.vinschen.de> <b818ad6d60ddfd3557c3d9e21efc6344@patrick-bendorf.de> <56D43D9B.5020602@dronecode.org.uk> <20160229125813.GE3525@calimero.vinschen.de> <3ecc67c4a2351cf32f28927eea91fc01@patrick-bendorf.de> <56D466A6.1000003@redhat.com> <56D47828.1090208@patrick-bendorf.de>
To: Cygwin Patches <cygwin-patches@cygwin.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <56D48611.2040704@dronecode.org.uk>
Date: Mon, 29 Feb 2016 17:55:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <56D47828.1090208@patrick-bendorf.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2016-q1/txt/msg00076.txt.bz2

On 29/02/2016 16:56, Patrick Bendorf wrote:
> thanks eric.
> just changed and tested it.
> hopefully the last patch for this matter.
>
> @corinna: as attachment to overcome previous problems.

Unfortunately, this still isn't quite right, as it forces the 2nd 
invocation of the compiler to be with LC_ALL, so localized compiler 
error messages will not be shown for actual compilation problems.

So perhaps the setting of LC_ALL should be in the implicitly forked 
block after the open('-|') ?
