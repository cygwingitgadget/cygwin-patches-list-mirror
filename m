Return-Path: <SRS0=tdPk=6Q=dronecode.org.uk=jon.turney@sourceware.org>
Received: from re-prd-fep-044.btinternet.com (mailomta5-re.btinternet.com [213.120.69.98])
	by sourceware.org (Postfix) with ESMTPS id DAA083858D28
	for <cygwin-patches@cygwin.com>; Mon, 20 Feb 2023 22:00:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DAA083858D28
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
          by re-prd-fep-044.btinternet.com with ESMTP
          id <20230220220008.FCWE11053.re-prd-fep-044.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>;
          Mon, 20 Feb 2023 22:00:08 +0000
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 613A8CC34F4CB25C
X-Originating-IP: [81.153.98.246]
X-OWM-Source-IP: 81.153.98.246 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvhedrudejhedgudeglecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthekredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepkeeukeeuuedukefhfeeufedtjeejfeejhfdtffdttdevvdelheegvdfftdegiedtnecuffhomhgrihhnpegthihgfihinhdrtghomhenucfkphepkedurdduheefrdelkedrvdegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtiegnpdhinhgvthepkedurdduheefrdelkedrvdegiedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepuehrihgrnhdrkfhnghhlihhssefuhhgrfidrtggrpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.106] (81.153.98.246) by re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as jonturney@btinternet.com)
        id 613A8CC34F4CB25C; Mon, 20 Feb 2023 22:00:08 +0000
Message-ID: <c22f1341-217c-3a61-c075-6f86bb812385@dronecode.org.uk>
Date: Mon, 20 Feb 2023 22:00:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Copyright outdated? in Cygwin/X FAQ 12.6 and not addressed in
 Cygwin FAQ 7.1 link
Content-Language: en-GB
To: Brian Inglis <Brian.Inglis@Shaw.ca>,
 Cygwin Patches <cygwin-patches@cygwin.com>
References: <6b01a995-96e5-7b46-3323-1cf348d25252@Shaw.ca>
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <6b01a995-96e5-7b46-3323-1cf348d25252@Shaw.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1191.2 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 20/02/2023 20:20, Brian Inglis wrote:
> Hi folks,
> [Addressing to patches as that's where we'll fix it, and not a general 
> issue.]
> 
> Noticed that:
> 
> https://x.cygwin.com/docs/faq/cygwin-x-faq.html#q-copyright-cygwin
> 
> "12.6. Who holds the copyright on the Cygwin source code?
> 
> Red Hat owns the copyright on the Cygwin source code. Red Hat requires 
> that copyright be assigned to Red Hat for non-trivial changes to Cygwin. 
> You must fill out a copyright transfer form if you are going to 
> contribute substantial changes to Cygwin."
> 
> Has that not been assigned to the project?
> 
> And also:
> 
> https://cygwin.com/faq/faq.html#faq.what.copyright
> 
> "7.1. What are the copyrights?
> 7.1.
> What are the copyrights?
> Please see https://cygwin.com/licensing.html for more information about 
> Cygwin copyright and licensing."
> 
> ->
> 
> "Cygwin™ Linking Exception
> As a special exception, the copyright holders of the Cygwin library"
> 
> Is that the project?
> 
> Or does it belong to the authors individually and/or the project or the 
> "Cygwin authors" collectively?
> 
> Could we please be as current and explicit as possible in the FAQs once 
> current situation is clear and wording is agreed?
> 
> Thinking that Cygwin/X FAQ 12.6 should defer to Cygwin FAQ 7.1.

Yes.

12.3 and 12.6 should just be links to places where correct information 
can be found.

> Willing to submit FAQ patches ;^>

Please do so.

Note that the source for this FAQ is docbook in [1]

[1] https://cygwin.com/git/cygwin-apps/xorg-doc.git

