Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-040.btinternet.com (mailomta14-sa.btinternet.com
 [213.120.69.20])
 by sourceware.org (Postfix) with ESMTPS id 518FA3857C5F
 for <cygwin-patches@cygwin.com>; Mon, 21 Sep 2020 19:22:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 518FA3857C5F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
 by sa-prd-fep-040.btinternet.com with ESMTP id
 <20200921192221.QLZA5290.sa-prd-fep-040.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Mon, 21 Sep 2020 20:22:21 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-Originating-IP: [86.176.137.240]
X-OWM-Source-IP: 86.176.137.240 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedruddvgddufeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeelieegheeghfevfeevhfdviedugfdvuefhjeehteejffefhfeuudetheeugfffhfenucfkphepkeeirddujeeirddufeejrddvgedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurdduuddungdpihhnvghtpeekiedrudejiedrudefjedrvdegtddpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (86.176.137.240) by
 sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9AA6E1212F175 for cygwin-patches@cygwin.com;
 Mon, 21 Sep 2020 20:22:21 +0100
Subject: Re: [PATCH v2] winsup/doc/faq-what.xml: FAQ 1.2 Windows versions
 supported
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20200918025335.43795-1-Brian.Inglis@SystematicSW.ab.ca>
 <ea6c7db5-5c8c-6e5c-d9be-6ffa50f2d236@cornell.edu>
 <b347ae40-0eaf-8fd6-9698-f3a04f5640ff@SystematicSw.ab.ca>
 <83715369-327e-9159-9bf9-3de5e27b47a8@cornell.edu>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <9410b3d4-ef85-7a18-2cda-c1a52d54c0f9@dronecode.org.uk>
Date: Mon, 21 Sep 2020 20:22:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <83715369-327e-9159-9bf9-3de5e27b47a8@cornell.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_NONE,
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
X-List-Received-Date: Mon, 21 Sep 2020 19:22:24 -0000

On 18/09/2020 22:17, Ken Brown via Cygwin-patches wrote:
>> Do you have to run something to regen the docs, FAQ.html, and push to 
>> the web
>> site, or does it run periodically, so I can follow up to the OP and 
>> get feed
>> back from the responder?
> 
> No, sorry.  I don't know how/when that's done.

I believe all the built cygwin documentation files are present in the 
cygwin-htdocs git repo, so updating them in that would deploy to the 
website.

This is usually only done when a cygwin release is made.
