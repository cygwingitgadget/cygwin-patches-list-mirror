Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-041.btinternet.com (mailomta17-re.btinternet.com
 [213.120.69.110])
 by sourceware.org (Postfix) with ESMTPS id C45E93858D3C
 for <cygwin-patches@cygwin.com>; Sat, 15 Jan 2022 15:06:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org C45E93858D3C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
 by re-prd-fep-041.btinternet.com with ESMTP id
 <20220115150658.NKWJ24157.re-prd-fep-041.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>;
 Sat, 15 Jan 2022 15:06:58 +0000
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
 bimi=skipped
X-SNCR-Rigid: 613A901C108DD5C4
X-Originating-IP: [81.129.146.209]
X-OWM-Source-IP: 81.129.146.209 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrtdejgdejfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthejredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepffekiefgudejheetudeigfejledtleegleetkeduteeftdfffefhueefgfeutedtnecukfhppeekuddruddvledrudegiedrvddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtfegnpdhinhgvthepkedurdduvdelrddugeeirddvtdelpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtoheplhgrvhhrsehntggsihdrnhhlmhdrnhhihhdrghhovh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.103] (81.129.146.209) by
 re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as
 jonturney@btinternet.com)
 id 613A901C108DD5C4; Sat, 15 Jan 2022 15:06:58 +0000
Message-ID: <06431ef7-3239-b2e7-06c1-b9b4e4090df1@dronecode.org.uk>
Date: Sat, 15 Jan 2022 15:06:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] Cygwin: Conditionally build documentation
Content-Language: en-GB
To: "Lavrentiev, Anton (NIH/NLM/NCBI) [C]" <lavr@ncbi.nlm.nih.gov>,
 "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <DM8PR09MB70950BB104F774E1F959F7BEA5549@DM8PR09MB7095.namprd09.prod.outlook.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <DM8PR09MB70950BB104F774E1F959F7BEA5549@DM8PR09MB7095.namprd09.prod.outlook.com>
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
X-List-Received-Date: Sat, 15 Jan 2022 15:07:02 -0000

On 14/01/2022 20:18, Lavrentiev, Anton (NIH/NLM/NCBI) [C] wrote:
>>
>> Add a configure option '--disable-doc' to disable building of the
>> documentation by the 'all' target.
>>
> 
> Can you please also add --disable-doc to "configure --help"?  It took
> me awhile to figure out which option I should use to skip the doc
> from building because it does no longer ignore doc build failure by
> default (unlike it used to do).

It is reported by 'configure --help', at the appropriate level (although 
since enable is the default, I probably should have written 
'--disable-doc' here).

 > jon@tambora /work/cygwin/src/winsup master
 > $ ./configure --help
[...]
 >   --enable-doc            Build documentation
[...]
