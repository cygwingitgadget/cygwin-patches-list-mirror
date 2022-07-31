Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-045.btinternet.com (mailomta21-re.btinternet.com
 [213.120.69.114])
 by sourceware.org (Postfix) with ESMTPS id C6E633858CDA;
 Sun, 31 Jul 2022 15:03:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org C6E633858CDA
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
 by re-prd-fep-045.btinternet.com with ESMTP id
 <20220731150315.NKBL3219.re-prd-fep-045.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
 Sun, 31 Jul 2022 16:03:15 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
 bimi=skipped
X-SNCR-Rigid: 613A8DE8320DB89A
X-Originating-IP: [86.139.167.71]
X-OWM-Source-IP: 86.139.167.71 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvuddgkeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeihfeghfdviedvjeevkeektdejuddvhedtveetgeevkefgtdeigeejvdeutefhvdenucffohhmrghinhepshhouhhrtggvfigrrhgvrdhorhhgnecukfhppeekiedrudefledrudeijedrjedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdehngdpihhnvghtpeekiedrudefledrudeijedrjedupdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegtohhrihhnnhgrqdgthihgfihinhestgihghifihhnrdgtohhmpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.105] (86.139.167.71) by
 re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as
 jonturney@btinternet.com)
 id 613A8DE8320DB89A; Sun, 31 Jul 2022 16:03:15 +0100
Message-ID: <4863473c-48a0-0da0-7e32-6d1cf5522ead@dronecode.org.uk>
Date: Sun, 31 Jul 2022 16:03:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [newlib-cygwin] Cygwin: Set threadnames with
 SetThreadDescription()
Content-Language: en-GB
To: Corinna Vinschen <corinna-cygwin@cygwin.com>,
 Cygwin Patches <cygwin-patches@cygwin.com>
References: <20220729110147.4E6F43858424@sourceware.org>
 <YuPLd2hlbaNwxAJ0@calimero.vinschen.de>
 <78af80e5-baed-5ebb-314f-99d13f2a25ca@sourceware.org>
 <YuQm5xcBC+1LJSJk@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <YuQm5xcBC+1LJSJk@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1192.5 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 SPF_HELO_PASS, SPF_NONE, TXREP autolearn=no autolearn_force=no version=3.4.6
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
X-List-Received-Date: Sun, 31 Jul 2022 15:03:18 -0000

On 29/07/2022 19:28, Corinna Vinschen wrote:
> On Jul 29 15:14, Jon Turney wrote:
>> On 29/07/2022 12:58, Corinna Vinschen wrote:
>>> Hi Jon,
>>>
>>> On Jul 29 11:01, Jon TURNEY via Cygwin-cvs wrote:
>>>> https://sourceware.org/git/gitweb.cgi?p=newlib-cygwin.git;h=d4689b99c68628d9ec2fc1ac7884906ddbf6a2fc
>>>>
>>>> commit d4689b99c68628d9ec2fc1ac7884906ddbf6a2fc
>>>> Author: Jon Turney <jon.turney@dronecode.org.uk>
>>>> Date:   Thu May 19 17:27:39 2022 +0100
>>>>
>>>>       Cygwin: Set threadnames with SetThreadDescription()
>>>>       [...]
>>>> +      /* SetThreadDescription only exists in a wide-char version, so we must
>>>> +	 convert threadname to wide-char.  The encoding of threadName is
>>>> +	 unclear, so use UTF8 until we know better. */
>>>> +      int bufsize = MultiByteToWideChar (CP_UTF8, 0, threadName, -1, NULL, 0);
>>>> +      WCHAR buf[bufsize];
>>>> +      bufsize = MultiByteToWideChar (CP_UTF8, 0, threadName, -1, buf, bufsize);
>>>
>>> I think this is wrong.  The function should use stock mbstowcs instead
>>> to get the externally used encoding.  Think of SetThreadName called with
>>> program_invocation_short_name in pthread::thread_init_wrapper, or called
>>> from pthread_setname_np with an externally provided thread name.  This
>>> thread name will use the locale of the application code it's called by.
>>
>> I'm not sure.
>>
>> The linux manpage for pthread_setname_np() says "The thread name is a
>> meaningful C language string", which I think means it's ASCII-encoded, not
>> locale-encoded.
> 
> I think this only means, it's a NUL-terminated string. "Meaningful" is
> just trying to nudge developers into using meaningful names, not
> something like "blurb".

Oh yeah, that reading makes more sense!

Still I think the threadname is just really just an opaque NULL 
terminated byte sequence which you can get back with pthread_getname_np().

If there are other mechanisms which make that threadname available to 
other processes (which might have a different locale), it's unclear how 
the encoding is supposed to be handled...

>> (The solaris manpage explicitly says that the thread name is utf8 encoded)
> 
> Ok, that's an interesting point.
> 
>> The encoding for program_invocation_short_name was also unclear to me.
>> (It's the same as argv[0], so I guess it's in whatever encoding the
>> filesystem uses, which doesn't have to match the process locale encoding)
>>
>> Expecting this function to work with non-ASCII names seems optimistic :)
> 
> Well, for Linux it's certainly just an arbitrary, NUL-terminated byte
> stream, but yeah, it's certainly the only portable way to expect
> the portable codeset.
> 
> Anyway, feel free to just keep the code as is.  We're typically using
> UTF-8 anyway and people switching to one of the legacy codesets are
> supposed to know what they are doing.

Yes, I think I'll leave this as is until someone complains! :)
