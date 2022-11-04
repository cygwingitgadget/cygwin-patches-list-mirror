Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-048.btinternet.com (mailomta5-sa.btinternet.com [213.120.69.11])
	by sourceware.org (Postfix) with ESMTPS id 84B873858C60
	for <cygwin-patches@cygwin.com>; Fri,  4 Nov 2022 12:53:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 84B873858C60
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-048.btinternet.com with ESMTP
          id <20221104125308.LCWX3226.sa-prd-fep-048.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>
          for <cygwin-patches@cygwin.com>; Fri, 4 Nov 2022 12:53:08 +0000
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 6139452E41C1989E
X-Originating-IP: [81.153.98.206]
X-OWM-Source-IP: 81.153.98.206 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvgedrvddugdegfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurheptgfkffggfgfuvfhfhfgjsehmtderredtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeelffdvveeihfdthfdthefftefghfeitdejhefhudfgvdevueehvdehgfdttedtvdenucffohhmrghinhepshhouhhrtggvfigrrhgvrdhorhhgnecukfhppeekuddrudehfedrleekrddvtdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdeingdpihhnvghtpeekuddrudehfedrleekrddvtdeipdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepuddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.106] (81.153.98.206) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as jonturney@btinternet.com)
        id 6139452E41C1989E for cygwin-patches@cygwin.com; Fri, 4 Nov 2022 12:53:08 +0000
Content-Type: multipart/mixed; boundary="------------FuNJ1aAoCE6BLkn6H1TWMQU4"
Message-ID: <4ccbb5e1-ee4f-8944-ed44-4af7fa79f048@dronecode.org.uk>
Date: Fri, 4 Nov 2022 12:53:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] Cygwin: Improve FAQ on early breakpoint for ASLR
Content-Language: en-GB
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20221103170430.4448-1-jon.turney@dronecode.org.uk>
 <alpine.BSO.2.21.2211031120540.30152@resin.csoft.net>
 <Y2TqvPTB7Hui2jmJ@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <Y2TqvPTB7Hui2jmJ@calimero.vinschen.de>
X-Spam-Status: No, score=-1196.6 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,KAM_LOTSOFHASH,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------FuNJ1aAoCE6BLkn6H1TWMQU4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/11/2022 10:34, Corinna Vinschen wrote:
> On Nov  3 11:22, Jeremy Drake via Cygwin-patches wrote:
>> On Thu, 3 Nov 2022, Jon Turney wrote:
>>
>>> gdb supports 'set disable-randomization off' on Windows since [1]
>>> (included in gdb 13).
>>>
>>> https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=bcb9251f029da8dcf360a4f5acfa3b4211c87bb0;hp=8fea1a81c7d9279a6f91e49ebacfb61e0f8ce008
>>
>> Is it really *disable*-randomization *off*?  The double-negative seems to
>> suggest that in that case ASLR would be left *on*.
> 
> Yeah, sounds weird....

Yes, this is just stupidity.  Revised patch attached.

--------------FuNJ1aAoCE6BLkn6H1TWMQU4
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-Improve-FAQ-on-early-breakpoint-for-ASLR.patch"
Content-Disposition: attachment;
 filename*0="0001-Cygwin-Improve-FAQ-on-early-breakpoint-for-ASLR.patch"
Content-Transfer-Encoding: base64

RnJvbSA5ZmZjZTBkNjEyNDkzM2NmMTZhZWUzYWQwMDZlMzI4NThmZTA3NTRhIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKb24gVHVybmV5IDxqb24udHVybmV5QGRyb25lY29k
ZS5vcmcudWs+CkRhdGU6IFR1ZSwgMSBOb3YgMjAyMiAxNjo1Mjo1NyArMDAwMApTdWJqZWN0
OiBbUEFUQ0hdIEN5Z3dpbjogSW1wcm92ZSBGQVEgb24gZWFybHkgYnJlYWtwb2ludCBmb3Ig
QVNMUgoKZ2RiIHN1cHBvcnRzIHRoZSAnZGlzYWJsZS1yYW5kb21pemF0aW9uJyBzZXR0aW5n
IG9uIFdpbmRvd3Mgc2luY2UgWzFdCihpbmNsdWRlZCBpbiBnZGIgMTMpLgoKaHR0cHM6Ly9z
b3VyY2V3YXJlLm9yZy9naXQvP3A9YmludXRpbHMtZ2RiLmdpdDthPWNvbW1pdGRpZmY7aD1i
Y2I5MjUxZjAyOWRhOGRjZjM2MGE0ZjVhY2ZhM2I0MjExYzg3YmIwO2hwPThmZWExYTgxYzdk
OTI3OWE2ZjkxZTQ5ZWJhY2ZiNjFlMGY4Y2UwMDgKLS0tCiB3aW5zdXAvZG9jL2ZhcS1wcm9n
cmFtbWluZy54bWwgfCA2ICsrKysrKwogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9kb2MvZmFxLXByb2dyYW1taW5nLnhtbCBiL3dpbnN1
cC9kb2MvZmFxLXByb2dyYW1taW5nLnhtbAppbmRleCA3OTQ1YjZiODguLjM2ZDBhNDAxZiAx
MDA2NDQKLS0tIGEvd2luc3VwL2RvYy9mYXEtcHJvZ3JhbW1pbmcueG1sCisrKyBiL3dpbnN1
cC9kb2MvZmFxLXByb2dyYW1taW5nLnhtbApAQCAtODQ0LDYgKzg0NCwxMiBAQCBHdWlkZSBo
ZXJlOiA8dWxpbmsgdXJsPSJodHRwczovL2N5Z3dpbi5jb20vY3lnd2luLXVnLW5ldC9kbGwu
aHRtbCIvPi4KICAgTm90ZSB0aGF0IHRoZSBEbGxNYWluIGVudHJ5cG9pbnRzIGZvciBsaW5r
ZWQgRExMcyB3aWxsIGhhdmUgYmVlbiBleGVjdXRlZAogICBiZWZvcmUgdGhpcyBicmVha3Bv
aW50IGlzIGhpdC4KIDwvcGFyYT4KKworPHBhcmE+CisgIChJdCBtYXkgYmUgbmVjZXNzYXJ5
IHRvIHVzZSB0aGUgPGNvbW1hbmQ+Z2RiPC9jb21tYW5kPiBjb21tYW5kIDxjb21tYW5kPnNl
dAorICBkaXNhYmxlLXJhbmRvbWl6YXRpb24gb248L2NvbW1hbmQ+IHRvIHR1cm4gb2ZmIEFT
TFIgZm9yIHRoZSBkZWJ1Z2VlIHRvCisgIHByZXZlbnQgdGhlIGJhc2UgYWRkcmVzcyBnZXR0
aW5nIHJhbmRvbWl6ZWQuKQorPC9wYXJhPgogPC9hbnN3ZXI+PC9xYW5kYWVudHJ5PgogCiA8
cWFuZGFlbnRyeSBpZD0iZmFxLnByb2dyYW1taW5nLmRlYnVnIj4KLS0gCjIuMzguMQoK

--------------FuNJ1aAoCE6BLkn6H1TWMQU4--
