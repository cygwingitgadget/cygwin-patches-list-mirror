Return-Path: <SRS0=lA2L=CH=shaw.ca=brian.inglis@sourceware.org>
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	by sourceware.org (Postfix) with ESMTPS id 2777E3858D38
	for <cygwin-patches@cygwin.com>; Mon, 19 Jun 2023 18:27:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2777E3858D38
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4004a.ext.cloudfilter.net ([10.228.9.227])
	by cmsmtp with ESMTP
	id BHnWqBRorLAoIBJaqqH5cq; Mon, 19 Jun 2023 18:27:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1687199232; bh=AbWopPEmn/8tjkkLadXO8oORPO1GvEaWUMMhM38Rgvg=;
	h=Date:Reply-To:Subject:To:References:From:In-Reply-To;
	b=dDn/+dluzhVY4lpuTdMo7tLFSGiQBoulG/CDoBNd9K3w82eTAwmEBbvWYCoSPZ8TS
	 ZMjO8XzxrTCK7bSiCE6cfI7QrQ3QI817x3wM2BoMV33F1+YNm6dVV22fyLC7ilCm5a
	 NJxlk6ND5HCpBdPsD6B2/AmwxXd2tweiW0HY6HVjJzOk1/NpaUJIYFOKVrblgZyF/c
	 VUaDWkPgg2yGrqTyLftpgAmyi7KhVJaYagWrT93XXyan4X/H+c4zjzgIq7KL3PntPI
	 eWEE4WOSz1ey6tA5LhontsQHgLQ2mdxB5KpgMOddgp8EKq6VM+aEVpshWw6a51xjy2
	 DMmQTT4/J8xVw==
Received: from [10.0.0.5] ([184.64.102.149])
	by cmsmtp with ESMTP
	id BJaqq6RU73fOSBJaqq522h; Mon, 19 Jun 2023 18:27:12 +0000
X-Authority-Analysis: v=2.4 cv=J8G5USrS c=1 sm=1 tr=0 ts=64909e00
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17
 a=IkcTkHD0fZMA:10 a=69BD6x2gdvaEl4HAgncA:9 a=QEXdDO2ut3YA:10
Message-ID: <b28206d5-bbfc-745b-1f69-305010a9939b@Shaw.ca>
Date: Mon, 19 Jun 2023 12:27:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 0/3] use wincap in format_proc_cpuinfo for user_shstk
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <cover.1686934096.git.Brian.Inglis@Shaw.ca>
 <ZIy9JuA2wxH4i37A@calimero.vinschen.de>
 <5786973b-7343-6a8c-38d0-35212d80a2c2@Shaw.ca>
 <ZJAYH8XPa6/fzSGG@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@Shaw.ca>
Organization: Inglis
In-Reply-To: <ZJAYH8XPa6/fzSGG@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfKpPv30VxrMhCYHOLausJy9JkmSGrsTjnvsVQqaR533wi6l+Qaj2kY3rb3SxTbPaAwZYeUofyPzqrnripsGhCutqAUWJ9SjWt3C/AobsI9Wl4cS74TAo
 BhEcT4GTEK/42s5TdAKReIuAS5+C2HinLkXL50QzrF5kpG86JLaTwm3N5G86usL1tniBC5UC2MwU2v34cUnuzkRiIOuGIpdpSEg=
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2023-06-19 02:55, Corinna Vinschen wrote:
> On Jun 16 15:26, Brian Inglis wrote:
>> On 2023-06-16 13:51, Corinna Vinschen wrote:
>>> Hi Brian,
>>>
>>> On Jun 16 11:17, Brian Inglis wrote:
>>
>> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
>>>> Fixes: 41fdb869f998 "fhandler/proc.cc(format_proc_cpuinfo): Add Linux 6.3 cpuinfo"
>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>
>> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
>>>> In test for for AMD/Intel Control flow Enforcement Technology user mode
>>>> shadow stack support replace Windows version tests with test of wincap
>>>> member addition has_user_shstk with Windows version dependent value
>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>
>>> Is that actually the final version?  It's still missing the commit
>>> message text explaining things and the "Fixes" line...
>> Hi Corinna,
>>
>> Is more required above?
> 
> No, it's fine, albeit "Fixes:" is supposed to be kind of like a footer,
> just where the "Signed-off-by:" is, too.
> 
> But it's still only in the cover letter.  As I wrote, it needs to go
> into the actual patch, otherwise all the nice info doesn't make it into
> the git repo.

Ahah - finally got the point, although I wondered about whether a cover could be 
added as a note to the patches, and found that since early 2022 git 2.35+ allows

	$ git ... am --empty=keep --allow-empty ...

to create an empty commit, with the contents of the e-mail message as its log.
As we are on 2.39 you may already know this and prefer to keep the log clear. YMMV
Emailed v4.

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer     but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
