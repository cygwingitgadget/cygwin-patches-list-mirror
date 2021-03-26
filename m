Return-Path: <HBBroeker@t-online.de>
Received: from mailout12.t-online.de (mailout12.t-online.de [194.25.134.22])
 by sourceware.org (Postfix) with ESMTPS id CEE3D3857C73
 for <cygwin-patches@cygwin.com>; Fri, 26 Mar 2021 01:31:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org CEE3D3857C73
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=HBBroeker@t-online.de
Received: from fwd24.aul.t-online.de (fwd24.aul.t-online.de [172.20.26.129])
 by mailout12.t-online.de (Postfix) with SMTP id 2696546208
 for <cygwin-patches@cygwin.com>; Fri, 26 Mar 2021 02:29:28 +0100 (CET)
Received: from [192.168.178.26]
 (EfEKWMZ1ZhTAd8ThmlYS-aMjcobZYhH7DJsGLNSyvQnoVBBxsOpVb9m6gon0AEDZ-U@[79.228.82.169])
 by fwd24.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1lPbHz-1iweIq0; Fri, 26 Mar 2021 02:29:27 +0100
Subject: Re: [PATCH 1/2] Treat Windows Store's "app execution aliases" as
 symbolic links
To: cygwin-patches@cygwin.com
References: <nycvar.QRO.7.76.6.2103121611440.50@tvgsbejvaqbjf.bet>
 <ff661784-ae78-4a98-8f6d-cddd57b0d216@pismotec.com>
 <nycvar.QRO.7.76.6.2103140115180.50@tvgsbejvaqbjf.bet>
 <86c7c1b6-06f9-9e60-e9d7-072b6e8c806f@pismotec.com>
 <nycvar.QRO.7.76.6.2103150408230.50@tvgsbejvaqbjf.bet>
 <69dc492e-cce9-1a1a-7d4b-92a58dbfe981@t-online.de>
 <nycvar.QRO.7.76.6.2103221603030.50@tvgsbejvaqbjf.bet>
 <830d2446-691e-957e-9531-856e58e79c08@t-online.de>
 <YFm1GF/90te95gh8@calimero.vinschen.de>
 <b20e45d8-26fd-3186-581b-a44a4ba971ca@t-online.de>
 <e4ce7492-d6dd-2930-2059-888381ac3cff@cornell.edu>
From: =?UTF-8?Q?Hans-Bernhard_Br=c3=b6ker?= <HBBroeker@t-online.de>
Message-ID: <6ebe672a-0a63-d31b-1a33-084404e29c24@t-online.de>
Date: Fri, 26 Mar 2021 02:29:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <e4ce7492-d6dd-2930-2059-888381ac3cff@cornell.edu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-ID: EfEKWMZ1ZhTAd8ThmlYS-aMjcobZYhH7DJsGLNSyvQnoVBBxsOpVb9m6gon0AEDZ-U
X-TOI-EXPURGATEID: 150726::1616722167-00005513-668C3FB4/0/0 CLEAN NORMAL
X-TOI-MSGID: 481c8383-1a78-48cb-9304-5e2db42e091c
X-Spam-Status: No, score=2.9 required=5.0 tests=BAYES_00, FREEMAIL_FROM,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A,
 RCVD_IN_BL_SPAMCOP_NET, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H3,
 RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: **
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
X-List-Received-Date: Fri, 26 Mar 2021 01:31:25 -0000

Am 24.03.2021 um 21:58 schrieb Ken Brown:
> On 3/24/2021 2:55 PM, Hans-Bernhard Bröker wrote:
>> Am 23.03.2021 um 10:30 schrieb Corinna Vinschen via Cygwin-patches:
>>  > On Mar 22 22:54, Hans-Bernhard Bröker wrote:
>>  >> Am 22.03.2021 um 16:22 schrieb Johannes Schindelin:

>> It's what WSL Debian creates when I 'ln -s' inside its own filesystem.
>>
>> Windows' own "dir" command shows it as
>>
>> 22.03.2021  22:34    <JUNCTION>     link_to_a [...]
>>
>> But it cannot do anything else with it.  Even fsutil doesn't work on 
>> that thing:
>>
>> C:\prg\test>fsutil reparsePoint query \\wsl$\Debian\home\hbbro
>> Fehler:  Unzulässige Funktion.
> 
> Are you running WSL1 or WSL2?  

To the best of my knowledge it's WSL1.

> I have WSL1, and the stat command such as 
> the one you tried fails in the same way as yours.  Nevertheless, a 
> symlink created under WSL is indeed recognized as such by Cygwin.  I 
> verified this as follows:
> 
> 1. Within WSL,
> 
> $ ln -s foo mysymlink
> $ cp -a mysymlink /mnt/c/cygwin64/tmp

Here it gets a bit weird.  The result of that procedure depends on 
whether the link target, 'foo', exists in cygwin64/tmp prior to running 
the above commands.

If 'foo' exists, the copy of the symlink becomes a Windows native 
symlink (reparse point class 0xa000000c).  If it doesn't the copy turns 
into a reparse point of class 0xa000001d, which 'fsutil reparsepoint 
query' decodes as "name replacement", Cygwin as a (broken) symlink, and 
'dir' lists as <JUNCTION>.  In other words, a WSL symlink.

It's quite strange that copying a native WSL1 symlink from inside WSL's 
own file system out into the Windows side of things does _not_ always 
yield an identical copy.  Some layer sitting between WSL and the Windows 
file system may modify the copy in flight.

The same difference applies if, instead of copying an existing symlink, 
you just have WSL create one directly in the Windows tree, i.e.

	cd /mnt/c/cygwin64/tmp
	rm a b
	touch a
	ln -s a la
	ln -s b lb
	touch b

yields a Windows symlink for 'la', and a WSL symlink for 'lb'.
