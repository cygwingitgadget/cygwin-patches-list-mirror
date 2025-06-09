Return-Path: <SRS0=tlHB=YY=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo004.btinternet.com (btprdrgo004.btinternet.com [65.20.50.180])
	by sourceware.org (Postfix) with ESMTP id 6C8EB383068D
	for <cygwin-patches@cygwin.com>; Mon,  9 Jun 2025 23:10:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6C8EB383068D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6C8EB383068D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.180
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1749510646; cv=none;
	b=uxEI6VpT8d/XCQGXZ2UtXQsrr07jhBMNy8TsiybRmCBiY4qDVu7OsOxTwSwLLrtT4FIuB1l88NSn9i9r0gmpb22D9DJmiBdoMLNGpV8wV+Ztslhojtt8IOkDQurzbrbYQGcVtOTkv8ycqz3rdDiwIxYXA/TuKUtnTfwI+IeDcZs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1749510646; c=relaxed/simple;
	bh=a8W/7JdBOWD/8O1AbMiQaIhHQzlTjHnhbwEC9KSgVnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=uOEdoSkyHxIzXScl+QEcs9HHobtQ17zXYEmrG7PPoc4no92pv+pe7J1GuL8x9+NYR4z/5dlU9Nn1X0lYMnamqAGL4katGgoqESEvD0oXj8lAVw/FJL2q6wbUiAdmVzk/BT53uTdivQx9sg9YB8QIYPMtjJlwkKP4Ba7iyMxHBKQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6C8EB383068D
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89CAE0940819A
X-Originating-IP: [86.144.161.4]
X-OWM-Source-IP: 86.144.161.4
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdelleegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfevjggtgfesthekredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnheptdduueegledtfeehudekteefgeekjeeivdehtdfhudekudduuedvieffjeegiefhnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepkeeirddugeegrdduiedurdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudeggedrudeiuddrgedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudeggedqudeiuddqgedrrhgrnhhgvgekiedqudeggedrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtgedpnhgspghrtghpthhtohepvddprhgtphhtthhopeeurhhi
	rghnrdfknhhglhhishesufihshhtvghmrghtihgtufghrdgrsgdrtggrpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.144.161.4) by btprdrgo004.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89CAE0940819A; Tue, 10 Jun 2025 00:10:41 +0100
Message-ID: <c7b12c5d-7298-47c3-8ab4-40a8fb67e84c@dronecode.org.uk>
Date: Tue, 10 Jun 2025 00:10:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix compatibility with MinGW v13 headers
To: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
References: <DB9PR83MB09238924363B70583AA08BA5926BA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <7178d417-9d6b-14b2-95cb-b5c4fb53b463@jdrake.com>
 <1ef68eee-d80a-4dde-af43-c4fdea1e4c40@SystematicSW.ab.ca>
 <2aa8fb0c-9a96-b260-2f28-aea8dab08bcc@jdrake.com>
 <0f598539-d282-47d8-817a-4c3fc4f7235e@SystematicSW.ab.ca>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <0f598539-d282-47d8-817a-4c3fc4f7235e@SystematicSW.ab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_W,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 09/06/2025 23:20, Brian Inglis wrote:
> On 2025-06-09 15:56, Jeremy Drake via Cygwin-patches wrote:
>> On Mon, 9 Jun 2025, Brian Inglis wrote:
>>
>>> On 2025-06-09 12:54, Jeremy Drake via Cygwin-patches wrote:
>>>> On Mon, 9 Jun 2025, Radek Barton via Cygwin-patches wrote:
>>>>> Since today,
>>>>> https://github.com/cygwin/cygwin/actions/ 
>>>>> runs/15537033468 workflow started
>>>>> to fail as it seems that `cygwin/cygwin-install-action@master` action
>>>>> started to use newer MinGW headers.
>>>>>
>>>>> The attached patch fixes compatibility with v13 MinGW headers while
>>>>> preserving compatibility with v12.
>>>
>>> Perhaps in the case of this build, but not necessarily anywhere else 
>>> in Cygwin
>>> using BSD sockets.
>>>
>>>> The change to cygwin/socket.h concerns me, that is a public header, and
>>>> you can't assume they are including MinGW headers, and if they are how
>>>> they are configuring them (ie, _WIN32_WINNT define) or which ones they
>>>> are including.  It looks like the mingw-w64 header #defines cmsghdr, 
>>>> maybe
>>>> an #ifndef cmsghdr with a comment about this situation?  Or how do 
>>>> other
>>>> Cygwin headers handle potential conflicts with Windows headers?
>>> I appear to be missing where Mingw headers other than ntstatus.h are 
>>> included
>>> in these Cygwin headers so how would Mingw version be defined here?
>>
>> Inside Cygwin, additional Windows headers are included, including winsock
>> headers to implement sockets within Cygwin.
> 
> I understand that happens during the DLL build, but I am still not 
> seeing where any of those nested header includes, whether 
> __INSIDE_CYGWIN__ or not, includes any Mingw headers to define that 
> version.
> So I do not believe any such fix should be applied here.

Try adding e.g. '#define __MINGW64_VERSION_MAJOR 99' before the 
comparison, and compiling. The results might be enlightening:

>   CXX      x86_64/fastcwd.o
> In file included from /work/cygwin/src/winsup/cygwin/local_includes/cygtls.h:300,
>                  from ./globals.h:5,
>                  from /work/cygwin/src/winsup/cygwin/local_includes/winsup.h:281,
>                  from ../../../../src/winsup/cygwin/x86_64/fastcwd.cc:9:
> /work/cygwin/src/winsup/cygwin/local_includes/ntdll.h:493:9: error: ‘__MINGW64_VERSION_MAJOR’ redefined [-Werror]
>   493 | #define __MINGW64_VERSION_MAJOR 99
>       |         ^~~~~~~~~~~~~~~~~~~~~~~
> In file included from /usr/include/w32api/_mingw.h:10,
>                  from /usr/include/w32api/windows.h:9,
>                  from /work/cygwin/src/winsup/cygwin/local_includes/winlean.h:58,
>                  from /work/cygwin/src/winsup/cygwin/local_includes/winsup.h:82:
> /usr/include/w32api/_mingw_mac.h:17:9: note: this is the location of the previous definition
>    17 | #define __MINGW64_VERSION_MAJOR 13
>       |         ^~~~~~~~~~~~~~~~~~~~~~~

(and certainly quicker than grepping through a maze of include files :))

