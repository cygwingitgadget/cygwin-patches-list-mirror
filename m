Return-Path: <SRS0=huh0=6N=dronecode.org.uk=jon.turney@sourceware.org>
Received: from re-prd-fep-047.btinternet.com (mailomta20-re.btinternet.com [213.120.69.113])
	by sourceware.org (Postfix) with ESMTPS id 6C93F3858C31
	for <cygwin-patches@cygwin.com>; Fri, 17 Feb 2023 13:14:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6C93F3858C31
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
          by re-prd-fep-047.btinternet.com with ESMTP
          id <20230217131437.KFZW20465.re-prd-fep-047.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>;
          Fri, 17 Feb 2023 13:14:37 +0000
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 613A901C4EE31C5E
X-Originating-IP: [81.153.98.246]
X-OWM-Source-IP: 81.153.98.246 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvhedrudeiledggeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeehudeuveeujeeujeegueefhedttdekvedtudeileefteetfeefjeejudekfefggfenucffohhmrghinheptgihghifihhnrdgtohhmnecukfhppeekuddrudehfedrleekrddvgeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdeingdpihhnvghtpeekuddrudehfedrleekrddvgeeipdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopeeurhhirghnrdfknhhglhhishesufhhrgifrdgtrgdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.106] (81.153.98.246) by re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as jonturney@btinternet.com)
        id 613A901C4EE31C5E; Fri, 17 Feb 2023 13:14:37 +0000
Message-ID: <cf7530d5-2b99-b6b1-1b14-42c2707ac10c@dronecode.org.uk>
Date: Fri, 17 Feb 2023 13:14:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Cygwin build utils dumper fails - new prereqs required?
To: Brian Inglis <Brian.Inglis@Shaw.ca>,
 Cygwin Patches <cygwin-patches@cygwin.com>
References: <545a5149-0470-6541-9a27-5cdb74f646c6@Shaw.ca>
Content-Language: en-GB
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <545a5149-0470-6541-9a27-5cdb74f646c6@Shaw.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1191.3 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 16/02/2023 23:02, Brian Inglis wrote:
> Hi folks,
> 
> Building Cygwin from latest repo testing some unrelated doc patches and 
> updated Unicode tables.
> Cygwin utils fails to build dumper.
> References to elf and binutils debuginfo, and undefined references to 
> sframe_de-/encode ZSTD_de-/compress/_isError in attached log - config 
> and normal processing suppressed and paths sanitized!
> Are new prereqs required to be installed to satisfy, or something 
> changed to suppress these references?

Yes, to build dumper with libbfd from binutils 2.40, you need 
libzstd-devel and

https://cygwin.com/git/?p=newlib-cygwin.git;a=commit;h=1387ea9f984d5a7aa096a66b67d61dc2cc565d21

