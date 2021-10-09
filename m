Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-041.btinternet.com (mailomta8-sa.btinternet.com
 [213.120.69.14])
 by sourceware.org (Postfix) with ESMTPS id D5C1A385840A
 for <cygwin-patches@cygwin.com>; Sat,  9 Oct 2021 14:30:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org D5C1A385840A
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
 by sa-prd-fep-041.btinternet.com with ESMTP id
 <20211009143011.QKMH30965.sa-prd-fep-041.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Sat, 9 Oct 2021 15:30:11 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
 bimi=skipped
X-SNCR-Rigid: 613006A905866E78
X-Originating-IP: [86.144.41.56]
X-OWM-Source-IP: 86.144.41.56 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtvddgjedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeelieegheeghfevfeevhfdviedugfdvuefhjeehteejffefhfeuudetheeugfffhfenucfkphepkeeirddugeegrdeguddrheeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdefngdpihhnvghtpeekiedrudeggedrgedurdehiedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.103] (86.144.41.56) by
 sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as
 jonturney@btinternet.com)
 id 613006A905866E78 for cygwin-patches@cygwin.com;
 Sat, 9 Oct 2021 15:30:11 +0100
Subject: Re: [PATCH] Cygwin: Make native clipboard layout same for 32- and
 64-bit
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20211007052237.7139-1-mark@maxrnd.com>
 <20211008185210.cac713f28dea727a1467cf94@nifty.ne.jp>
 <29514de9-0d19-0d22-b8e1-3bfbce11589b@cornell.edu>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <7dd31f61-43a1-4e4d-2e1a-dc79606263d5@dronecode.org.uk>
Date: Sat, 9 Oct 2021 15:29:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <29514de9-0d19-0d22-b8e1-3bfbce11589b@cornell.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1196.7 required=5.0 tests=BAYES_00, BODY_8BITS,
 FORGED_SPF_HELO, GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY,
 NICE_REPLY_A, RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2,
 SPF_HELO_PASS, SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Sat, 09 Oct 2021 14:30:14 -0000

On 07/10/2021 06:22, Mark Geisert wrote:
 > The cygutils package has two programs, putclip and getclip, that also
 > depend on the layout of the cygcb_t.  At present they have duplicate
 > defs of struct cygcb_t defined here as no Cygwin header provides it.

This struct should maybe be in sys/cygwin.h or similar, if it's expected 
to be used in user-space as well.

On 09/10/2021 15:19, Ken Brown wrote:
> On 10/8/2021 5:52 AM, Takashi Yano wrote:
>> How about simply just:
>>
>> diff --git a/winsup/cygwin/fhandler_clipboard.cc 
>> b/winsup/cygwin/fhandler_clipboard.cc
>> index ccdb295f3..d822f4fc4 100644
>> --- a/winsup/cygwin/fhandler_clipboard.cc
>> +++ b/winsup/cygwin/fhandler_clipboard.cc
>> @@ -28,9 +28,10 @@ static const WCHAR *CYGWIN_NATIVE = 
>> L"CYGWIN_NATIVE_CLIPBOARD";
>>   typedef struct
>>   {
>> -  timestruc_t    timestamp;
>> -  size_t    len;
>> -  char        data[1];
>> +  uint64_t tv_sec;
>> +  uint64_t tv_nsec;
>> +  uint64_t len;
>> +  char data[1];
>>   } cygcb_t;
> 
> The only problem with this is that it might leave readers scratching 
> their heads unless they look at the commit that introduced this.  What 

I think the solution to that is a "comment" like "we don't use 'struct 
timespec' here as it's different size on different arches and that 
causes problem XYZ".

(I think that's preferable to conditional code which we assert (but 
don't ensure) is the same on all arches)
