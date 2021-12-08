Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from omta002.cacentral1.a.cloudfilter.net
 (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
 by sourceware.org (Postfix) with ESMTPS id F18F73858D28
 for <cygwin-patches@cygwin.com>; Wed,  8 Dec 2021 05:53:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org F18F73858D28
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=systematicsw.ab.ca
Received: from shw-obgw-4001a.ext.cloudfilter.net ([10.228.9.142])
 by cmsmtp with ESMTP
 id ubS0matOZztEjuptvmoW6v; Wed, 08 Dec 2021 05:53:59 +0000
Received: from [192.168.1.105] ([68.147.0.90]) by cmsmtp with ESMTP
 id uptumxpETlt4QuptvmHZGb; Wed, 08 Dec 2021 05:53:59 +0000
X-Authority-Analysis: v=2.4 cv=F+dEy4tN c=1 sm=1 tr=0 ts=61b04877
 a=T+ovY1NZ+FAi/xYICV7Bgg==:117 a=T+ovY1NZ+FAi/xYICV7Bgg==:17
 a=IkcTkHD0fZMA:10 a=w_pzkKWiAAAA:8 a=uYT-Tk0qkVT609LjNaIA:9
 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=QEXdDO2ut3YA:10 a=z29UFhK2IzQA:10
 a=sRI3_1zDfAgwuvI8zelB:22
Message-ID: <bc0170d9-1fcc-1659-beab-d11b01c37e5f@SystematicSw.ab.ca>
Date: Tue, 7 Dec 2021 22:53:58 -0700
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
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Organization: Systematic Software
In-Reply-To: <c69ec6dd-fbbb-829c-9856-7f34cf0a792e@towo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfGsdaHbwZ7AXdCXsI0smO5qp/rvsPuxvcLpN/CGeWcV1iUfKVM9yvt1AuD+Vguw36vdXHpwerfemKSjA8tIYtkpiFnSioostSRyH49Y37lmwAPj+sS01
 SOICVZedphn+gNNHFSvs1tpnscHZdFTUsupGxZsBkDh3UbWycXBDudngL3NQ/xXXS+6D7ZJO3S0KrXPYmNE9Eft+OmiWp9NASek=
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
X-List-Received-Date: Wed, 08 Dec 2021 05:54:01 -0000

On 2021-12-07 13:18, Thomas Wolff wrote:
> 
> Am 07.12.2021 um 15:23 schrieb Corinna Vinschen:
>> On Dec  7 23:00, Takashi Yano wrote:
>>> - Fix a bug in fhandler_dev_clipboard::read() that the second read
>>>    fails with 'Bad address'.
>>>
>>> Addresses:
>>>    https://cygwin.com/pipermail/cygwin/2021-December/250141.html
>>> ---
>>>   winsup/cygwin/fhandler_clipboard.cc | 2 +-
>>>   winsup/cygwin/release/3.3.4         | 6 ++++++
>>>   2 files changed, 7 insertions(+), 1 deletion(-)
>>>   create mode 100644 winsup/cygwin/release/3.3.4
>>>
>>> diff --git a/winsup/cygwin/fhandler_clipboard.cc 
>>> b/winsup/cygwin/fhandler_clipboard.cc
>>> index 0b87dd352..ae10228a7 100644
>>> --- a/winsup/cygwin/fhandler_clipboard.cc
>>> +++ b/winsup/cygwin/fhandler_clipboard.cc
>>> @@ -229,7 +229,7 @@ fhandler_dev_clipboard::read (void *ptr, size_t& 
>>> len)
>>>         if (pos < (off_t) clipbuf->cb_size)
>>>       {
>>>         ret = (len > (clipbuf->cb_size - pos)) ? clipbuf->cb_size - 
>>> pos : len;
>>> -      memcpy (ptr, &clipbuf[1] + pos , ret);
>>> +      memcpy (ptr, (char *) &clipbuf[1] + pos, ret);

>> I'm always cringing a bit when I see this kind of expression. Personally
>> I think (ptr + offset) is easier to read than &ptr[offset], but of course
>> that's just me.  If you agree, would it be ok to change the above to
>>
>>    (char *) (clipbuf + 1)
>>
>> while you're at it?  If you like the ampersand expression more, it's ok,
>> too, of course.  Please push.

> In this specific case I think it's actually more confusing because of 
> the type mangling that's intended in the clipbuf.
> At quick glance, it looks a bit as if the following were meant:
> 
>    (char *) clipbuf + 1
> 
> I'd even make it clearer like
> 
> +      memcpy (ptr, ((char *) &clipbuf[1]) + pos, ret);
> or even
> +      memcpy (ptr, ((char *) (&clipbuf[1])) + pos, ret);

If the intent is to address:

	clipbuf + pos + 1

use either that or:

	&clipbuf[pos + 1]

to avoid obscuring the intent,
and add comments to make it clearer!

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]
