Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-044.btinternet.com (mailomta29-sa.btinternet.com
 [213.120.69.35])
 by sourceware.org (Postfix) with ESMTPS id B86E03851C1C
 for <cygwin-patches@cygwin.com>; Sat,  4 Jul 2020 15:35:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B86E03851C1C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
 by sa-prd-fep-044.btinternet.com with ESMTP id
 <20200704153508.YVRS3440.sa-prd-fep-044.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
 Sat, 4 Jul 2020 16:35:08 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-Originating-IP: [31.51.206.31]
X-OWM-Source-IP: 31.51.206.31 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrtdekgdeltdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepteelffegteeiudeuteehffevledvffeffeekgffhhfehvdfhgffhteehteelteeknecuffhomhgrihhnpegthihgfihinhdrtghomhenucfkphepfedurdehuddrvddtiedrfedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurdduuddungdpihhnvghtpeefuddrhedurddvtdeirdefuddpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoeeurhhirghnrdfknhhglhhishesufihshhtvghmrghtihgtufifrdgrsgdrtggrqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (31.51.206.31) by
 sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9AFBE0526BBF6; Sat, 4 Jul 2020 16:35:08 +0100
Subject: Re: [PATCH] Clarify FAQ 1.5 What version of Cygwin is this, anyway?
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20200703231716.24076-1-Brian.Inglis@SystematicSW.ab.ca>
 <c30067ad-2a47-bd21-1ca4-21d4c3c217ba@SystematicSw.ab.ca>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <f525fe8f-8c72-3c28-2910-0e0cdc58b62d@dronecode.org.uk>
Date: Sat, 4 Jul 2020 16:35:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c30067ad-2a47-bd21-1ca4-21d4c3c217ba@SystematicSw.ab.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_NONE,
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
X-List-Received-Date: Sat, 04 Jul 2020 15:35:12 -0000

On 04/07/2020 04:47, Brian Inglis wrote:
> On 2020-07-03 17:17, Brian Inglis wrote:
>> Relate Cygwin DLL to Unix kernel,
>> add required options to command examples,
>> differentiate Unix and Cygwin commands;
>> mention that the cygwin package contains the DLL.
>>
>> ---
>>   faq/faq.html | 34 ++++++++++++++++++++++++----------
>>   1 file changed, 24 insertions(+), 10 deletions(-)
> 
> Patch to:
> 	https://cygwin.com/git/?p=cygwin-htdocs.git;f=faq/faq.html;hb=HEAD
> as a result of thread:
> 	https://cygwin.com/pipermail/cygwin/2020-July/245442.html

Thanks for looking at this.

My perspective is that, if (as appears to be the case here) the problem 
is with people who can't or won't read and *absorb* the available 
information, the solution is not to add more words reiterating and 
expanding, but rather to focus on clarifying the existing words.

So, I'd think this faq should start with a paragraph consisting of a 
single sentence similar to:

"To find the version of the Cygwin DLL installed, you can use `uname 
-a`, as you would for a Unix kernel".

Feel free to elaborate on alternatives and refinements on that in later 
paragraphs.

If you're touching this FAQ, please also replace the literal `setup.exe` 
with `the setup program` or similar circumlocutions, as we no longer use 
that literal name.
