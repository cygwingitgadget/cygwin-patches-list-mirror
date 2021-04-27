Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-045.btinternet.com (mailomta31-re.btinternet.com
 [213.120.69.124])
 by sourceware.org (Postfix) with ESMTPS id 7A31C398E46A
 for <cygwin-patches@cygwin.com>; Tue, 27 Apr 2021 15:55:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 7A31C398E46A
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
 by re-prd-fep-045.btinternet.com with ESMTP id
 <20210427155509.ECIJ19196.re-prd-fep-045.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Tue, 27 Apr 2021 16:55:09 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9C2FD30971B3D
X-Originating-IP: [81.153.98.246]
X-OWM-Source-IP: 81.153.98.246 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledrvddvtddgleeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeguefhkedvfeeigefhhedtjeehieegtdehhffhheffgfehheegtdffleejteeuueenucfkphepkedurdduheefrdelkedrvdegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddrudduudgnpdhinhgvthepkedurdduheefrdelkedrvdegiedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (81.153.98.246) by
 re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C2FD30971B3D for cygwin-patches@cygwin.com;
 Tue, 27 Apr 2021 16:55:09 +0100
Subject: Re: [PATCH] Use automake (v5)
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20210420201326.4876-1-jon.turney@dronecode.org.uk>
 <5d7176f9-8d82-9b2c-4717-fdc5041d95ce@dronecode.org.uk>
 <YIBVYytjWjpdFDTo@calimero.vinschen.de>
 <YIFkrv4KPAQypN8o@calimero.vinschen.de>
 <YIbWW3mJsphIW9hd@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <c3eca196-30d7-3022-5e6a-dff3dbf40002@dronecode.org.uk>
Date: Tue, 27 Apr 2021 16:54:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YIbWW3mJsphIW9hd@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3571.4 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 27 Apr 2021 15:55:11 -0000

On 26/04/2021 16:03, Corinna Vinschen wrote:
> On Apr 22 13:57, Corinna Vinschen wrote:
>> On Apr 21 18:40, Corinna Vinschen wrote:
>>> On Apr 20 21:15, Jon Turney wrote:
>>>> On 20/04/2021 21:13, Jon Turney wrote:
>>>> * some object files are in a unexpected places in the build file hierarchy
>>>> (compared to naive expectations and/or the non-automake build)
>>>
>>> This is the only minor qualm I have with this patch.  It would be nice
>>> to have the mingw sources and .o files in the mingw subdir.  It would
>>> simply be a bit cleaner.  The files shared between cygwin and mingw
>>> (that's only path.cc, I think) could be handled by an include, i. e.
>>>
>>>    utils/
>>>
>>>      path.cc (full implementation)
>>>
>>>    utils/mingw/
>>>
>>>      path.cc:
>>>
>>>        #include "../path.cc"
>>
>> I wonder if it wouldn't make sense to split out the mingw-only parts
>> of path.cc entirely.  I had a quick view into the file and it turns
>> out that of the almost 1000 lines in this file, only about 100 lines
>> are used by mount.  All the rest is only used by mingw code, i. e.,
>> cygcheck and strace.
>>
>> That's obviously not part of this patch, but something we should keep
>> in mind for a later cleanup.
> 
> I tried this as a POC and it's not much of a problem.  See the below
> patch.  Cleaning up the includes is still to do.
> 

Thanks, this seems workable.  I'll take a look.
