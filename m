Return-Path: <SRS0=3o+7=BB=dronecode.org.uk=jon.turney@sourceware.org>
Received: from re-prd-fep-045.btinternet.com (mailomta20-re.btinternet.com [213.120.69.113])
	by sourceware.org (Postfix) with ESMTPS id E605D385B507
	for <cygwin-patches@cygwin.com>; Fri, 12 May 2023 15:36:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E605D385B507
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-045.btinternet.com with ESMTP
          id <20230512153655.OEMG10658.re-prd-fep-045.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Fri, 12 May 2023 16:36:55 +0100
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 63FE98D20886F82D
X-Originating-IP: [81.129.146.169]
X-OWM-Source-IP: 81.129.146.169 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehtddgledtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeffkeeigfdujeehteduiefgjeeltdelgeelteekudetfedtffefhfeufefgueettdenucfkphepkedurdduvdelrddugeeirdduieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdeingdpihhnvghtpeekuddruddvledrudegiedrudeiledpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepuehrihgrnhdrkfhnghhlihhssefuhhgrfidrtggrpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgvvhfkrfephhhoshhtkeduqdduvdelqddugeeiqdduieelrdhrrghnghgvkeduqdduvdelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghr
	nhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpehrvgdqphhrugdqrhhgohhuthdqtddtfe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.106] (81.129.146.169) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 63FE98D20886F82D; Fri, 12 May 2023 16:36:55 +0100
Message-ID: <0a50e9ad-59c8-65e9-95f5-f53843fbf918@dronecode.org.uk>
Date: Fri, 12 May 2023 16:36:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] fhandler/proc.cc(format_proc_cpuinfo): Add Linux 6.3
 cpuinfo
Content-Language: en-GB
To: cygwin-patches@cygwin.com, Brian Inglis <Brian.Inglis@Shaw.ca>
Newsgroups: gmane.os.cygwin.patches
References: <68bbf3607bdf37fcd32613aa962abe50846d968a.1682994011.git.Brian.Inglis@Shaw.ca>
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <68bbf3607bdf37fcd32613aa962abe50846d968a.1682994011.git.Brian.Inglis@Shaw.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 08/05/2023 04:12, Brian Inglis wrote:
> cpuid    0x00000007:0 ecx:7 shstk Shadow Stack support & Windows [20]20H1/[20]2004+
> 		    => user_shstk User mode program Shadow Stack support
> AMD SVM  0x8000000a:0 edx:25 vnmi virtual Non-Maskable Interrrupts
> Sync AMD 0x80000008:0 ebx flags across two output locations

Thanks.  I applied this.

Does this need applying to the 3.4 branch as well?

> ---
>   winsup/cygwin/fhandler/proc.cc | 29 ++++++++++++++++++++++-------

>   
> +      /* cpuid 0x00000007 ecx & Windows [20]20H1/[20]2004+ */
> +      if (maxf >= 0x00000007 && wincap.osname () >= "10.0"
> +					 && wincap.build_number () >= 19041)
> +        {
> +	  cpuid (&unused, &unused, &features1, &unused, 0x00000007, 0);
> +	  ftcprint (features1,  7, "user_shstk");	/* "user shadow stack" */
> +	}
> +

This seems a little odd and maybe worthy of a comment, as surely the CPU 
has the capability irrespective of the OS?

