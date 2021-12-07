Return-Path: <towo@towo.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id 252953858D28
 for <cygwin-patches@cygwin.com>; Tue,  7 Dec 2021 20:18:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 252953858D28
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=towo.net
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=towo.net
Received: from [192.168.178.72] ([91.65.221.56]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MulZl-1mc3uL3MMl-00rqsS for <cygwin-patches@cygwin.com>; Tue, 07 Dec 2021
 21:18:42 +0100
Message-ID: <c69ec6dd-fbbb-829c-9856-7f34cf0a792e@towo.net>
Date: Tue, 7 Dec 2021 21:18:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] Cygwin: clipboard: Fix a bug in read().
To: cygwin-patches@cygwin.com
References: <20211207140006.912-1-takashi.yano@nifty.ne.jp>
 <Ya9uU1JP8stQOB/l@calimero.vinschen.de>
From: Thomas Wolff <towo@towo.net>
In-Reply-To: <Ya9uU1JP8stQOB/l@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:8kybO1O2a6OA+YPphmflF2m35SjE110KInoSewVX426a96JPSmA
 bOtS6YD9hYKTG8n1ii/dDkYwUbsXszDE2CvWAufPw4OnBcurOToeE5R3nR0X2AKoVwW51AL
 HMEXoCsWDGAv+ShFJR3MsKnxfIU65YNRoBDjJsnFxPmL+SsffDShzvPDGPxIuqhajLP+u/l
 pZILmn9H6mAFLiEzuBItw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uNLWLYP+vDI=:CrFlcbglLv5eFlD7U/FCtX
 TiLcQToDmH/+EQBv6SyMp5yBJtDjxgHYQi19BfqwTnng4dIvvuyh5UCDPcBpNwmnbJFcT+uGg
 gkYf7AFF75lw1KiGRANawt9vpe0wavEB8EqMCs9igt2o29ZXX+2kZRQD0F+gLFFRVjSPJbzXH
 3Uk6FAPlkNC2/55UVO/SJHHfDMm3NwB5nrs9EiV9LDa34SyDY2SNzJsJTzTP/yD4957rmAJHB
 Ddu1tq0E83X2brzhLVxrkMMf+NONMJdvQ53jcp6R7IvBEIiQzCaoqj2mzY3MFxU+xGUPpNPBQ
 zF1PLq4EZWL59jnU9oon9ErFD7RXVcIK0zD0a6XvBYgIp9EDjS38Lf7+Y6f4g2SHRA+6JBDaC
 8omXACPbESLSEGHs6gBu3lyR0nb9+s5R38jfaw+VGPERpuEVo/Muk173eyCqoV2rqO+aMs5j8
 u+jrrtbhNsL9j/SOhXUqZBxO2XEh8RgkBQKJmm3L4s6UKkizR6QOm0ejPERYyqdGvXgXOnHvL
 52bc/cOU/TtxCiH4Gz9oILfBK2fG0SSVhugX9EPlL+ewqvvdMHsPW44hjYHieRISx90zK3jg4
 e2x38TLeFeesthYqbujGUXKqrUzCW7+i97cS8NDzk8q0Zmx+HEjrFqT7aHKI7T1cAwk8GzVjK
 9Xuf3qQbhW2QXugmHug/Zhewt2Uxcpda2g7LR6uESwnbuFwmbwJCi4h3pwsgfxUeYmso=
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Tue, 07 Dec 2021 20:18:46 -0000


Am 07.12.2021 um 15:23 schrieb Corinna Vinschen:
> On Dec  7 23:00, Takashi Yano wrote:
>> - Fix a bug in fhandler_dev_clipboard::read() that the second read
>>    fails with 'Bad address'.
>>
>> Addresses:
>>    https://cygwin.com/pipermail/cygwin/2021-December/250141.html
>> ---
>>   winsup/cygwin/fhandler_clipboard.cc | 2 +-
>>   winsup/cygwin/release/3.3.4         | 6 ++++++
>>   2 files changed, 7 insertions(+), 1 deletion(-)
>>   create mode 100644 winsup/cygwin/release/3.3.4
>>
>> diff --git a/winsup/cygwin/fhandler_clipboard.cc b/winsup/cygwin/fhandler_clipboard.cc
>> index 0b87dd352..ae10228a7 100644
>> --- a/winsup/cygwin/fhandler_clipboard.cc
>> +++ b/winsup/cygwin/fhandler_clipboard.cc
>> @@ -229,7 +229,7 @@ fhandler_dev_clipboard::read (void *ptr, size_t& len)
>>         if (pos < (off_t) clipbuf->cb_size)
>>   	{
>>   	  ret = (len > (clipbuf->cb_size - pos)) ? clipbuf->cb_size - pos : len;
>> -	  memcpy (ptr, &clipbuf[1] + pos , ret);
>> +	  memcpy (ptr, (char *) &clipbuf[1] + pos, ret);
> I'm always cringing a bit when I see this kind of expression. Personally
> I think (ptr + offset) is easier to read than &ptr[offset], but of course
> that's just me.  If you agree, would it be ok to change the above to
>
>    (char *) (clipbuf + 1)
>
> while you're at it?  If you like the ampersand expression more, it's ok,
> too, of course.  Please push.
In this specific case I think it's actually more confusing because of 
the type mangling that's intended in the clipbuf.
At quick glance, it looks a bit as if the following were meant:

   (char *) clipbuf + 1


I'd even make it clearer like

+	  memcpy (ptr, ((char *) &clipbuf[1]) + pos, ret);
or even
+	  memcpy (ptr, ((char *) (&clipbuf[1])) + pos, ret);

Thomas
