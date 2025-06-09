Return-Path: <SRS0=6Xew=YY=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	by sourceware.org (Postfix) with ESMTPS id DEEEC382D0EF
	for <cygwin-patches@cygwin.com>; Mon,  9 Jun 2025 22:20:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DEEEC382D0EF
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DEEEC382D0EF
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.10
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1749507634; cv=none;
	b=kh/HSRqvDMwL7X9/V+h2qewaa+sTFsA7C7TYS0XVFsQ3DwYsoBrCkWD5oPEf1V7II5mt8TlQldkk34WrjVcac8Wn+of7dAIFvAy39bGawslHqUE2XYbxkZCTkBuOuH4wdWoxtcvTpnSmNchFSXoh98EKW7OsCFmIqSN1lvskSUw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1749507634; c=relaxed/simple;
	bh=41aygscaqjXf8xAZtsJrHpPs+vG9j7x+lrbABTTW7i4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=t1esN227kCNcF4D1/AncQpAyrHuDfStVWtxqBtzBrSe3NZujCcZ1KwXuvTSkG+6ioB5bRvhFVfNmSICx8EmEVK/OiE5p4o4Rb2EaujR3MHAky3fnbEyF0Io9pJYaJPzwNAlW7Z79AHt4ochkIGUfpA5pHG4A9rRh7E0cGXXKjz8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DEEEC382D0EF
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=UokTlriV
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 9385C804A1
	for <cygwin-patches@cygwin.com>; Mon,  9 Jun 2025 22:20:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf12.hostedemail.com (Postfix) with ESMTPA id 28D4219
	for <cygwin-patches@cygwin.com>; Mon,  9 Jun 2025 22:20:32 +0000 (UTC)
Message-ID: <0f598539-d282-47d8-817a-4c3fc4f7235e@SystematicSW.ab.ca>
Date: Mon, 9 Jun 2025 16:20:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix compatibility with MinGW v13 headers
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <DB9PR83MB09238924363B70583AA08BA5926BA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <7178d417-9d6b-14b2-95cb-b5c4fb53b463@jdrake.com>
 <1ef68eee-d80a-4dde-af43-c4fdea1e4c40@SystematicSW.ab.ca>
 <2aa8fb0c-9a96-b260-2f28-aea8dab08bcc@jdrake.com>
Organization: Systematic Software
In-Reply-To: <2aa8fb0c-9a96-b260-2f28-aea8dab08bcc@jdrake.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 28D4219
X-Stat-Signature: sg5kqm3yna11xrdkkodehj5wk8weby74
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX19VtA0gCjAr6ocJ3MvTBaspcpzUTfgoNfk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=WWM1/P838giVplxg4ElG7fvFOhwTeVZqjdi5IRc1GKg=; b=UokTlriVW4ZS6Ouq7F8g3VWbf3wV0rpfVimNNIImNh1beVyX1vQlO5QXZ86I6um6RS7c7M0/Ib9uAY2bKNF+7Sii1HGaa7aYPjNtX0/pnpNFAJLj64hfLoNFyRDRcIDoXqGTTB3ITiPdvuRosZpUoyCWOmfNmzTrV8ksWFjui0wbUQuFebA8VXZ/wdWATFwmOuW+vCdhvzfE9nu0ZvKSgJUv+Tw5U/aLrAcH/4AujtE+JikQpU5aHAU5MELzE58IU1YC4tJJUktVZhLe+Xaq7rtOWQLKDFs30KoCCcHAzscSzgRDae0bU/SZe7WC0NeQGdElbnT372CFScbouwkEyw==
X-HE-Tag: 1749507632-220632
X-HE-Meta: U2FsdGVkX1/GYGGxnlwTyLu3vHN/pA+rEfzlKQPlo/Ke+23gJESFQkx8OGZ46j1HGDC22G5GSQs19+UElyKCEJlI+jVR07bONWJe+SgKGOrY/bHS50vJ5OG1qIbPRLB7NQmDlTymRPhehZYSTVPcP/qEmdKhfXWAo0RVfzslDZwBNzT1KSGB2+SeXK+muFUW5QqvB4gGlTFJPaEyW5XRxTmK6j2kF82z3Ew9q99lp3hUw0s2RNW26/y5hE6DQM/2CfqEQoj+KuoTciPndkSHUs93EJTsXMNCPWXKUA0ncLZJ+DKI6JcYiQfwRE+6DVn3HzMYZoZ8E4GvwbEtcqXQ86iiJ0jOmZJ+nlNB6bXW3rsi80U8mo2BSrWj4C08lcG2aGcVZWOfCLk=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-06-09 15:56, Jeremy Drake via Cygwin-patches wrote:
> On Mon, 9 Jun 2025, Brian Inglis wrote:
> 
>> On 2025-06-09 12:54, Jeremy Drake via Cygwin-patches wrote:
>>> On Mon, 9 Jun 2025, Radek Barton via Cygwin-patches wrote:
>>>> Since today,
>>>> https://github.com/cygwin/cygwin/actions/runs/15537033468 workflow started
>>>> to fail as it seems that `cygwin/cygwin-install-action@master` action
>>>> started to use newer MinGW headers.
>>>>
>>>> The attached patch fixes compatibility with v13 MinGW headers while
>>>> preserving compatibility with v12.
>>
>> Perhaps in the case of this build, but not necessarily anywhere else in Cygwin
>> using BSD sockets.
>>
>>> The change to cygwin/socket.h concerns me, that is a public header, and
>>> you can't assume they are including MinGW headers, and if they are how
>>> they are configuring them (ie, _WIN32_WINNT define) or which ones they
>>> are including.  It looks like the mingw-w64 header #defines cmsghdr, maybe
>>> an #ifndef cmsghdr with a comment about this situation?  Or how do other
>>> Cygwin headers handle potential conflicts with Windows headers?
>> I appear to be missing where Mingw headers other than ntstatus.h are included
>> in these Cygwin headers so how would Mingw version be defined here?
> 
> Inside Cygwin, additional Windows headers are included, including winsock
> headers to implement sockets within Cygwin.

I understand that happens during the DLL build, but I am still not seeing where 
any of those nested header includes, whether __INSIDE_CYGWIN__ or not, includes 
any Mingw headers to define that version.
So I do not believe any such fix should be applied here.

>> It looks like the changes need to be made elsewhere across the code hierarchy.
>>
>> What are the actual Mingw header definition changes causing conflicts, and do
>> any Cygwin headers, setup or other network apps code need to be adjusted to
>> take the Mingw header changes into account?
> 
> https://github.com/mingw-w64/mingw-w64/commit/c3b5e71d54aa596bba9fb8ec7c1f9f712e7c616a
> 
>> Such details would be required to explain why the patch would be needed and
>> how it fixes the issue while taking compatibility with and any impacts on
>> Cygwin network apps into account.
> 
>> This should perhaps be referred back to the w32api-headers maintainer to see
>> if he did any testing before deployment?

The conflict seems to be between the Mingw SIZE_T & INT definitions and the 
Cygwin size_t & int definitions used in the respective struct cmsghdr definitions.

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
