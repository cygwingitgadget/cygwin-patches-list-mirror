Return-Path: <cygwin-patches-return-8200-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 41440 invoked by alias); 19 Jun 2015 14:05:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 41429 invoked by uid 89); 19 Jun 2015 14:05:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2
X-HELO: out5-smtp.messagingengine.com
Received: from out5-smtp.messagingengine.com (HELO out5-smtp.messagingengine.com) (66.111.4.29) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Fri, 19 Jun 2015 14:05:29 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])	by mailout.nyi.internal (Postfix) with ESMTP id 97B4820745	for <cygwin-patches@cygwin.com>; Fri, 19 Jun 2015 10:05:19 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])  by compute5.internal (MEProxy); Fri, 19 Jun 2015 10:05:25 -0400
Received: from [192.168.1.102] (unknown [86.141.128.210])	by mail.messagingengine.com (Postfix) with ESMTPA id 89FE0680242	for <cygwin-patches@cygwin.com>; Fri, 19 Jun 2015 10:05:18 -0400 (EDT)
Message-ID: <55842196.1070403@dronecode.org.uk>
Date: Fri, 19 Jun 2015 14:05:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: [PATCH 4/5] winsup/doc: Make and install cygwin-api function manpages
References: <1434544626-2516-1-git-send-email-jon.turney@dronecode.org.uk> <1434544626-2516-5-git-send-email-jon.turney@dronecode.org.uk>
In-Reply-To: <1434544626-2516-5-git-send-email-jon.turney@dronecode.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2015-q2/txt/msg00101.txt.bz2

On 17/06/2015 13:37, Jon TURNEY wrote:
> Use 'xmlto man' to make manpages for utils

> -install-man: utils2man.stamp
> +install-man: utils2man.stamp api2man.stamp
>   	@$(MKDIRP) $(DESTDIR)$(man1dir)
>   	$(INSTALL_DATA) *.1 $(DESTDIR)$(man1dir)
> +	@$(MKDIRP) $(DESTDIR)$(man1dir)
> +	$(INSTALL_DATA) *.3 $(DESTDIR)$(man3dir)

I made a cut and paste errror here.  I've pushed the obvious fix.
