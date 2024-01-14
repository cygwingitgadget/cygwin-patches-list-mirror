Return-Path: <SRS0=kPGv=IY=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-049.btinternet.com (mailomta6-sa.btinternet.com [213.120.69.12])
	by sourceware.org (Postfix) with ESMTPS id A321E3858D1E
	for <cygwin-patches@cygwin.com>; Sun, 14 Jan 2024 17:30:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A321E3858D1E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A321E3858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=213.120.69.12
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1705253429; cv=none;
	b=UJf2or3G9sVJhllQoy+qP11zQYxJVBl4KUDW89PcGHvnHn/zflMR4ibhVVeZfvwEmlm25XPFKPSIMmZhQTYKeFt1vAxrayd2DmkHq98HoRWH+zMUoTRt78cBnlmRYAiOztuVw8cGlEARnGTQGWdXIjvTVo8SRusNobbuZruZ1D4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1705253429; c=relaxed/simple;
	bh=xjzIEVmOM+2lGh6BgxSNa5F8I6uo3uIqq4QRysOOwwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=Vd/KwZ+Q50Fo8qcuO2K3aa9fbH0DFMjPFNDacxRwUsHrhAxE+y5VzU98caTLAHrIOTclNFa6DNhsLxDxFla7OP1rvMlb9ZlJoAMt/HdiCoCTzDeAuC5olqYwjErwBEYGQkRr1q2XxceeczT0PYqw7ZOeMrebdrcnZ9gCCVKnVPI=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
          by sa-prd-fep-049.btinternet.com with ESMTP
          id <20240114173024.PJE27949.sa-prd-fep-049.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
          Sun, 14 Jan 2024 17:30:24 +0000
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 6567CEC105F8B46B
X-Originating-IP: [86.139.158.103]
X-OWM-Source-IP: 86.139.158.103
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeiledguddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpefhfeefjeevveejhfffgeeiuedvgfevkeehtedvvdeiffeffeeutefhfeeuueefffenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhfrhgvvggsshgurdhorhhgpdhmrghnjedrohhrghenucfkphepkeeirddufeelrdduheekrddutdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdejngdpihhnvghtpeekiedrudefledrudehkedruddtfedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepvehhrhhishhtihgrnhdrhfhrrghnkhgvsehtqdhonhhlihhnvgdruggvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgvvhfkrfephhhoshhtkeeiqddufeelqdduheekqddutdefrdhrrghnghgvkeei
	qddufeelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpehsrgdqphhrugdqrhhgohhuthdqtddtge
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.107] (86.139.158.103) by sa-prd-rgout-004.btmx-prd.synchronoss.net (authenticated as jonturney@btinternet.com)
        id 6567CEC105F8B46B; Sun, 14 Jan 2024 17:30:24 +0000
Message-ID: <3ab13e94-fd3a-41c8-8392-fcd72042d0e9@dronecode.org.uk>
Date: Sun, 14 Jan 2024 17:30:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: introduce close_range
Content-Language: en-GB
To: Christian Franke <Christian.Franke@t-online.de>
References: <83cfd6b3-6824-fd9f-794b-7fc428f8c80d@t-online.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <83cfd6b3-6824-fd9f-794b-7fc428f8c80d@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,KAM_SHORT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 14/01/2024 16:07, Christian Franke wrote:
> Recently I learned about the existence and usefulness of close_range():
> https://github.com/smartmontools/smartmontools/issues/235
> 
> https://man.freebsd.org/cgi/man.cgi?query=close_range&sektion=2
> https://man7.org/linux/man-pages/man2/close_range.2.html
> 
> Note that the above Linux man page is not fully correct. The include 
> file "linux/close_range.h" exists, but provides only the defines. It is 
> sufficient to include "unistd.h" as on FreeBSD.
> 
> The attached patch adds this to Cygwin. It does not implement the 
> Linux-specific CLOSE_RANGE_UNSHARE as I have no idea how to do this :-)

This API should also be mentioned in the
"System interfaces compatible with GNU or Linux extensions" section of 
doc/posix.xml

