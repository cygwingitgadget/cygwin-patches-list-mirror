Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from omta002.cacentral1.a.cloudfilter.net
 (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
 by sourceware.org (Postfix) with ESMTPS id E1DC53858D28
 for <cygwin-patches@cygwin.com>; Wed,  8 Dec 2021 07:24:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org E1DC53858D28
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=systematicsw.ab.ca
Received: from shw-obgw-4004a.ext.cloudfilter.net ([10.228.9.227])
 by cmsmtp with ESMTP
 id uhxhmbN3IztEjurJHmoc8u; Wed, 08 Dec 2021 07:24:15 +0000
Received: from [192.168.1.105] ([68.147.0.90]) by cmsmtp with ESMTP
 id urJHmmSqrd5UnurJHm7lbw; Wed, 08 Dec 2021 07:24:15 +0000
X-Authority-Analysis: v=2.4 cv=FrgWQknq c=1 sm=1 tr=0 ts=61b05d9f
 a=T+ovY1NZ+FAi/xYICV7Bgg==:117 a=T+ovY1NZ+FAi/xYICV7Bgg==:17
 a=IkcTkHD0fZMA:10 a=w_pzkKWiAAAA:8 a=TImcKGuyeGIbufSLrCcA:9
 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=QEXdDO2ut3YA:10 a=z29UFhK2IzQA:10
 a=sRI3_1zDfAgwuvI8zelB:22
Message-ID: <25fe900a-f2d1-1688-d7af-95af7fc599b2@SystematicSw.ab.ca>
Date: Wed, 8 Dec 2021 00:24:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: clipboard: Fix a bug in read().
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <20211207140006.912-1-takashi.yano@nifty.ne.jp>
 <Ya9uU1JP8stQOB/l@calimero.vinschen.de>
 <c69ec6dd-fbbb-829c-9856-7f34cf0a792e@towo.net>
 <bc0170d9-1fcc-1659-beab-d11b01c37e5f@SystematicSw.ab.ca>
 <549e1dea-5545-50c5-fc1f-79c2c4982e8c@maxrnd.com>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Organization: Systematic Software
In-Reply-To: <549e1dea-5545-50c5-fc1f-79c2c4982e8c@maxrnd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfNKyoX3M1Blfo6HLnpHd1mHTQBtEtDSgKCxohol6g15n6HHnvfOVHImT02OwEJDZMIQOECs8fDQcLQSxqxU+LsdZ0+67VQ+n5qXQ/hkooJ0Cu9K2SmHg
 YP1cF7Ba/mspiyms4nABmW17/F0PT/6WM9QTiuOxaiP4La5OGEypH1rkG55lTxxXVGsxTi1T7gYB0eBpjnQ6i0fALoxE3sbciCQ=
X-Spam-Status: No, score=-1169.7 required=5.0 tests=BAYES_00, BODY_8BITS,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H3,
 RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Wed, 08 Dec 2021 07:24:18 -0000


On 2021-12-07 23:30, Mark Geisert wrote:
> Brian Inglis wrote:
>> On 2021-12-07 13:18, Thomas Wolff wrote:
>>> Am 07.12.2021 um 15:23 schrieb Corinna Vinschen:
>>>> On Dec  7 23:00, Takashi Yano wrote:
>>>>> - Fix a bug in fhandler_dev_clipboard::read() that the second read
>>>>>    fails with 'Bad address'.
>>>>>
>>>>> Addresses:
>>>>>    https://cygwin.com/pipermail/cygwin/2021-December/250141.html
>>>>> ---
>>>>>   winsup/cygwin/fhandler_clipboard.cc | 2 +-
>>>>>   winsup/cygwin/release/3.3.4         | 6 ++++++
>>>>>   2 files changed, 7 insertions(+), 1 deletion(-)
>>>>>   create mode 100644 winsup/cygwin/release/3.3.4
>>>>>
>>>>> diff --git a/winsup/cygwin/fhandler_clipboard.cc 
>>>>> b/winsup/cygwin/fhandler_clipboard.cc
>>>>> index 0b87dd352..ae10228a7 100644
>>>>> --- a/winsup/cygwin/fhandler_clipboard.cc
>>>>> +++ b/winsup/cygwin/fhandler_clipboard.cc
>>>>> @@ -229,7 +229,7 @@ fhandler_dev_clipboard::read (void *ptr, 
>>>>> size_t& len)
>>>>>         if (pos < (off_t) clipbuf->cb_size)
>>>>>       {
>>>>>         ret = (len > (clipbuf->cb_size - pos)) ? clipbuf->cb_size - 
>>>>> pos : len;
>>>>> -      memcpy (ptr, &clipbuf[1] + pos , ret);
>>>>> +      memcpy (ptr, (char *) &clipbuf[1] + pos, ret);

>>>> I'm always cringing a bit when I see this kind of expression. 
>>>> Personally I think (ptr + offset) is easier to read than 
>>>> &ptr[offset], but of course that's just me. If you agree, would
>>>> it be ok to change the above to
>>>>
>>>>    (char *) (clipbuf + 1)
>>>>
>>>> while you're at it?  If you like the ampersand expression more,
>>>> it's ok, too, of course. Please push.

>>> In this specific case I think it's actually more confusing because of 
>>> the type mangling that's intended in the clipbuf.
>>> At quick glance, it looks a bit as if the following were meant:
>>>
>>>    (char *) clipbuf + 1
>>>
>>> I'd even make it clearer like
>>>
>>> +      memcpy (ptr, ((char *) &clipbuf[1]) + pos, ret);
>>> or even
>>> +      memcpy (ptr, ((char *) (&clipbuf[1])) + pos, ret);

>> If the intent is to address:
>>
>>      clipbuf + pos + 1
>>
>> use either that or:
>>
>>      &clipbuf[pos + 1]
>>
>> to avoid obscuring the intent,
>> and add comments to make it clearer!

> Boy am I kicking myself for screwing up the original here and opening 
> this can of worms.  Brian, you'd be correct if clipbuf was (char *) like 
> anything-buf often is.  But here it's a struct defining the initial part 
> of a dynamic char buffer.
> 
> So my original
>      &clipbuf[1]
> to mean "just after the defining struct" was OK.  But the code needed a 
> ptr to some char offset after that and
>      &clipbuf[1] + pos
> was wrong.  Casting the left term to (char *) would fix it.  But I like 
> Corinna's choice of
>      (char *) (clipbuf + 1)
> to be most elegant and clear of all.  Now enclose that in parens and 
> append the char offset so the new expression is
>      ((char *) (clipbuf + 1)) + pos

In this context, (char *)clipbuf + sizeof clipbuf would actually be 
clearer. Or hide the expression in a cb_text(clipbuf[,pos?]) macro.

You could make the format and intent clear and obvious by appending 
cb_text[0|1|...] (some C++ compatible form) into cygcb_t in 
sys/clipboard.h.

> and all should be golden.  I don't think extra commentary is needed
> in code. (I think.)
Where else put commentary?
In this case it should be mandatory, as this is an address hack to 
access the clipboard text, and there were questions about that expression.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]
