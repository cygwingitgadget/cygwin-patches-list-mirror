Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-047.btinternet.com (mailomta26-re.btinternet.com
 [213.120.69.119])
 by sourceware.org (Postfix) with ESMTPS id BBB83398B45C
 for <cygwin-patches@cygwin.com>; Fri, 23 Oct 2020 20:12:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org BBB83398B45C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
 by re-prd-fep-047.btinternet.com with ESMTP id
 <20201023201222.LPEV14484.re-prd-fep-047.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Fri, 23 Oct 2020 21:12:22 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9C0CC1731A36E
X-Originating-IP: [86.140.194.67]
X-OWM-Source-IP: 86.140.194.67 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrkedtgddugeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeguefhkedvfeeigefhhedtjeehieegtdehhffhheffgfehheegtdffleejteeuueenucfkphepkeeirddugedtrdduleegrdeijeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddrudduudgnpdhinhgvthepkeeirddugedtrdduleegrdeijedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (86.140.194.67) by
 re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C0CC1731A36E for cygwin-patches@cygwin.com;
 Fri, 23 Oct 2020 21:12:22 +0100
Subject: Re: [PATCH 3/3] Remove recursive configure for cygwin
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20201021194705.19056-1-jon.turney@dronecode.org.uk>
 <20201021194705.19056-4-jon.turney@dronecode.org.uk>
 <20201022172710.GS5492@calimero.vinschen.de>
 <fb4a8bf6-9b4a-3e77-cb32-bdd7fcce49fe@dronecode.org.uk>
 <20201023092700.GU5492@calimero.vinschen.de>
 <20201023093601.GV5492@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <c0c876c8-c666-57bf-b8a9-dbbb3348da46@dronecode.org.uk>
Date: Fri, 23 Oct 2020 21:12:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201023093601.GV5492@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1190.7 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
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
X-List-Received-Date: Fri, 23 Oct 2020 20:12:27 -0000

On 23/10/2020 10:36, Corinna Vinschen wrote:
>>>>
>>>> Does creating a new subdir called libcygserver just to build the lib
>>>> clean up things, perhaps?
>>>
>>> I did experiment with something like that, but I'm not sure if it makes
>>> things any clearer, as:
>>>
>>> (i) It's the same source files built with/without -D__OUTSIDE_CYGWIN__
> 
> Oh, btw., this is bothering me for a while now.  This may have been
> a nice idea at the time, but wouldn't it be much better to put
> common methods into headers and otherwise split the source between
> client and server code? 
> 
>>> (ii) building libcygserver requires the generated file globals.h
>>
>> I don't actually see a reason to keep this.
>>
>> There's nothing wrong simplifying this stuff, removing mkglobals_h and
>> creating a static version of globals.h inside the source dir.  For
>> instance, defining enum exit_states or enum winsym_t in global.cc just
>> to generate a globals.h from there is kind of weird anyway.  Getting rid
>> of another undocumented perl script and getting rid of the globals.h
>> build rule sounds rather good to me.

I'd really prefer to do those kinds of change as separate patches, to 
maximize the chances of having something that works. :)
