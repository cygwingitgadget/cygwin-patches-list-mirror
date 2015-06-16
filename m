Return-Path: <cygwin-patches-return-8179-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 51845 invoked by alias); 16 Jun 2015 18:50:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 51828 invoked by uid 89); 16 Jun 2015 18:50:40 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2
X-HELO: out5-smtp.messagingengine.com
Received: from out5-smtp.messagingengine.com (HELO out5-smtp.messagingengine.com) (66.111.4.29) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Tue, 16 Jun 2015 18:50:39 +0000
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])	by mailout.nyi.internal (Postfix) with ESMTP id DB7CA210BB	for <cygwin-patches@cygwin.com>; Tue, 16 Jun 2015 14:50:36 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])  by compute4.internal (MEProxy); Tue, 16 Jun 2015 14:50:36 -0400
Received: from [192.168.1.102] (unknown [86.141.128.210])	by mail.messagingengine.com (Postfix) with ESMTPA id 7A518C00019	for <cygwin-patches@cygwin.com>; Tue, 16 Jun 2015 14:50:36 -0400 (EDT)
Message-ID: <55806FF7.3010600@dronecode.org.uk>
Date: Tue, 16 Jun 2015 18:50:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 5/8] winsup/doc: Convert utils.xml to using refentry
References: <1434371793-3980-1-git-send-email-jon.turney@dronecode.org.uk> <1434371793-3980-6-git-send-email-jon.turney@dronecode.org.uk> <20150615171147.GE26901@calimero.vinschen.de> <557FEC25.8030303@dronecode.org.uk> <20150616094501.GC31537@calimero.vinschen.de> <558003FD.8060208@dronecode.org.uk> <20150616124934.GD31537@calimero.vinschen.de> <55805DF6.5040004@dronecode.org.uk> <20150616174933.GG31537@calimero.vinschen.de>
In-Reply-To: <20150616174933.GG31537@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2015-q2/txt/msg00080.txt.bz2

On 16/06/2015 18:49, Corinna Vinschen wrote:
>> Note that the next time you build documentation for the website, you might
>> need to take some special steps to add new .html files.
>
> -v, please?

Sorry, I wasn't being intentionally vague, but I don't know precisely 
how you push documentation updates.

I guess you will need to do a 'cvs add *.html'

>> and next time you build a package you might need to take some special steps
>> to exclude /usr/share/man/
>
> What special steps?  I assume a `make install' will install the
> additional man pages now.  Wouldn't it make sense to install them as
> part of the Cygwin package then, rather than as part of cygwin-doc?

Ultimately, I think it would be a good idea if cygwin-doc was generated 
by the same process which builds the cygwin(|-devel|-debuginfo) packages.

But we are some way from there yet.

My thought was that the simplest way to do the transition is to exclude 
all the files currently owned by cygwin-doc until then, but maybe you 
have a different idea.
