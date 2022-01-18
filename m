Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-046.btinternet.com (mailomta22-sa.btinternet.com
 [213.120.69.28])
 by sourceware.org (Postfix) with ESMTPS id E3A343857C6A
 for <cygwin-patches@cygwin.com>; Tue, 18 Jan 2022 20:01:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org E3A343857C6A
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
 by sa-prd-fep-046.btinternet.com with ESMTP id
 <20220118200152.OVFP19171.sa-prd-fep-046.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Tue, 18 Jan 2022 20:01:52 +0000
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
 bimi=skipped
X-SNCR-Rigid: 6139452E11B9946A
X-Originating-IP: [81.129.146.209]
X-OWM-Source-IP: 81.129.146.209 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrudefgddufedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeffkeeigfdujeehteduiefgjeeltdelgeelteekudetfedtffefhfeufefgueettdenucfkphepkedurdduvdelrddugeeirddvtdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdefngdpihhnvghtpeekuddruddvledrudegiedrvddtledpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedupdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.103] (81.129.146.209) by
 sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as
 jonturney@btinternet.com)
 id 6139452E11B9946A for cygwin-patches@cygwin.com;
 Tue, 18 Jan 2022 20:01:52 +0000
Message-ID: <3f9f53a4-2fa3-34a0-93d4-fe67d59ac4bc@dronecode.org.uk>
Date: Tue, 18 Jan 2022 20:01:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [EXTERNAL] Re: [PATCH] Cygwin: Conditionally build documentation
Content-Language: en-GB
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <DM8PR09MB70950BB104F774E1F959F7BEA5549@DM8PR09MB7095.namprd09.prod.outlook.com>
 <06431ef7-3239-b2e7-06c1-b9b4e4090df1@dronecode.org.uk>
 <DM8PR09MB70955355574135F9CB346D82A5559@DM8PR09MB7095.namprd09.prod.outlook.com>
 <6eeba4f9-6951-d018-cbee-7dc6e40c924b@SystematicSw.ab.ca>
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <6eeba4f9-6951-d018-cbee-7dc6e40c924b@SystematicSw.ab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3571.0 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.4
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
X-List-Received-Date: Tue, 18 Jan 2022 20:01:55 -0000

On 15/01/2022 23:00, Brian Inglis wrote:
> On 2022-01-15 12:06, Lavrentiev, Anton (NIH/NLM/NCBI) [C] via 
> Cygwin-patches wrote:
>>> It is reported by 'configure --help', at the appropriate level (although
>>> since enable is the default, I probably should have written
>>> '--disable-doc' here).
>>
[...]
> 
> It looks like it's not propagated to newlib-cygwin/configure, and 
> newlib-cygwin/configure --help=recursive seems to loop recursing on 
> newlib 4.2.0, so it's only shown by winsup/configure:

In my testing, it seems that a top-level './configure --help=recursive' 
terminates eventually, it's just that there are also configures in 
subdirectories of newlib (for no good reason I know of), which makes it 
spend a long time repeating mostly useless output...
