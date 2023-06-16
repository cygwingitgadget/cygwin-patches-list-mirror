Return-Path: <SRS0=2n0R=CE=shaw.ca=brian.inglis@sourceware.org>
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	by sourceware.org (Postfix) with ESMTPS id CBDC3385771A
	for <cygwin-patches@cygwin.com>; Fri, 16 Jun 2023 00:12:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CBDC3385771A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4001a.ext.cloudfilter.net ([10.228.9.142])
	by cmsmtp with ESMTP
	id 9ryKq5H3cLAoI9x4zq7cMK; Fri, 16 Jun 2023 00:12:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1686874361; bh=+wYZeBDUdg6OwgtRDmxfZuC5jt6zglx3VxN+/8ZUmNM=;
	h=Date:Reply-To:Subject:To:References:From:In-Reply-To;
	b=dkC0nESe+KM6fknJlx1JOPsdJFNtLoLFLwXvcgF06ncrzCb2x5q2EOPBzSWFjTxn/
	 TdKMOK+/+JgB4GvcgYmtVD0mcVMOh+ZiaEfRbP7luYwlaXcInfdJBN7wBZa+IFbh7F
	 xmXD5UOzUo3u9k9Fyp/vVrCuJusT0M3ifNoKUHfxHOOLRBuUOsW/fvtRyIjLt5VS17
	 DFhKIfx5R5chq+DxCDEormJRbZB5nhimmRRDidpdCjwLcYrZ4J71wGKMsGP+TifNEZ
	 5IUSKlypbAYeujpu1o7t99bF840zHU7/nBFFUEF5FLsU4tt7iAtckmTtYRTNkSAPBi
	 T4TRCHaZ6uVNQ==
Received: from [10.0.0.5] ([184.64.102.149])
	by cmsmtp with ESMTP
	id 9x4yqji6SHFsO9x4yqmxmj; Fri, 16 Jun 2023 00:12:41 +0000
X-Authority-Analysis: v=2.4 cv=XZqaca15 c=1 sm=1 tr=0 ts=648ba8f9
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17
 a=IkcTkHD0fZMA:10 a=30KeihfUasEDSKDPGhkA:9 a=QEXdDO2ut3YA:10
Message-ID: <ccd65cfa-aa63-2077-974d-59fdcd44457d@Shaw.ca>
Date: Thu, 15 Jun 2023 18:12:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Reply-To: Brian.Inglis@Shaw.ca
Subject: Re: [PATCH v2 3/3] fhandler/proc.cc: use wincap.has_user_shstk
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <cover.1686095734.git.Brian.Inglis@Shaw.ca>
 <0afbace57b9ee469eb12fba773ef1347f24a8802.1686095734.git.Brian.Inglis@Shaw.ca>
 <ZIq5ng7w4m8LDhA8@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@Shaw.ca>
Organization: Inglis
In-Reply-To: <ZIq5ng7w4m8LDhA8@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFqYgQDvqxexPcbgVE4bMlAKK3p+fTomqAB4k6pchnsGZ9v9speVagbRsnZxEG85O1ww7fU0t7jFYOzx/erfys0bF3OKUPxohXz2lX3kPO+Ii14XxC1K
 fTXU9wsxaMowoaPJp8NB/JQnPl/mnF1PJskeKM7Q9mvKb9imTPoB1mSBYScT9V/NbBk1K+LycfwPYz8SPZhkbzWVG4lTqjrxprw=
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2023-06-15 01:11, Corinna Vinschen wrote:
> Hi Brian,
> 
> thanks, that looks good, except this single snippet:
> 
> On Jun  7 10:37, Brian Inglis wrote:
>> ---
>>   winsup/cygwin/fhandler/proc.cc | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/winsup/cygwin/fhandler/proc.cc b/winsup/cygwin/fhandler/proc.cc
>> index 3c79762e0fbd..2eaf436dc122 100644
>> --- a/winsup/cygwin/fhandler/proc.cc
>> +++ b/winsup/cygwin/fhandler/proc.cc
>> @@ -1486,12 +1486,12 @@ format_proc_cpuinfo (void *, char *&destbuf)
>>   
>>   /*	  ftcprint (features1,  6, "split_lock_detect");*//* MSR_TEST_CTRL split lock */
>>   
>> -      /* cpuid 0x00000007 ecx & Windows [20]20H1/[20]2004+ */
>> -      if (maxf >= 0x00000007 && wincap.osname () >= "10.0"
>> -					 && wincap.build_number () >= 19041)
>> +      /* Windows [20]20H1/[20]2004/19041 user shadow stack */
>> +      if (maxf >= 0x00000007 && wincap.has_user_shstk)
>                                     ^^^^^^^^^^^^^^^^^^^^^
> 
> wincapc::has_user_shstk is a method, accessing the wincaps::has_user_shstk
> member.  The parens are missing.  Consequentially I see an error when
> trying to build it:
> 
>    winsup/cygwin/fhandler/proc.cc:1490:40: error: invalid use of member ‘bool wincapc::has_user_shstk() const’ (did you forget the ‘&’ ?)
>     1490 |       if (maxf >= 0x00000007 && wincap.has_user_shstk)
> 	|                                 ~~~~~~~^~~~~~~~~~~~~~
>    make[4]: *** [Makefile:2068: fhandler/proc.o] Error 1

Sorry - yes - that was a thinko caught by the build, and fixed for a redo before 
testing.
Then I realized I had made the v2 changes after pulling the main branch instead 
of on my local cpuinfo branch, so reset and merged the changes into the 
branches, to put them back to where I thought they should be.
It is likely I either failed to commit or wiped the change, before generating 
patches, as some git operations still rely on SO answers.

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer     but when there is no more to cut
                                 -- Antoine de Saint-Exupéry

