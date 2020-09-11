Return-Path: <towo@towo.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id 9BB9F3857026
 for <cygwin-patches@cygwin.com>; Fri, 11 Sep 2020 15:10:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9BB9F3857026
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=towo.net
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=towo@towo.net
Received: from [192.168.178.45] ([95.90.245.244]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MOzfO-1jtiYb0nVM-00PJZs for <cygwin-patches@cygwin.com>; Fri, 11 Sep 2020
 17:10:13 +0200
Subject: Re: [PATCH] Cygwin: pty: Add workaround for ISO-2022 and ISCII in
 convert_mb_str().
To: cygwin-patches@cygwin.com
References: <20200911105401.153-1-takashi.yano@nifty.ne.jp>
 <20200911120840.GH4127@calimero.vinschen.de>
 <20200911213515.98a88ca7f186ede9bf8fc106@nifty.ne.jp>
 <20200911140601.GK4127@calimero.vinschen.de>
From: Thomas Wolff <towo@towo.net>
X-Tagtoolbar-Keys: D20200911171013415
Message-ID: <bfc29d4a-f65d-435b-ca6b-52472a9d5a02@towo.net>
Date: Fri, 11 Sep 2020 17:10:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200911140601.GK4127@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ku+6/k6wNNO54vdWH19gHKuIjMGdhj/2k+hX4eVYfoDe7hbNIcB
 zFbmJCP5D7LkI1wJxmklK//MA9erHK2dgZjPHjdvXeEIz0ll13hB+Sx4+8LH6rOp7HhcL8u
 xAJlwfm49zHbAFD2Ib5NZg1d0X9ucTF5vZYehC8suwjcWWJO5sGoNQdZSqRac/xrbH6ux1k
 EcvZZk1I44htRS2MN1gOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WGguFvFbJJg=:2GJb+9vx/i02+2wjuoXb8V
 JHWRVTtCO8nfpi0UlOerJJEkERZcaIMF1TWyOjhSt8OwrxjkidgKptPRruNzvCL4VDHWl3xpI
 NCMj/D4qdadaLdSJY4limM9cvedDbUqTTDClj2r9dMJfboeZa/UXsJtOFeylMct0SlaUBNyAo
 0a4tDpev85uZl3T/6WnF8Tmy5bZ88i8gB42l74dIsgEwmWyfveI5Yy0ZPCR4bMgjLUshz1hWE
 YDuhI7j3YfQ338KDBacLqYNMh32P1M2b93Ho4s0bx2Xnu9pEOol2U2Qzc6EV1wWnTC5PmVRLQ
 76g4PDjpzTm9u4BF9JxOI1x1UQsyXOPJpBbApNVHW+EL9qkkFUUGAOYAe7Id70PQujyVwJGYZ
 yvLJ98EE4tUKev7kOL6TnmXT/l07ZgRZHhZ6UHMfpU33Mfv0lHml5+OWfKG4RiKW2urE1VE1I
 3YUc8waelgBBMifvCaqXAFtSTKfwRUPDZoo5YD3v9mjAjrz6/gevrM5E3a8txIHC+TrBJWIpI
 ep4dlcQUSppjrppfMmGDQavFCZmMAQ5hD7DE19BBD7G+J8fJDx/ronaWMNFsnZFlTSgo4Bva2
 YUQjcZa9qejMgcp0AM5Y/WmjHQPzKlHMpd/gJ6H77gQHH3SpGvl8WLT1VcG1HuH/QUxXtPoEh
 dDbwXoE3zJLAVw/umSO+KIh56dtYDTpXY8r4iIeeBM7t5g7xoi/RT+r1sL04wOAqsTNpK5aPu
 VX/wa8xXmbeJ2wB+8i7BXQppZhYdf53OurIYVe2atVTVU7yU4H4S4q1TUYBLn6IsmDRJllPHX
 6yyLUb0XoNbJizx6ZQ/LBfJMlcNYYtykBTCblGcryVkCJ7UsIrSUONoq/8wXdHb/D+APatd
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_ABUSEAT,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Fri, 11 Sep 2020 15:10:16 -0000

Am 11.09.2020 um 16:06 schrieb Corinna Vinschen:
> On Sep 11 21:35, Takashi Yano via Cygwin-patches wrote:
>> Hi Corinna,
>>
>> On Fri, 11 Sep 2020 14:08:40 +0200
>> Corinna Vinschen wrote:
>>> On Sep 11 19:54, Takashi Yano via Cygwin-patches wrote:
>>>> - In convert_mb_str(), exclude ISO-2022 and ISCII from the processing
>>>>    for the case that the multibyte char is splitted in the middle.
>>>>    The reason is as follows.
>>>>    * ISO-2022 is too complicated to handle correctly.
>>>>    * Not sure what to do with ISCII.
>>>> ---
>>>>   winsup/cygwin/fhandler_tty.cc | 9 +++++++--
>>>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
>>>> index 37d033bbe..ee5c6a90a 100644
>>>> --- a/winsup/cygwin/fhandler_tty.cc
>>>> +++ b/winsup/cygwin/fhandler_tty.cc
>>>> @@ -117,6 +117,9 @@ CreateProcessW_Hooked
>>>>     return CreateProcessW_Orig (n, c, pa, ta, inh, f, e, d, si, pi);
>>>>   }
>>>>   
>>>> +#define IS_ISO_2022(x) ( (x) >= 50220 && (x) <= 50229 )
>>>> +#define IS_ISCII(x) ( (x) >= 57002 && (x) <= 57011 )
>>>> +
>>>>   static void
>>>>   convert_mb_str (UINT cp_to, char *ptr_to, size_t *len_to,
>>>>   		UINT cp_from, const char *ptr_from, size_t len_from,
>>>> @@ -126,8 +129,10 @@ convert_mb_str (UINT cp_to, char *ptr_to, size_t *len_to,
>>>>     tmp_pathbuf tp;
>>>>     wchar_t *wbuf = tp.w_get ();
>>>>     int wlen = 0;
>>>> -  if (cp_from == CP_UTF7)
>>>> -    /* MB_ERR_INVALID_CHARS does not work properly for UTF-7.
>>>> +  if (cp_from == CP_UTF7 || IS_ISO_2022 (cp_from) || IS_ISCII (cp_from))
>>>> +    /* - MB_ERR_INVALID_CHARS does not work properly for UTF-7.
>>>> +       - ISO-2022 is too complicated to handle correctly.
>>>> +       - FIXME: Not sure what to do for ISCII.
>>>>          Therefore, just convert string without checking */
>>>>       wlen = MultiByteToWideChar (cp_from, 0, ptr_from, len_from,
>>>>   				wbuf, NT_MAX_PATH);
>>>> -- 
>>>> 2.28.0
>>> I'd prefer to not handle them at all.  We just don't support these
>>> charsets, same as JIS, EBCDIC, you name it, which are not ASCII
>>> compatible.  Let's please just drop any handling for these weird
>>> or outdated codepages.
>> What do you mean by "just drop any handling"?
>>
>> Do you mean remove following if block?
>>>> +  if (cp_from == CP_UTF7 || IS_ISO_2022 (cp_from) || IS_ISCII (cp_from))
>>>> +    /* - MB_ERR_INVALID_CHARS does not work properly for UTF-7.
>>>> +       - ISO-2022 is too complicated to handle correctly.
>>>> +       - FIXME: Not sure what to do for ISCII.
>>>>          Therefore, just convert string without checking */
>>>>       wlen = MultiByteToWideChar (cp_from, 0, ptr_from, len_from,
>>>>   				wbuf, NT_MAX_PATH);
>> In this case, the conversion for ISO-2022, ISCII and UTF-7 will
>> not be done correctly.
>>
>> Or skip charset conversion if the codepage is EBCDIC, ISO-2022
>> or ISCII? What should we do for UTF-7?
> Nothing, just like for any other of these weird charsets.  Cygwin never
> supported any charset which wasn't at least ASCII compatible in the
> 0 <= x <= 127 range.
Actually, in Shift-JIS (CP932, supported via locale ja_JP.sjis), 0x5C is 
¥ :/
>    Just ignore them and the possibility that a
> user chooses them for fun.
>
>> What should happen if user or apps chage codepage to one of them?
> Garbage output, I guess.  We shouldn't really care.
>
>
> Corinna

