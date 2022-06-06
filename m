Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-043.btinternet.com (mailomta4-sa.btinternet.com
 [213.120.69.10])
 by sourceware.org (Postfix) with ESMTPS id 3E3D63858C54
 for <cygwin-patches@cygwin.com>; Mon,  6 Jun 2022 10:41:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 3E3D63858C54
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
 by sa-prd-fep-043.btinternet.com with ESMTP id
 <20220606104140.LGWH3164.sa-prd-fep-043.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
 Mon, 6 Jun 2022 11:41:40 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
 bimi=skipped
X-SNCR-Rigid: 613006A928F6C90E
X-Originating-IP: [86.139.167.41]
X-OWM-Source-IP: 86.139.167.41 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvfedrtddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeehudeuveeujeeujeegueefhedttdekvedtudeileefteetfeefjeejudekfefggfenucffohhmrghinheptgihghifihhnrdgtohhmnecukfhppeekiedrudefledrudeijedrgedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdehngdpihhnvghtpeekiedrudefledrudeijedrgedupdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepkhgsrhhofihnsegtohhrnhgvlhhlrdgvughu
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.105] (86.139.167.41) by
 sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as
 jonturney@btinternet.com)
 id 613006A928F6C90E; Mon, 6 Jun 2022 11:41:39 +0100
Message-ID: <618fb9d8-52bd-a14d-4419-46408d4d3bd6@dronecode.org.uk>
Date: Mon, 6 Jun 2022 11:41:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] Cygwin: remove most occurrences of __stdcall, WINAPI,
 and, __cdecl
Content-Language: en-GB
To: Ken Brown <kbrown@cornell.edu>, Cygwin Patches <cygwin-patches@cygwin.com>
References: <2d54f846-365f-848f-4fdb-1c22d4c1bfa0@cornell.edu>
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <2d54f846-365f-848f-4fdb-1c22d4c1bfa0@cornell.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1194.2 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 SPF_HELO_PASS, SPF_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
X-List-Received-Date: Mon, 06 Jun 2022 10:41:43 -0000

On 03/06/2022 15:00, Ken Brown wrote:
> --- a/winsup/utils/regtool.cc
> +++ b/winsup/utils/regtool.cc
> @@ -590,7 +590,7 @@ cmd_add ()
>   }
>   
>   extern "C" {
> -  LONG WINAPI (*regDeleteKeyEx)(HKEY, LPCWSTR, REGSAM, DWORD);
> +  LONG (*regDeleteKeyEx)(HKEY, LPCWSTR, REGSAM, DWORD);
>   }
>   
>   int
> @@ -603,7 +603,7 @@ cmd_remove ()
>       {
>         HMODULE mod = LoadLibrary ("advapi32.dll");
>         if (mod)
> -	regDeleteKeyEx = (LONG WINAPI (*)(HKEY, LPCWSTR, REGSAM, DWORD)) GetProcAddress (mod, "RegDeleteKeyExW");
> +	regDeleteKeyEx = (LONG (*)(HKEY, LPCWSTR, REGSAM, DWORD)) GetProcAddress (mod, "RegDeleteKeyExW");
>       }
>     if (regDeleteKeyEx)
>       rv = (*regDeleteKeyEx) (key, value, wow64, 0);

MSDN says RegDeleteKeyExW() is since Windows 2000, so I think this can 
all be dropped and just link with it directly instead?

There may be other instances of that simplification which can happen in 
utils/ ?

Later: This all seems strangely familiar...  Oh, it appears I wrote this 
patch, and then forgot to apply it :(

https://cygwin.com/pipermail/cygwin-patches/2022q1/011794.html
