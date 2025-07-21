Return-Path: <SRS0=2rSg=2C=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	by sourceware.org (Postfix) with ESMTPS id 4E1573858D32
	for <cygwin-patches@cygwin.com>; Mon, 21 Jul 2025 15:41:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4E1573858D32
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4E1573858D32
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753112465; cv=none;
	b=BnqW5Ig4bMynDlnYrHjrcE1PYCymcB6PX+ZIXxatzu6GL0AKghh36eeIwqJcTKlTwUdoGfVBT0K090cpSka4+pJzqpR3fz2DFjSWLniPrL8+HHrnTurzsCV6XoxiTifuTHBCecC6RYEyahrJL8CFtcgd+C5iLH6h3H9bI7u0DSQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753112465; c=relaxed/simple;
	bh=3F+tGS7n6sAwIwj7URB1delJf5dCHkUQfokLfEHYMno=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=Pj0j1wdtanSmIip1ZgbodpvVkfCENuboZi70obHnOBNkEgv6QufzqVegtDWpUQqOjMo+yoNVKCZaK8Na2sHslWOcp0uMsUiHPO2peXsmwpCEcN4/oHKmwfES7k9zGepHKvkW/O2ce9CuT6q+t82d4DUuRzwOh41uw39EGydxP8g=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4E1573858D32
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=aOYU6jmj
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id DA4CE1DB20D
	for <cygwin-patches@cygwin.com>; Mon, 21 Jul 2025 15:41:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf20.hostedemail.com (Postfix) with ESMTPA id 69B6320027
	for <cygwin-patches@cygwin.com>; Mon, 21 Jul 2025 15:41:03 +0000 (UTC)
Message-ID: <b434de5f-9984-4113-bd0c-cb71b43e816a@SystematicSW.ab.ca>
Date: Mon, 21 Jul 2025 09:41:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: malloc_wrapper: port to AArch64
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <DB9PR83MB092300A5FEDFB941EEB3F5969248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aHUEhDwuvRmJVZ1X@calimero.vinschen.de>
 <aHUFzEEGq448gvZ0@calimero.vinschen.de>
 <bd64e817-ffa8-4299-a3bc-6d1ff691ca9b@dronecode.org.uk>
 <aH5CvWENvjsmKbjJ@calimero.vinschen.de>
 <aH5EsVT1Hhe_7yHV@calimero.vinschen.de>
Organization: Systematic Software
In-Reply-To: <aH5EsVT1Hhe_7yHV@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Stat-Signature: tb5qrr39izz5nwmznin8owdyemhir7kb
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 69B6320027
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX18DVtHSdir9gDH/kgObDbIi0W7zLeOx7vE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=3ug9AtOuOHK71vh103Qj+NWI/f/sl6X78oi03h0gPBA=; b=aOYU6jmjtDGBZ7wKECYGBNvZET6Qu5q/967teP2WfKR9U8mNpCCKUBAwhSL0ap8bhc4n4vF6Ffppr6cwwMLV7z7uwfBEjxaMDy5I0bWErcFQhu8j+JNbH3BMJMxg0mdL2dWrwNJ7ZNUUnUJnJjHDhvepsNRraD2Zr5fw4swde7L+3shKQuxlM0wbDXltjrFezMuBmq7t1d6GdD5mUh9gkZgP8WPnrHNxsH6uvfcM6vRJp/xEmdlpmIk2MfOrDlP/b6ssf3JEb0Ew5eupUtRW223tOwa9UfkKuRyjIbCoboSCXQxLxa9MloFb0Kqe8PprzwR29Ss9YkLHwsbKPH+16A==
X-HE-Tag: 1753112463-19017
X-HE-Meta: U2FsdGVkX19KZmmexZtivKavQAwkOo/qQxLrsBtncCmm0ZlNgkxMcQgMVCXgvCZCxFE12aNgmIg2MBVTDrD3AbizE4xQPnzoB/BUVd9zywesQfK4bY2qEt7IMkc6F4azLhfmz10aXlLSCBlrzBgNmxnLMWacA7WTmuMk1/dkQTJRR4Z2Kez21E9znx+3Ax1LQTlqYkZSCrzgPH4FfgYk4Tc75U+5FPwhA4FR9p1sbgiTD5X+Nudvt2/hmnnagV1AisdSsvrvgy48JEjiawsOHhyIEZxZv4V7S/rX0LZbCBNp+/xE+LSx5wSAhzJmgmk64cuHH0V9JfcLSrVa0MzCgr5EhBrh1GW4vNvuNE7o9Cvtyw2wc5VzS45Y4HSuleFAz4Lo3EOXm5Xq+fyMmcGChf9Dw722XbiNhdKQ4YdSMj8kDCDpvF5Liv1efbYTTGMOb2XicSe5Di7Z7Aep6WvK6jWu14iFb5khZCQsYm01itQ=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-07-21 07:46, Corinna Vinschen wrote:
> On Jul 21 15:38, Corinna Vinschen wrote:
>> On Jul 21 14:15, Jon Turney wrote:
>>> If Radek is going to be adding Signed-off: lines of behalf of his
>>> colleagues, maybe this is an appropriate place to ask what he thinks he's
>>> attesting to with it?
>>>
>>>
>>> Corinna,
>>>
>>> Maybe the "Before you get started" section in [1] should mention Signed-off:
>>> and what we think it means?
>>
>> That's a good point.
>>
>> dll.html is outdated.  We don't use the CONTRIBUTORS file anymore.  It
>> was a remnant of the past, when we switched our license and we still
>> needed to keep track of the developers and the 2-clause BSD rule while
>> long-living contracts with the old buyout license were still active.
> 
> On second thought, I think we should rename the file to
> PAST_CONTRIBUTORS and prepend some lines that we switched to the
> Developer Certificate of Origin, pointing to dll.html...
> 
>> These days, I would like to enforce the Signed-off-by: line and it
>> should have the same place and same significance as in the Linux kernel,
>> that is...
>>
>>    https://developercertificate.org/
>>
>> Briefly, the sign-off means, that the contributor has, both, the right
>> and the willingness, to contribute code to this project under the
>> project's open source license, i.e., GPL v3+ in case of Cygwin.

Add that to CONTRIBUTORS.

>>> If we really want it to be mandatory, I guess I could explore the
>>> possibility of a push hook to enforce that?
>>>
>>> [1] https://cygwin.com/contrib/dll.html
> 
> ...and dll.html should be written anew from the pararaph starting
> with "If your change is going to be a significant one"... by just
> stating that we expect a Developer Certificate of Origin per
> https://developercertificate.org/, i.e., a "Signed-off-by:" line
> per patch.

That site is about Linux Foundation contributors, so I think we may credit it, 
but add the relevant or modified paragraphs (especially licensing) to our 
CONTRIBUTORS and/or dll.html, with any conditions and limitations for newlib 
contributions and tree, and cygwin-patches contributions and winsup tree.
> Does that sound about right?
>> Yeah, but there's one twist: We don't and can't enforce Signed-off-by:
>> lines in case of contributions to newlib.  Newlib is not under GPL.
>> Rather it's a collection of multiple open source licenses.  So in case
>> of newlib the meaning of a signed-off is rather fuzzy.
>>
>> Therefore we only can enforce contributions to Cygwin code and docs.
Document what licence statements (or give source prefix example files) need to 
be at the top of new files added under each tree?

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
