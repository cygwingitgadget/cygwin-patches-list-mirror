Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from omta002.cacentral1.a.cloudfilter.net
 (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
 by sourceware.org (Postfix) with ESMTPS id 766313858D33
 for <cygwin-patches@cygwin.com>; Thu, 28 Jul 2022 18:55:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 766313858D33
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=systematicsw.ab.ca
Received: from shw-obgw-4001a.ext.cloudfilter.net ([10.228.9.142])
 by cmsmtp with ESMTP
 id H2I1oQp33Sp39H8fSoxBZN; Thu, 28 Jul 2022 18:55:30 +0000
Received: from [10.0.0.5] ([184.64.124.72]) by cmsmtp with ESMTP
 id H8fSo6Lm0uJwwH8fSoRmXb; Thu, 28 Jul 2022 18:55:30 +0000
X-Authority-Analysis: v=2.4 cv=F+BEy4tN c=1 sm=1 tr=0 ts=62e2dba2
 a=oHm12aVswOWz6TMtn9zYKg==:117 a=oHm12aVswOWz6TMtn9zYKg==:17
 a=JYDileg9wNlxFN0D:21 a=IkcTkHD0fZMA:10 a=w_pzkKWiAAAA:8 a=hGzw-44bAAAA:8
 a=mDV3o1hIAAAA:8 a=CCpqsmhAAAAA:8 a=uYT-Tk0qkVT609LjNaIA:9 a=QEXdDO2ut3YA:10
 a=NEMXJcwN1a4A:10 a=hf7a2FvunDcA:10 a=OWQaqklJ0g0A:10
 a=wMWlw4UXOv7VJ8S2T32r:22 a=sRI3_1zDfAgwuvI8zelB:22 a=HvKuF1_PTVFglORKqfwH:22
 a=_FVE-zBwftR9WsbkzFJk:22 a=ul9cdbp4aOFLsgKbc677:22
Message-ID: <6cd85e22-8623-78bc-cbbf-4c768f441423@SystematicSw.ab.ca>
Date: Thu, 28 Jul 2022 12:55:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Update FAQs which are out of date on the details of setup
 UI
Content-Language: en-CA
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20220707114428.65374-1-jon.turney@dronecode.org.uk>
 <YsvVC4qwC9Lao/Ho@calimero.vinschen.de>
 <91d1d17c-27d2-a271-a9b6-bcd3811084ca@SystematicSw.ab.ca>
 <a6958727-80ee-d8a3-3925-470c7f839a59@dronecode.org.uk>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Organization: Systematic Software
In-Reply-To: <a6958727-80ee-d8a3-3925-470c7f839a59@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfD/B8bIpDx3RZt4nFN7hXcbMpSexdjkk0G52UcZhBMmL4J3oW8Xuq/QaXgc/WTzZeNLpRKtlHpmxbP8mzwScmjI0AOeRoQlRXQDpAT+glTdOZTNXcGGt
 qGXPSeifarHBhBCny+IoSKLDTsv67XyR+AgrmQ4e/wXB6gZfmQyqCdui0y5uEgp/DY8TUu88IuF6kGHvk0rexYJrm/g26vfXegE=
X-Spam-Status: No, score=-1168.3 required=5.0 tests=BAYES_00, BODY_8BITS,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, KAM_SHORT,
 NICE_REPLY_A, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 28 Jul 2022 18:55:33 -0000

On 2022-07-28 10:42, Jon Turney wrote:
> On 23/07/2022 21:46, Brian Inglis wrote:
>> On 2022-07-11 01:45, Corinna Vinschen wrote:
>>> On Jul  7 12:44, Jon Turney wrote:
>>>> ---
>>>>   winsup/doc/faq-setup.xml | 11 ++++++-----
>>>>   winsup/doc/faq-using.xml | 14 +++++++-------
>>>>   2 files changed, 13 insertions(+), 12 deletions(-)
>>> LGTM
>>
>> [original did not make it to me; caught up on archive and noticed]
>>
>> URL duplicates .html:
>>
>>      <ulink url="https://cygwin.com/package-server.html.html">
>>
>> should perhaps also have the self-closing tag delimiter "/>":
>>
>>      <ulink url="https://cygwin.com/package-server.html" />
>>
>> where the extra space ensures it is also valid XHTML/XML so it can be 
>> checked or processed with better tools that can catch issues ;^>
>>
>> [attachment extract]
>>
>> diff --git a/winsup/doc/faq-setup.xml b/winsup/doc/faq-setup.xml
>> index ce1069616..da9fce534 100644
>> --- a/winsup/doc/faq-setup.xml
>> +++ b/winsup/doc/faq-setup.xml
>> ...
>> @@ -688,7 +689,7 @@ files, reinstall the "<literal>cygwin</literal>" 
>> package using the Cygwin Setup
>>   this purpose.  See <ulink url="http://rsync.samba.org/"/>,
>>   <ulink url="http://www.gnu.org/software/wget/"/> for utilities that 
>> can do this for you.
>>   For more information on setting up a custom Cygwin package server, see
>> -the <ulink url="https://sourceware.org/cygwin-apps/setup.html">Cygwin 
>> Setup program page</ulink>.
>> +the <ulink url="https://cygwin.com/package-server.html.html">Cygwin 
>> Package Server page</ulink>.
> 
> I am confused.
> 
> The <ulink> tag is closed by the </ulink> tag later on the same line, 
> after enclosing the link text 'Cygwin Package Server page'

Sorry I missed those end tags because of the wrap.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]
