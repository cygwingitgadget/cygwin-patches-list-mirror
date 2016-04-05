Return-Path: <cygwin-patches-return-8555-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 61265 invoked by alias); 5 Apr 2016 16:50:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 61250 invoked by uid 89); 5 Apr 2016 16:50:47 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.5 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2 spammy=D*towo.net, towo@towo.net, U*towo, towotowonet
X-HELO: demumfd001.nsn-inter.net
Received: from demumfd001.nsn-inter.net (HELO demumfd001.nsn-inter.net) (93.183.12.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Tue, 05 Apr 2016 16:50:37 +0000
Received: from demuprx017.emea.nsn-intra.net ([10.150.129.56])	by demumfd001.nsn-inter.net (8.15.2/8.15.2) with ESMTPS id u35GoXj4006685	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)	for <cygwin-patches@cygwin.com>; Tue, 5 Apr 2016 16:50:34 GMT
Received: from [127.0.0.1] ([10.149.133.212])	by demuprx017.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id u35GoVL7024851	for <cygwin-patches@cygwin.com>; Tue, 5 Apr 2016 18:50:33 +0200
Subject: Re: Fwd: Re: [PATCH] Be truthful about reporting whether readahead is available
To: cygwin-patches@cygwin.com
References: <4b19a1f32862208db6121371bd7ef395f6699535.1459846294.git.johannes.schindelin@gmx.de> <20160405135549.GE26281@calimero.vinschen.de> <748397985.175721.a41cd152-02d9-4741-9845-0d01439e7852.open-xchange@email.1und1.de>
From: Thomas Wolff <towo@towo.net>
Message-ID: <5703ECD7.1080502@towo.net>
Date: Tue, 05 Apr 2016 16:50:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <748397985.175721.a41cd152-02d9-4741-9845-0d01439e7852.open-xchange@email.1und1.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 2565
X-purgate-ID: 151667::1459875034-00001B3D-1E4AE2F2/0/0
X-IsSubscribed: yes
X-SW-Source: 2016-q2/txt/msg00030.txt.bz2


>> Von: Corinna Vinschen <corinna-cygwin@cygwin.com>
>> An: cygwin-patches@cygwin.com
>> Cc: Thomas Wolff <towo@towo.net>
>> Datum: 5. April 2016 um 15:55
>> Betreff: Re: [PATCH] Be truthful about reporting whether readahead is 
>> available
>>
>> Thomas?
>>
>> Any input?
>>
Yes, let's fix the patch so. Sorry for the flaw.
Thomas

>>
>> On Apr 5 10:52, Johannes Schindelin wrote:
>>
>>> In 7346568 (Make requested console reports work, 2016-03-16), code was
>>> introduced to report the current cursor position. It works by using a
>>> pointer that either points to the next byte in the readahead buffer, or
>>> to a NUL byte if the buffer is depleted, or the pointer is NULL.
>>>
>>> These conditions are heeded in the fhandler_console::read() method, but
>>> the condition that the pointer can point at the end of the readahead
>>> buffer was not handled properly in the get_cons_readahead_valid()
>>> method.
>>>
>>> This poses a problem e.g. in Git for Windows (which uses a slightly
>>> modified MSYS2 runtime which is in turn a slightly modified Cygwin
>>> runtime) when vim queries the cursor position and immediately goes on to
>>> read console input, erroneously thinking that the readahead buffer is
>>> valid when it is already depleted instead. This condition results in an
>>> apparent freeze that can be helped only by pressing keys repeatedly.
>>>
>>> The full Git for Windows bug report is here:
>>>
>>> https://github.com/git-for-windows/git/issues/711
>>>
>>> Let's just teach the get_cons_readahead_valid() method to handle a
>>> depleted readahead buffer correctly.
>>>
>>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>>> ---
>>> winsup/cygwin/fhandler.h | 3 ++-
>>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
>>> index 4610557..bd1a923 100644
>>> --- a/winsup/cygwin/fhandler.h
>>> +++ b/winsup/cygwin/fhandler.h
>>> @@ -1453,7 +1453,8 @@ private:
>>> bool focus_aware () {return shared_console_info->con.use_focus;}
>>> bool get_cons_readahead_valid ()
>>> {
>>> - return shared_console_info->con.cons_rapoi != NULL;
>>> + return shared_console_info->con.cons_rapoi != NULL &&
>>> + *shared_console_info->con.cons_rapoi;
>>> }
>>>
>>> select_record *select_read (select_stuff *);
>>> -- 
>>> 2.8.0.windows.1
>>>
>>
>> Thanks,
>> Corinna
>>
>> -- 
>> Corinna Vinschen Please, send mails regarding Cygwin to
>> Cygwin Maintainer cygwin AT cygwin DOT com
>> Red Hat
>>

