Return-Path: <SRS0=eyIz=YW=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo003.btinternet.com (btprdrgo003.btinternet.com [65.20.50.240])
	by sourceware.org (Postfix) with ESMTP id D3F2D3858CDB
	for <cygwin-patches@cygwin.com>; Sat,  7 Jun 2025 20:41:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D3F2D3858CDB
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D3F2D3858CDB
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.240
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1749328905; cv=none;
	b=R/ViA2zomN6C5S4Rk6RMtvTK57j+Rp4Be+nrwckaDzSc8uK9Fx2LQYEF9+Ougbf9d2YEDr7L7UBGqU7bMmYGXxPETETBMdcVP1rBAxFAufRPXQXJjhlwQci0nQNVu47ediI7qmpRKVhHDmvKph672goHWEazRKvvpjD1c12rPQ8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1749328905; c=relaxed/simple;
	bh=SHwEKqs6LM0JniLzLw6yHai3XfcLadl7QpGXc8B3MnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=UfBbzXfNCCu/VFYitkRwhwZkQ6oknwSwRofzls53+60ErTdugvgnOeJC7pYrZujYxuKLnUPBKT5TnR8Q1vHFs7FSZkPvDEgyu9hAmvMvT74RRngJ9gArpG/0RMZO5G3ek4i6A7Pi7dqZTXqSmAi3vUJB4WJhEZSly3+l9MBfMZI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D3F2D3858CDB
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89C7B09154A3D
X-Originating-IP: [86.144.161.4]
X-OWM-Source-IP: 86.144.161.4
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdejtddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfevjggtgfesthekredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepheegjeektddutdelvdegjeetfefgueetfffgkefggeejffejteegueejiedvhedunecuffhomhgrihhnpehsohhurhgtvgifrghrvgdrohhrghenucfkphepkeeirddugeegrdduiedurdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudeggedrudeiuddrgedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudeggedqudeiuddqgedrrhgrnhhgvgekiedqudeggedrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtfedpnhgspghrtghpthhtohepvddprhgtphhtthho
	pegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhohhhnhhgruhhgrggsohhokhesghhmrghilhdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.144.161.4) by btprdrgo003.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89C7B09154A3D; Sat, 7 Jun 2025 21:41:43 +0100
Message-ID: <d46e5c65-144e-4acb-b1e2-6040d4b5231c@dronecode.org.uk>
Date: Sat, 7 Jun 2025 21:41:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Website Suggestions
To: John Haugabook <johnhaugabook@gmail.com>
References: <CAKrZaUst28O+9Z6TBbQU0Ha3o9ZSRPzGYbpb7NiQ+1cmsUiT2Q@mail.gmail.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <CAKrZaUst28O+9Z6TBbQU0Ha3o9ZSRPzGYbpb7NiQ+1cmsUiT2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 06/06/2025 02:50, John Haugabook wrote:
> Hello,
> 
> I made a few small edits to the website, and included the patch as an
> attachment. Below are the changes:

Thanks very much for looking at this.  Our website certainly needs some 
love!

>   - Changed links to template elements to absolute, using "/" before the page.

OK. But why?

I know there's a random mix of absolute and relative paths, but why 
change them all to absolute?

(Note that the whole website is also exposed at 
https://sourceware.org/cygwin/, but doesn't work properly because of 
absolute paths...)

>   - Included template elements in nested pages.
>   - Made an edit to "Install.html".

-<code>-P package1,package2,...</code> options.
+<code>-P &lt;package1&gt; -P &lt;package2&gt;,...</code> options.

Is this reflecting that the first syntax doesn't work for you? I think 
it's supposed to, so that would be a bug in setup if it doesn't.

I'm not sure that assuming the reader knows that "enclosed in angle 
brackets means a metasyntactic variable" is a good idea.

Perhaps it's enough to italicize these to indicate they are replaceable?

>   - In style.css edited elements for better UX, and edited comment
> markers for consistency, ending at col 78 for comments marking style
> section.

I applied the change to align the comment ends, because that's just 
terrible currently. :(

Not sure what to do about consistency in placing the brace after the 
selector and indentation of the declarations.

There's also a script.js added to navbar.html which does something, but 
I can't tell what at a glance, so that will have to wait until I have 
more time to look at it...

> I wasn’t sure where website suggestions should be sent — this list
> seemed most appropriate, given its name. If there’s a better place or
> process to submit patches like this, please feel free to redirect me.

This is totally the appropriate place to send patches.

> Totally understand if the changes are rejected or revised. Thank you
> for maintaining the project and reviewing contributions.

Thanks again.

In future, if possible, please try to submit a set of patches each 
covering a separate change which can be understood in isolation, it 
makes it a lot easier to review (and lets us immediately apply 
uncontroversial changes while discussing the other parts).

