Return-Path: <cygwin-patches-return-7714-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17208 invoked by alias); 3 Sep 2012 03:05:34 -0000
Received: (qmail 17196 invoked by uid 22791); 3 Sep 2012 03:05:33 -0000
X-SWARE-Spam-Status: No, hits=-7.9 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,KHOP_RCVD_TRUST,KHOP_THREADED,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_W,RCVD_IN_HOSTKARMA_WL
X-Spam-Check-By: sourceware.org
Received: from out1-smtp.messagingengine.com (HELO out1-smtp.messagingengine.com) (66.111.4.25)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 03 Sep 2012 03:05:20 +0000
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id A6B8F20878	for <cygwin-patches@cygwin.com>; Sun,  2 Sep 2012 23:05:19 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])  by compute1.internal (MEProxy); Sun, 02 Sep 2012 23:05:19 -0400
Received: from [158.147.137.170] (unknown [158.147.137.170])	by mail.messagingengine.com (Postfix) with ESMTPA id 441278E03CC;	Sun,  2 Sep 2012 23:05:19 -0400 (EDT)
Message-ID: <50441E6B.7060703@cwilson.fastmail.fm>
Date: Mon, 03 Sep 2012 03:05:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
Reply-To: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows NT 5.2; WOW64; rv:15.0) Gecko/20120824 Thunderbird/15.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] suggestion for faster pseudo-reloc.
References: <503982F3.9010004@gmail.com> <20120902102718.GC13401@calimero.vinschen.de> <50439CAE.6080603@gmail.com>
In-Reply-To: <50439CAE.6080603@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q3/txt/msg00035.txt.bz2

On 9/2/2012 1:51 PM, Jin-woo Ye wrote:
> Now it is clear that this patch would be needed other relevant projects
> such as mingw, mingw-w64. thanks for your effort on simplified one.

Yes, while it is not required that all of those systems stay exactly in
sync, there has been some effort in ensuring that the pseudo-reloc
implementation used by all three remains very similar if not identical.

Please bring this patch to the attention of the mingw.org and
mingw64.sf.net people, if it's not too much trouble.

--
Chuck

