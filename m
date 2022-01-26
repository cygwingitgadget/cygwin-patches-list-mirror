Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-042.btinternet.com (mailomta8-sa.btinternet.com
 [213.120.69.14])
 by sourceware.org (Postfix) with ESMTPS id DF72B388882B
 for <cygwin-patches@cygwin.com>; Wed, 26 Jan 2022 15:19:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org DF72B388882B
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
 by sa-prd-fep-042.btinternet.com with ESMTP id
 <20220126151953.IBTB14747.sa-prd-fep-042.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Wed, 26 Jan 2022 15:19:53 +0000
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
 bimi=skipped
X-SNCR-Rigid: 613943C612BC0724
X-Originating-IP: [81.129.146.209]
X-OWM-Source-IP: 81.129.146.209 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrfedugdejgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffhvfhfjggtgfesthekredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepleelhedvtdetheehvdefleetgfffjefhtdefjedtteejvdekuedvgedvjeeijeehnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepkedurdduvdelrddugeeirddvtdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdefngdpihhnvghtpeekuddruddvledrudegiedrvddtledpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedupdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.103] (81.129.146.209) by
 sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as
 jonturney@btinternet.com)
 id 613943C612BC0724 for cygwin-patches@cygwin.com;
 Wed, 26 Jan 2022 15:19:53 +0000
Message-ID: <050efe6f-c95f-1cba-5511-d47410e3d3d6@dronecode.org.uk>
Date: Wed, 26 Jan 2022 15:19:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 2/4] Cygwin: silence dblatex when building PDFs
Content-Language: en-GB
From: Jon Turney <jon.turney@dronecode.org.uk>
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20220119131521.51616-1-jon.turney@dronecode.org.uk>
 <20220119131521.51616-3-jon.turney@dronecode.org.uk>
 <e3affd29-31c9-7b0c-62a3-0517a4160c3a@dronecode.org.uk>
 <YemR8tK+rc1oHX7o@calimero.vinschen.de>
 <33d9b470-5bb9-e707-06fa-c6a4ebe3f320@dronecode.org.uk>
In-Reply-To: <33d9b470-5bb9-e707-06fa-c6a4ebe3f320@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1198.5 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Wed, 26 Jan 2022 15:19:57 -0000

On 20/01/2022 20:02, Jon Turney wrote:
> On 20/01/2022 16:46, Corinna Vinschen wrote:
>> On Jan 20 16:43, Jon Turney wrote:
>>> On 19/01/2022 13:15, Jon Turney wrote:
>>>> Unless make is invoked with V=1, have xmlto pass '-q' to dblatex when
>>>> building PDFs, to avoid "default template used in programlisting or
>>>> screen" warnings from dblatex's verbatim.xsl stylesheet.
>>>> ---
>>>>    winsup/doc/Makefile.am | 7 +++++--
>>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/winsup/doc/Makefile.am b/winsup/doc/Makefile.am
>>>> index 44b64babc..57b74341a 100644
>>>> --- a/winsup/doc/Makefile.am
>>>> +++ b/winsup/doc/Makefile.am
>>>> @@ -17,6 +17,9 @@ doc_DATA = \
>>>>    htmldir = $(datarootdir)/doc
>>>>    XMLTO=@XMLTO@ --skip-validation --with-dblatex
>>>> +XMLTO_DBLATEX_QUIET_=-p '-q'
>>>> +XMLTO_DBLATEX_QUIET=$(XMLTO_DBLATEX_QUIET_$(V))
>>>
>>>
>>> This doesn't seem to be working as expected when building on Fedora 
>>> Rawhide

Actually it's running on F35

>>> [1], but it looks like xmlto isn't using dblatex despite ' 
>>> --with-dblatex'?
>>
>> Did you install dblatex?
> 
> Yes, I meant to write "... and dblatex being installed." :)
> 
> https://github.com/cygwin/cygwin/runs/4876704875?check_suite_focus=true#step:11:10 

This seems to be the output of 'mktexfmt pdflatex.fmt' which is run once 
to generate some stuff (the 'TeX format') which is cached in 
~/.texlive2021 (and so is appearing in every run in the ephermeral VM 
used by github actions)

So this could be suppressed by running something like that in the setup 
script.
