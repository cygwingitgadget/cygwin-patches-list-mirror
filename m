Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-046.btinternet.com (mailomta29-re.btinternet.com
 [213.120.69.122])
 by sourceware.org (Postfix) with ESMTPS id 1FE043954C0B
 for <cygwin-patches@cygwin.com>; Tue, 27 Oct 2020 16:09:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 1FE043954C0B
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
 by re-prd-fep-046.btinternet.com with ESMTP id
 <20201027160911.YJOH13971.re-prd-fep-046.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Tue, 27 Oct 2020 16:09:11 +0000
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9BDD017B1D9BD
X-Originating-IP: [86.140.194.67]
X-OWM-Source-IP: 86.140.194.67 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgdekgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffhvfhfkffffgggjggtgfesthekredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnheplefgiedvjedvfedttdevgfeftdelgeejgfduleeufeehueelvdekfeeiieektedunecuffhomhgrihhnpehmrghkvghfihhlvgdrihhnpdhgnhhurdhorhhgnecukfhppeekiedrudegtddrudelgedrieejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurdduuddungdpihhnvghtpeekiedrudegtddrudelgedrieejpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (86.140.194.67) by
 re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9BDD017B1D9BD for cygwin-patches@cygwin.com;
 Tue, 27 Oct 2020 16:09:11 +0000
Subject: Re: [PATCH 3/6] gendef generates sigfe.s and cygwin.def
From: Jon Turney <jon.turney@dronecode.org.uk>
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20201020134304.11281-1-jon.turney@dronecode.org.uk>
 <20201020134304.11281-4-jon.turney@dronecode.org.uk>
 <fe4bf082-427b-9611-39a5-8d50a79ba9f1@dronecode.org.uk>
Message-ID: <7ca5d881-a751-8152-9315-b28187136d4e@dronecode.org.uk>
Date: Tue, 27 Oct 2020 16:09:11 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <fe4bf082-427b-9611-39a5-8d50a79ba9f1@dronecode.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1198.1 required=5.0 tests=BAYES_00, BODY_8BITS,
 FORGED_SPF_HELO, GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY,
 KAM_SHORT, NICE_REPLY_A, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS,
 SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 27 Oct 2020 16:09:23 -0000

On 21/10/2020 15:31, Jon Turney wrote:
> On 20/10/2020 14:43, Jon Turney wrote:
>> Express that gendef generates sigfe.s and cygwin.def in a slightly less
>> nutty way.
>> ---
>>   winsup/cygwin/Makefile.in | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
>> index a56a311b8..9d05b17b3 100644
>> --- a/winsup/cygwin/Makefile.in
>> +++ b/winsup/cygwin/Makefile.in
>> @@ -785,16 +785,13 @@ $(VERSION_OFILES): version.cc
>>   Makefile: ${srcdir}/Makefile.in
>>       /bin/sh ./config.status
>> -$(DEF_FILE): gendef $(srcdir)/$(TLSOFFSETS_H) $(DIN_FILE)
>> +$(DEF_FILE) sigfe.s: gendef $(srcdir)/$(TLSOFFSETS_H) $(DIN_FILE)
>>       $(word 1,$^) --cpu=${target_cpu} --output-def=$@  
>> --tlsoffsets=$(word 2,$^) $(wordlist 3,99,$^)
> 
> Using $@ is wrong if make decides to build sigfe.s first, and $^ will 
> contain an unwanted $(DEF_FILE) from the dependency below.
> 
> So please try the attached instead.
> 
> But maybe I need to do a bit more staring at [1].
> 
> [1] 
> https://www.gnu.org/software/automake/manual/html_node/Multiple-Outputs.html 
> 

Notwithstanding that, this formulation doesn't actually seem to avoid 
invoking the rule twice in a parallel build, so I think I need to revert 
this.
