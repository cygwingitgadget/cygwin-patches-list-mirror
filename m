Return-Path: <cygwin@hamishmb.com>
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
	by sourceware.org (Postfix) with ESMTPS id 0B0E03858C78
	for <cygwin-patches@cygwin.com>; Wed, 26 Oct 2022 10:36:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 0B0E03858C78
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=hamishmb.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=hamishmb.com
ARC-Seal: i=1; a=rsa-sha256; t=1666780579; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=jhE8LEGjjbxymjg+1uK4mrBMJS93gI45n8wtyIOSUgQdDKZisjerRWzyWZOo5vPLl7v92j4YwXzMqt4Wd6Og2AaENYtSv0xwR9Xl6z0cluTSmJjon0BAhFVzxtUzsTMCp1LH+3qOkZ8O6dUp0NLA+nzk+aNjoBIIsxjdr+zVc7U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1666780579; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=6vxq73u7QkgFpuxDSk64JAB5dlIz3L4qbAXoEkEQAlo=; 
	b=MsFFdHaQpnNwQgQgiplrt5/aY4Zf2begOZ+hTLtSZt3d/+L2J+vhSMyA6cXOsQDLLzcloX4PgOc9wFGuMvKlHn0YDofqozuwXUhYOlODUyeouKSzPfz8fpJ0zsgL0Pv4Dc/UOczC0NzpHTqomhofEpK15PQfHZFFGdcByHxcQ+E=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=hamishmb.com;
	spf=pass  smtp.mailfrom=cygwin@hamishmb.com;
	dmarc=pass header.from=<cygwin@hamishmb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1666780579;
	s=zmail; d=hamishmb.com; i=cygwin@hamishmb.com;
	h=Message-ID:Date:Date:MIME-Version:From:From:Subject:Subject:To:To:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=6vxq73u7QkgFpuxDSk64JAB5dlIz3L4qbAXoEkEQAlo=;
	b=JX5bDjKiZP2SSEFPVQPrdinKHZBC9Z2t/eXT7gpuUbtmXzYx1f7gpfnY43WpKWbN
	Vuyqku6+vuPHmleWLLVqKYcULJz2yQJINmcRVEYXC+EE8LA6TTJkY4Hc+FK3p0rI+zR
	OOW6EzwV3faTADQBxk0RL7Hc/FtTEFJxGxvDpuYY=
Received: from [192.168.10.213] (host86-149-41-78.range86-149.btcentralplus.com [86.149.41.78]) by mx.zoho.eu
	with SMTPS id 1666780579134735.3958948531134; Wed, 26 Oct 2022 12:36:19 +0200 (CEST)
Message-ID: <eece3c48-bd1b-6fde-63dd-43bd7ce7c92a@hamishmb.com>
Date: Wed, 26 Oct 2022 11:36:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
From: Hamish McIntyre-Bhatty <cygwin@hamishmb.com>
Subject: Re: [PATCH] Fix typo in faq-programming.xml
To: cygwin-patches@cygwin.com
References: <6a50dd6a-e805-bbf0-200a-25a1892bfa5b@hamishmb.com>
 <Y1jsMppSUV5oH++z@calimero.vinschen.de>
Content-Language: en-US
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
>> This is my first time submitting a patch over email, so hopefully 
>> I'll get
>> it right. Are there eventually plans for submitting merge requests 
>> directly
>> with git in some way?
> No, but by email is usually simple by using `git format-patch' and
> `git send-email'.
>
>> This is a simple one-line patch to fix a typo I noticed in the 
>> programming
>> FAQ. Patch follows below. I follow the list via GMANE, but to make sure I
>> see any replies, it's probably best to reply to cygwin at hamishmb 
>> dot com.
> The only problem with your patch is that all this text will become
> part of the commit message. What you should do is this:
>
> - Hack your patch
>
> - Commit it locally with a headline, an empty line, and a bit of
> descriptive text as commit message. if it's an obvious patch,
> the headline may be sufficient.
>
> - git format-patch -1
> This creates a file like 0001-foo.patch
>
> - Now, if you want to add text to your mail which is *not* supposed
> to become part of the commit message, open the 0001-foo.patch file
> in your editor and add the editoral notes *after* the line consisting
> of only three dashes.
>
> - Last, but not least, send the patch to the mailing list. Assuming
> you did set user.email in your git config:
>
> git send-email --to='cygwin-patches@...' 0001-foo.patch
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
>> diff --git a/winsup/doc/faq-programming.xml 
>> b/winsup/doc/faq-programming.xml
>> index c2c4004c1..7945b6b88 100644
>> --- a/winsup/doc/faq-programming.xml
>> +++ b/winsup/doc/faq-programming.xml
>> @@ -1051,7 +1051,7 @@ a Windows environment which Cygwin handles
>> automatically.
>> <question><para>How should I port my Unix GUI to 
>> Windows?</para></question>
>> <answer>
>>
>> -<para>Like other Unix-like platforms, the Cygwin distribtion 
>> includes many
>> of
>> +<para>Like other Unix-like platforms, the Cygwin distribution 
>> includes many
>> of
>> the common GUI toolkits, including X11, X Athena widgets, Motif, Tk, 
>> GTK+,
>> and Qt. Many programs which rely on these toolkits will work with little,
>> if
>> any, porting work if they are otherwise portable. However, there are 
>> a few
