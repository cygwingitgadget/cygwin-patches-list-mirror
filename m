Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-049.btinternet.com (mailomta9-re.btinternet.com
 [213.120.69.102])
 by sourceware.org (Postfix) with ESMTPS id 5C0453857C58
 for <cygwin-patches@cygwin.com>; Fri, 31 Jul 2020 19:33:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5C0453857C58
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
 by re-prd-fep-049.btinternet.com with ESMTP id
 <20200731193315.LUXZ4131.re-prd-fep-049.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
 Fri, 31 Jul 2020 20:33:15 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-Originating-IP: [31.51.206.146]
X-OWM-Source-IP: 31.51.206.146 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrieekgddufeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeevueehfeetheetieegveejgeevheeggfeuudevvddvheetieetueekieffgedtleenucffohhmrghinhepmhhitghrohhsohhfthdrtghomhdpughllhdrshhonecukfhppeefuddrhedurddvtdeirddugeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurdduuddungdpihhnvghtpeefuddrhedurddvtdeirddugeeipdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehlrghvrhesnhgtsghirdhnlhhmrdhnihhhrdhgohhvqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (31.51.206.146) by
 re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C2FD09AF1A55; Fri, 31 Jul 2020 20:33:15 +0100
Subject: Re: [PATCH] Cygwin: Use documented QueryWorkingSetEx() in dumper
To: "Lavrentiev, Anton (NIH/NLM/NCBI) [C]" <lavr@ncbi.nlm.nih.gov>
References: <20200731130724.51334-1-jon.turney@dronecode.org.uk>
 <DM6PR09MB40434AC233CD42CB5C955A5CA54E0@DM6PR09MB4043.namprd09.prod.outlook.com>
Cc: Cygwin Patches <cygwin-patches@cygwin.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <d0cbf08d-0c40-9cf8-b820-8ad144c343ec@dronecode.org.uk>
Date: Fri, 31 Jul 2020 20:33:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <DM6PR09MB40434AC233CD42CB5C955A5CA54E0@DM6PR09MB4043.namprd09.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_LOW,
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
X-List-Received-Date: Fri, 31 Jul 2020 19:33:18 -0000

On 31/07/2020 19:40, Lavrentiev, Anton (NIH/NLM/NCBI) [C] wrote:
> Hi,
> 
> Reading this MS documentation
> 
> https://docs.microsoft.com/en-us/windows/win32/api/psapi/nf-psapi-queryworkingsetex
> 
> ... the remarks section goes:
> 
> Programs that must run on earlier versions of Windows as well as Windows 7 and later versions should always call this function as QueryWorkingSetEx. To ensure correct resolution of symbols, add Psapi.lib to the TARGETLIBS macro and compile the program with "-DPSAPI_VERSION=1". To use run-time dynamic linking, load Psapi.dll.
> 
> So if I'm reading correctly and if Vista is still being supported in Cygwin, then I guess PSAPI_VERSION=1 must be used (either Makefile or source)...

This is correct.

The MSDN documentation is unhelpfully silent on the default behaviour if 
PSAPI_VERSION is not specified.

For the w32api headers, at least, the default depends on the targetted 
version set via the NTDDI_VERSION macro (or historical alternatives to 
that), and unless Win7 or later is targetted, it defaults to 
PSAPI_VERSION=1.

Note that dumper already uses various psapi functions 
(EnumProcessModule, GetModuleInformation, GetModuleFileNameExA), so this 
patch doesn't introduce this potential ambiguity as a new issue.
