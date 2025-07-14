Return-Path: <SRS0=c0Hf=Z3=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	by sourceware.org (Postfix) with ESMTPS id 711353858C42
	for <cygwin-patches@cygwin.com>; Mon, 14 Jul 2025 20:58:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 711353858C42
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 711353858C42
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.14
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752526726; cv=none;
	b=aYAmriVU5w5L1IciKEFJnHASgrYG2NrlaiCmU/makuJ0RzgOL1e+GJIXHXMsREe0l/bYU+ogF4/6NegD0cg4UZ9wubAwqQEu4XUoYwZaPZMVppKggVYS/Jaf4MI25/viW2/coTL1uYhZdSYnvqfkphK2DNNOBl5evh46pcFEgRE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752526726; c=relaxed/simple;
	bh=fwfBBPG0+MmttO3xgfLnvukP4wNawdZeGQSG16Lc2wk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=mKzKCpb67PghJBFXAmD0rbG80FIhRlFvdeTJQXqTOYwXp3r+ekjKjOlmQ5ii1SF3089D6ybHljGFwgl5dPlVqhKv8drzRRaePXDNK0SbZdNdlrA9XYg1wQZ9nbaO9szb8Vn0d9P1vPkpWJAZ1OnI72B/K1pSVdEGRCUZnyOKzwk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 711353858C42
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=fYWehqvu
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 215B3160304
	for <cygwin-patches@cygwin.com>; Mon, 14 Jul 2025 20:58:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf11.hostedemail.com (Postfix) with ESMTPA id A24772002A
	for <cygwin-patches@cygwin.com>; Mon, 14 Jul 2025 20:58:44 +0000 (UTC)
Message-ID: <392fde36-436d-4b6e-9218-48084fec19be@SystematicSW.ab.ca>
Date: Mon, 14 Jul 2025 14:58:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: malloc_wrapper: port to AArch64
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <DB9PR83MB092300A5FEDFB941EEB3F5969248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <52e4e7cf-22d4-f8f7-0c1a-abbd9ca8f2a8@jdrake.com>
 <3df9677e-9113-e7f0-3550-ac9f866d406d@jdrake.com>
Organization: Systematic Software
In-Reply-To: <3df9677e-9113-e7f0-3550-ac9f866d406d@jdrake.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Stat-Signature: kaywoymg7wc48o419juriigeis11azj9
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: A24772002A
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1+GEqkwdKBHDWjFIJ8+x2DNRsIb2eLOSzw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=lqjLb+qQhjBmV/PdidJUfhoISwPvPVBh6MUOnZIcYVM=; b=fYWehqvuXrnAVelpR/z63of5qJhtBYnsIwEPhtBg2LTguVzeVhH8Hq0nrb8NJQ0MgkASqijJUxCdZZYiotIR08EHyHpN058fy9eGSe8gFYlDl6QuE+kLB2fKrZljY8ZoAcpfIUr02vXDlZjo7p890PiUExxXZqVTSwqBE8lRtVZh4ITT0GnMfQdO3t7AhAvT/9ODEqEc29XJ9O8t2iEIjQUN0mtCR7QDFwxpbelVTVqMPJ8x78TL02asaI95dXFdmxfgynUGg8ZuVvUe8PEOPOBBX8ybvk/Y4cAGpQURqjzWtv6+NDQgOBbG3JoPBzohaP2tSQfvi3Dy0iKNQ2etbA==
X-HE-Tag: 1752526724-967384
X-HE-Meta: U2FsdGVkX1855vc41fA0AJ+2aQ4OXyOD5Fqol6y6HeNO29DQgHhuo6uGYJsmAx8fMgs8bMOYt+/7opazYV4ly6h3Ji19Ky1skO9g13BzeexzknsyYAnO9xNoKoKksFpUVMDonZTPdElNAoVjsAXheRxkS9uBdZo98uNZZRBOCOOoDJRKdylH41jqvFKzEhv8cYDdkDPOrqhtujNmKNER5tu9ggCNk1ivLdVOKTIpnBi6Z3tGWH8UYj8GasUEw47HPYjhM4FnrNd+FZF6OZkm1YNjAGKLMdnyqsDwDEAsE6j4+3Hfa+bSDjHJsuOZfPRoeV0jWj2ubKRLooOsrkLrfEyvqoXYqyY0wF6kimZq7U1QHAC0me6hnA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-07-14 12:10, Jeremy Drake via Cygwin-patches wrote:
> On Mon, 14 Jul 2025, Jeremy Drake wrote:
>> On Thu, 10 Jul 2025, Radek Barton via Cygwin-patches wrote:
>>> This patch implements `import_address` function by decoding `adr` AArch64 instructions to get
>>> target address.
>>
>> Out of curiosity, can you elaborate on when `adr` is used rather than
>> `adrp`/`add` pair?  I know adr has much less range, but it seems like the
>> compiler can't know how far away many symbols will be (perhaps it can for
>> things like local labels).  When I was looking at ntdll in the fastcwd
>> stuff (and ucrt in ruby) adrp/add (or adrp/ldr) were used, never saw adr.
> 
> adr has a +/- 1MB range from PC, while adrp/add has a +/- 4GB range.

Details:

https://devblogs.microsoft.com/oldnewthing/20220809-00/?p=106955

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
