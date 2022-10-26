Return-Path: <hamish@hamishmb.com>
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
	by sourceware.org (Postfix) with ESMTPS id 0535E3858037
	for <cygwin-patches@cygwin.com>; Wed, 26 Oct 2022 10:35:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 0535E3858037
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=hamishmb.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=hamishmb.com
ARC-Seal: i=1; a=rsa-sha256; t=1666780543; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=QUhUB8Tno2Sq/5ZG2RrnMc4N129eh9YfjJ30J70kawPPOJNZMidTVkixY1Gjz2KMsyOPIejP8Uye2USjvw/OsW9JNVXczaxRIVnvywznyrG0W//uK+03ecL8VkgUKAxNyfVaCaVyP91vanP9krvTyIsCzrG5x27tbuFKDKy7mHo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1666780543; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=tW1V916t2vPbUyP2h4igZM8iWGr0+5OodrQLFql2wLg=; 
	b=bVAufvo8+Kc16uOY5ixz5BZHUWFzrKS4WwQgJsE7/Gp+E+9sziB+LgmUxcDWEff0L4Slr/lR5+5aRBmxf6iA5wjKEn6dxL6qS/EmtMVlfxvGLmlOK9VyV2QkGs9l79Ddol97HAe54w5w03Lfb0zkmEYnRmyGKGrnkknmmhRm2yw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=hamishmb.com;
	spf=pass  smtp.mailfrom=hamish@hamishmb.com;
	dmarc=pass header.from=<hamish@hamishmb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1666780543;
	s=zmail; d=hamishmb.com; i=hamish@hamishmb.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=tW1V916t2vPbUyP2h4igZM8iWGr0+5OodrQLFql2wLg=;
	b=ibDCmvbHTMB9OL5qd/VW85gdNXP6KT60rqbiqmH0/xM0oap89Mzturc0CNaK29TU
	aXyU4A2VNNcujhDOzTYCzkDaSfIMBHjlEHS8NLM20noJzwbTJAejXi0f/F4Chi1uCv5
	+10JWp+ofUIKzmdDbU37qbbgmlW0KP6dxbNMcOgs=
Received: from [192.168.10.213] (host86-149-41-78.range86-149.btcentralplus.com [86.149.41.78]) by mx.zoho.eu
	with SMTPS id 1666780541852467.97633489489215; Wed, 26 Oct 2022 12:35:41 +0200 (CEST)
Message-ID: <1e43af8d-ff89-f4d3-8fc6-19d21e201e8e@hamishmb.com>
Date: Wed, 26 Oct 2022 11:35:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] Fix typo in faq-programming.xml
Content-Language: en-US
To: cygwin-patches@cygwin.com
References: <6a50dd6a-e805-bbf0-200a-25a1892bfa5b@hamishmb.com>
 <Y1jsMppSUV5oH++z@calimero.vinschen.de>
From: Hamish McIntyre-Bhatty <hamish@hamishmb.com>
In-Reply-To: <Y1jsMppSUV5oH++z@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

Thanks for the feedback and advice. I was under the impression that `git 
send-email` required postfix to be set up, but it looks like I was wrong.

Thanks for the simple explanation - I'll try doing it the right way I 
think, and submit the patch again.

Cheers,

Hamish

On 26/10/2022 09:13, Corinna Vinschen wrote:
> Hi Hamish,
>
> Thanks for the patch.
>
> On Oct 25 19:50, Hamish McIntyre-Bhatty wrote:
>> Hi there,
>>
>> This is my first time submitting a patch over email, so hopefully I'll get
>> it right. Are there eventually plans for submitting merge requests directly
>> with git in some way?
> No, but by email is usually simple by using `git format-patch' and
> `git send-email'.
>
>> This is a simple one-line patch to fix a typo I noticed in the programming
>> FAQ. Patch follows below. I follow the list via GMANE, but to make sure I
>> see any replies, it's probably best to reply to cygwin at hamishmb dot com.
> The only problem with your patch is that all this text will become
> part of the commit message.  What you should do is this:
>
> - Hack your patch
>
> - Commit it locally with a headline, an empty line, and a bit of
>    descriptive text as commit message.  if it's an obvious patch,
>    the headline may be sufficient.
>
> - git format-patch -1
>    This creates a file like 0001-foo.patch
>
> - Now, if you want to add text to your mail which is *not* supposed
>    to become part of the commit message, open the 0001-foo.patch file
>    in your editor and add the editoral notes *after* the line consisting
>    of only three dashes.
>
> - Last, but not least, send the patch to the mailing list.  Assuming
>    you did set user.email in your git config:
>
>    git send-email --to='cygwin-patches@...' 0001-foo.patch
>
> Do you want to try that or shall I push this with just the headline as
> commit?
>
>
> Thanks,
> Corinna
>
>> Hamish
>>
>> diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xml
>> index c2c4004c1..7945b6b88 100644
>> --- a/winsup/doc/faq-programming.xml
>> +++ b/winsup/doc/faq-programming.xml
>> @@ -1051,7 +1051,7 @@ a Windows environment which Cygwin handles
>> automatically.
>>   <question><para>How should I port my Unix GUI to Windows?</para></question>
>>   <answer>
>>
>> -<para>Like other Unix-like platforms, the Cygwin distribtion includes many
>> of
>> +<para>Like other Unix-like platforms, the Cygwin distribution includes many
>> of
>>   the common GUI toolkits, including X11, X Athena widgets, Motif, Tk, GTK+,
>>   and Qt. Many programs which rely on these toolkits will work with little,
>> if
>>   any, porting work if they are otherwise portable.  However, there are a few
