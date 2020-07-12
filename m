Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-042.btinternet.com (mailomta6-re.btinternet.com
 [213.120.69.99])
 by sourceware.org (Postfix) with ESMTPS id C71CC3858D37
 for <cygwin-patches@cygwin.com>; Sun, 12 Jul 2020 14:47:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C71CC3858D37
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
 by re-prd-fep-042.btinternet.com with ESMTP id
 <20200712144721.XAQ13627.re-prd-fep-042.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Sun, 12 Jul 2020 15:47:21 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-Originating-IP: [31.51.206.31]
X-OWM-Source-IP: 31.51.206.31 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrvdeigdekgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffhvfhfkffffgggjggtgfesthekredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepffffhfekudfftdeukedtgffftddvteelffeiudegfeevffeitedufeeiueekjefgnecukfhppeefuddrhedurddvtdeirdefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddrudduudgnpdhinhgvthepfedurdehuddrvddtiedrfedupdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (31.51.206.31) by
 re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9BDD006735508 for cygwin-patches@cygwin.com;
 Sun, 12 Jul 2020 15:47:21 +0100
Subject: Re: [PATCH 0/8] Fix dumper for x86_64
From: Jon Turney <jon.turney@dronecode.org.uk>
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20200701212529.13998-1-jon.turney@dronecode.org.uk>
 <e058a12f-97b2-d237-a97f-4a691bf5c6e3@dronecode.org.uk>
 <20200702074444.GN3499@calimero.vinschen.de>
 <b2a72bb3-1852-46fe-81d2-0107c0076564@dronecode.org.uk>
 <20200706081200.GA514059@calimero.vinschen.de>
 <edcb449d-43b1-b80a-a4f7-e7b8c64d4b3d@dronecode.org.uk>
Message-ID: <eca34472-973f-1e5d-2ac9-7767e2ca127c@dronecode.org.uk>
Date: Sun, 12 Jul 2020 15:47:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <edcb449d-43b1-b80a-a4f7-e7b8c64d4b3d@dronecode.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, KAM_NUMSUBJECT, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sun, 12 Jul 2020 14:47:24 -0000

On 06/07/2020 14:34, Jon Turney wrote:
> On 06/07/2020 09:12, Corinna Vinschen wrote: 
> 
>> What about the two protection fields in MEMORY_BASIC_INFORMATION?  If
>> something changed, Protect != AllocationProtect.  Is that insufficient
>> to handle your case?
> 
> Unfortunately that doesn't seem to provide any additional information. 
> The Windows loader seems to allocate all regions with EXWC protection, 
> then change it to match the section. (Not that there are any guarantees 
> about it's behaviour)
> 
> I wasn't able to observe a region corresponding to an unmodified .data 
> section with WC protection, which is somewhat confusing.

I guess that might be due to something in crt0 modifying .data, since 
testing with something like:

      1  #include <windows.h>
      2
      3  int __attribute__ ((section (".special"))) mutable = 2;
      4
      5  int main()
      6  {
      7    // modify rw data
      8    // mutable = 0;
      9
     10    // deref null pointer
     11    *(int *)0 = 1;
     12  }

The memory region corresponding to the '.special' section has WC 
protection, which changes to RW if it gets modified (as expected).
