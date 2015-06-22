Return-Path: <cygwin-patches-return-8213-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 89275 invoked by alias); 22 Jun 2015 17:19:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 89260 invoked by uid 89); 22 Jun 2015 17:19:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.7 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2
X-HELO: out5-smtp.messagingengine.com
Received: from out5-smtp.messagingengine.com (HELO out5-smtp.messagingengine.com) (66.111.4.29) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Mon, 22 Jun 2015 17:19:13 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])	by mailout.nyi.internal (Postfix) with ESMTP id 102A320DB4	for <cygwin-patches@cygwin.com>; Mon, 22 Jun 2015 13:19:12 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])  by compute5.internal (MEProxy); Mon, 22 Jun 2015 13:19:12 -0400
Received: from [192.168.1.102] (unknown [86.141.128.210])	by mail.messagingengine.com (Postfix) with ESMTPA id B81B0C00296	for <cygwin-patches@cygwin.com>; Mon, 22 Jun 2015 13:19:11 -0400 (EDT)
Subject: Re: [PATCH 2/5] winsup/doc: Add intro man pages from cygwin-doc
To: cygwin-patches@cygwin.com
References: <1434983976-3612-1-git-send-email-jon.turney@dronecode.org.uk> <1434983976-3612-3-git-send-email-jon.turney@dronecode.org.uk> <20150622151419.GI28301@calimero.vinschen.de>
From: Jon TURNEY <jon.turney@dronecode.org.uk>
Message-ID: <55884387.90405@dronecode.org.uk>
Date: Mon, 22 Jun 2015 17:19:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101 Thunderbird/38.0.1
MIME-Version: 1.0
In-Reply-To: <20150622151419.GI28301@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2015-q2/txt/msg00114.txt.bz2

On 22/06/2015 16:14, Corinna Vinschen wrote:
> A few nits:

Thanks for the detailed review.

>> +      <para>Keep in mind that there are many underlying differences between UNIX
>> +      and Win32 (for example, a case-insensitive file system), making complete
>> +      compatibility an ongoing challenge.</para>
>
> Is "case-insensitive file system" a good example?  For one thing, NTFS
> is a case-sensitive filesystem, and only the Win32 API and the default
> NT kernel setting in the registry enforces case-insensitivity.  See
> https://cygwin.com/cygwin-ug-net/using-specialnames.html#pathnames-casesensitive
>
> What about the OS consequently using UTF-16 as an example?

I don't know if it actually helps to give a specific example here. The 
meaning is plain enough without one.

>> +    <refsect1>
>> +      <title>SEE ALSO</title>
>> +      <para>
>> +	<citerefentry>
>> +	  <refentrytitle>intro</refentrytitle>
>> +	  <manvolnum>1</manvolnum>
>
> Shouldn't that be a 3 here?

I don't think so.  This is a cross-reference to intro.1 in the SEE ALSO 
section of intro.3
