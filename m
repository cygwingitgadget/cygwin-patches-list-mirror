Return-Path: <SRS0=eyIz=YW=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo004.btinternet.com (btprdrgo004.btinternet.com [65.20.50.128])
	by sourceware.org (Postfix) with ESMTP id 71A0B3858CDB
	for <cygwin-patches@cygwin.com>; Sat,  7 Jun 2025 20:55:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 71A0B3858CDB
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 71A0B3858CDB
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.128
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1749329722; cv=none;
	b=XxYvS8vRnOkN8D0izm/SMh4+84AQ2OQWFga7z1ApAfgYX+brB6UMuh1FOtdTK21MAzv0u4+gfEG9G0M9wsWoGeVEufGWVzMW+xx5Ft9iGcYbKdrbJLYHfxy7jZmaCn1Y7B+ZJZ4YaueblST5U+grXMNE1nIq1moEIVYw4K4llfs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1749329722; c=relaxed/simple;
	bh=zm1BdqAHMdwZSjeOhqPtW9jmYNQNJQ7Mv4qAwuUA06g=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=GiccWPQfr2nLxOIIic2x3RaP35NfVWg3YRA0z6j6G4SeG4glKx5B3jtXx26o0prDfNSvsddFJNLGDnsyaqTrjuj3dYQruoqCLYAoF+o5qbdfnsAjhGNGkTTZzlgsf9UMHfnx0G3IiLMxBC7a9MtN2T5/YpgryLtg0rQqUET7WcA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 71A0B3858CDB
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89CAE090BFF68
X-Originating-IP: [86.144.161.4]
X-OWM-Source-IP: 86.144.161.4
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdejtdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepgfeghfdvvdeijeettdfgleetffetfedtuefgfeevhedthefgffelfeethfdvleffnecuffhomhgrihhnpegthihgfihinhdrtghomhenucfkphepkeeirddugeegrdduiedurdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudeggedrudeiuddrgedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudeggedqudeiuddqgedrrhgrnhhgvgekiedqudeggedrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtgedpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihg
	fihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhohhhnhhgruhhgrggsohhokhesghhmrghilhdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.144.161.4) by btprdrgo004.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89CAE090BFF68; Sat, 7 Jun 2025 21:55:21 +0100
Message-ID: <d28554d6-60be-4432-a4e4-bfb90c417ccf@dronecode.org.uk>
Date: Sat, 7 Jun 2025 21:55:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Website Suggestions
To: John Haugabook <johnhaugabook@gmail.com>
References: <CAKrZaUst28O+9Z6TBbQU0Ha3o9ZSRPzGYbpb7NiQ+1cmsUiT2Q@mail.gmail.com>
 <79bde4c8-658b-438d-9c40-202e03ef23ba@SystematicSW.ab.ca>
 <CAKrZaUuNGaC=kzDb-nRZmk3r4vm-3GM8W+AbbOgaWvoihQR7gw@mail.gmail.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <CAKrZaUuNGaC=kzDb-nRZmk3r4vm-3GM8W+AbbOgaWvoihQR7gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 06/06/2025 21:50, John Haugabook wrote:
> 
> Didn't work for me. I can use the xml from:
> 
>   https://cygwin.com/git/?p=newlib-cygwin.git;f=winsup/doc;a=tree
> 
> and do a makeshift build, but doing that doesn't really do any good
> unless I can generate the html as it is done from however newlib
> generates the html page from xml.

The {faq,cygwin-api/cygwin-ug} documentation is built (by default) as 
part of the cygwin build process.

So, the instructions [1] should work.

(You might be able to shortcut this and just do a make in winsup/doc 
after the first time)

I think getting the docbook-generated documentation to sit inside our 
navbar frame on the website is not straightforward, which is why it's 
not done at the moment.

There's some automation I made to deploy this to the website after a CI 
build, but unfortunately that's not hooked up yet due to some issues, so 
I believe the current process is just a script that corinna runs to copy 
the build products into the cygwin-htdocs repo and check them in.

[1] https://cygwin.com/faq.html#faq.programming.building-cygwin
