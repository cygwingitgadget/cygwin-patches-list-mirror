Return-Path: <towo@towo.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id 1767E3858005
 for <cygwin-patches@cygwin.com>; Wed,  8 Dec 2021 18:46:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 1767E3858005
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=towo.net
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=towo.net
Received: from [192.168.178.72] ([91.65.221.56]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M1qfu-1mxDoF0ufw-002IMY for <cygwin-patches@cygwin.com>; Wed, 08 Dec 2021
 19:46:07 +0100
Message-ID: <76e4a449-9c49-8a23-92bb-c194cacd6fa1@towo.net>
Date: Wed, 8 Dec 2021 19:46:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] Cygwin: clipboard: Fix a bug in read().
To: cygwin-patches@cygwin.com
References: <20211207140006.912-1-takashi.yano@nifty.ne.jp>
 <Ya9uU1JP8stQOB/l@calimero.vinschen.de>
 <c69ec6dd-fbbb-829c-9856-7f34cf0a792e@towo.net>
 <bc0170d9-1fcc-1659-beab-d11b01c37e5f@SystematicSw.ab.ca>
 <549e1dea-5545-50c5-fc1f-79c2c4982e8c@maxrnd.com>
 <20211208171929.68490866d4a07aac4b1ca0d7@nifty.ne.jp>
 <3e5ea337-8748-7c1c-813d-29196b6ef68a@maxrnd.com>
 <YbCGmbAsZ4pJuttS@calimero.vinschen.de>
From: Thomas Wolff <towo@towo.net>
In-Reply-To: <YbCGmbAsZ4pJuttS@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:VNgybirh9JneC8X47tXZVrs1ABp0Sf+4lgDsyQ6Yv27lJcXFWZL
 HUQ2AFVPbYnSh+T+/Cm9vax7gYSYkBfus66SFwNu8Ley0zCEGLcHjfNA6JZjcYswAPIfZbX
 qL3hokHC7FTF3/nyFgo5dhrN79c0fYiYXEQYOaKtAc3t06B5LpYh3Xsn1hz4RwsLurOWHmB
 nwBX6JmJgJdcLwLgHYXTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:75o4USDc5cc=:3OWBCd0CD1SQIVaJtNGTsm
 QLGu9ioCzd1B/e6o1oei06AC7lCdqORcgc9e2hRgbSogGWXULWPFjD4wSJRSV/T2vfzc0oGrr
 dgPXcSyAX3e4EAYmkMwkujxloXdSM+sIkvPn4x4zekn9HkJ1BJObZn0YuMkDDnEm+gch75QzF
 KWLXOWKV3E6e+E561OjawqyKhalfsWvkL4WlFlmCogOhrrO5vn6fkhXLptU4vCo3jvTOWgYcA
 h9ESPj+23+226SoZU3fPLD456tgpiCdR6vu81pFpqEyejmtHcsV6ncc8T4g0356Jw2xgMNkEe
 s3ogehBzRkhXapGKqJNHmYTOIL9VUPKPz95aeKhnqJBJnF7MMdmvPoEPmjIZfB552SD4VIjfy
 kK7EJqOtWWR03EnSzpCRzL5EPeOOJizSWeZSCssgIDWa0aAarLYmTS+mYiMrBelX1q7MqKDwX
 fBoAG0I73FcIuqZdiwMKLI18ZoLhxmLN2xIk7QR8WjicP0IfNnZwBiRD4LilGekYihqlH9TZ0
 OHAJMUdxywOXl2CigNjShs8mq8qQpkUqfCnxV4u/qAS39Yehgatk4Pg1Rrr+F6EY+B6+uPLNK
 xYPRU802ElYIpfl+hBs+ZEvtxTkAbzF4j4OnuwRxraZJD8yTvEhbYBk91NcCTNqlApmpn5qMr
 tRGwTxzs/l6Y8JXvjCQxXxU4Zz8LzUd3qtkH8EiJt7esBrlLSQP275ezxro/X4wsxfeE=
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NONE,
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
X-List-Received-Date: Wed, 08 Dec 2021 18:46:10 -0000



Am 08.12.2021 um 11:19 schrieb Corinna Vinschen:
> On Dec  8 01:43, Mark Geisert wrote:
>> Takashi Yano wrote:
>> [...]
>>> I think the following patch makes the intent clearer.
>>> What do you think?
>>>
>>>
>>>   From d0aee9af225384a24ac6301f987ce2e94f262500 Mon Sep 17 00:00:00 2001
>>> From: Takashi Yano <takashi.yano@nifty.ne.jp>
>>> Date: Wed, 8 Dec 2021 17:06:03 +0900
>>> Subject: [PATCH] Cygwin: clipboard: Make intent of the code clearer.
>>>
>>> ---
>>>    winsup/cygwin/fhandler_clipboard.cc   | 4 ++--
>>>    winsup/cygwin/include/sys/clipboard.h | 1 +
>>>    2 files changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/winsup/cygwin/fhandler_clipboard.cc b/winsup/cygwin/fhandler_clipboard.cc
>>> index 05f54ffb3..65a3cad97 100644
>>> --- a/winsup/cygwin/fhandler_clipboard.cc
>>> +++ b/winsup/cygwin/fhandler_clipboard.cc
>>> @@ -76,7 +76,7 @@ fhandler_dev_clipboard::set_clipboard (const void *buf, size_t len)
>>>          clipbuf->cb_sec  = clipbuf->ts.tv_sec;
>>>    #endif
>>>          clipbuf->cb_size = len;
>>> -      memcpy (&clipbuf[1], buf, len); // append user-supplied data
>>> +      memcpy (clipbuf->data, buf, len); // append user-supplied data
>>>          GlobalUnlock (hmem);
>>>          EmptyClipboard ();
>>> @@ -229,7 +229,7 @@ fhandler_dev_clipboard::read (void *ptr, size_t& len)
>>>          if (pos < (off_t) clipbuf->cb_size)
>>>    	{
>>>    	  ret = (len > (clipbuf->cb_size - pos)) ? clipbuf->cb_size - pos : len;
>>> -	  memcpy (ptr, (char *) (clipbuf + 1) + pos, ret);
>>> +	  memcpy (ptr, clipbuf->data + pos, ret);
>>>    	  pos += ret;
>>>    	}
>>>        }
>>> diff --git a/winsup/cygwin/include/sys/clipboard.h b/winsup/cygwin/include/sys/clipboard.h
>>> index 4c00c8ea1..b2544be85 100644
>>> --- a/winsup/cygwin/include/sys/clipboard.h
>>> +++ b/winsup/cygwin/include/sys/clipboard.h
>>> @@ -44,6 +44,7 @@ typedef struct
>>>        };
>>>      };
>>>      uint64_t      cb_size; // 8 bytes everywhere
>>> +  char          data[];
>>>    } cygcb_t;
>>>    #endif
>> Sigh.  I guess it's not possible to keep rid of a data item like I'd hoped.
>> At least "data[]" is cleaner than the historical "data[1]" here.  If you
>> call the item cb_data I can live with it.
>> Thanks all for the discussion.
>    sometype *ptr;
>
>    ptr = (sometype *) somebuffer;
>    do_something (ptr + 1);
>
> is a perfectly valid and perfectly readable thing, and used a lot if
> "sometype" is either a header in a buffer followed by arbitrary data, or
> if the buffer consists of multiple packed blocks of type "sometype".
>
> Takashi's suggestion adds the information that "sometype" is a header
> followed by arbitrary data, so that's a good thing..
Yes, thanks for this variant.
Thomas
