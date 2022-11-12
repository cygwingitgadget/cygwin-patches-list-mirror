Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-049.btinternet.com (mailomta6-sa.btinternet.com [213.120.69.12])
	by sourceware.org (Postfix) with ESMTPS id D89893858C1F
	for <cygwin-patches@cygwin.com>; Sat, 12 Nov 2022 14:31:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org D89893858C1F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-049.btinternet.com with ESMTP
          id <20221112143100.IJEC3227.sa-prd-fep-049.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>
          for <cygwin-patches@cygwin.com>; Sat, 12 Nov 2022 14:31:00 +0000
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 61394290430E000D
X-Originating-IP: [81.153.98.246]
X-OWM-Source-IP: 81.153.98.246 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvgedrfeekgdeiiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurheptgfkffggfgfufhfhvfgjsehmtderredtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeelvdevveelkeetffevleektdfgteejkedukeejveffhfehvdfhheetgfffhfevgfenucfkphepkedurdduheefrdelkedrvdegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtiegnpdhinhgvthepkedurdduheefrdelkedrvdegiedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedupdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.106] (81.153.98.246) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as jonturney@btinternet.com)
        id 61394290430E000D for cygwin-patches@cygwin.com; Sat, 12 Nov 2022 14:31:00 +0000
Content-Type: multipart/mixed; boundary="------------2aessfp3w0dQf0faDlyv8rsP"
Message-ID: <a2e01953-f6ef-cf08-f6e1-0c7632391ede@dronecode.org.uk>
Date: Sat, 12 Nov 2022 14:30:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] Cygwin: Improve FAQ on early breakpoint for ASLR
References: <20221103170430.4448-1-jon.turney@dronecode.org.uk>
 <alpine.BSO.2.21.2211031120540.30152@resin.csoft.net>
 <Y2TqvPTB7Hui2jmJ@calimero.vinschen.de>
 <4ccbb5e1-ee4f-8944-ed44-4af7fa79f048@dronecode.org.uk>
 <f2942e0e-ea5e-7ba9-8770-b422628dafad@gmail.com>
Content-Language: en-GB
From: Jon Turney <jon.turney@dronecode.org.uk>
To: Cygwin Patches <cygwin-patches@cygwin.com>
In-Reply-To: <f2942e0e-ea5e-7ba9-8770-b422628dafad@gmail.com>
X-Spam-Status: No, score=-1198.4 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------2aessfp3w0dQf0faDlyv8rsP
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/11/2022 15:29, Pedro Alves wrote:
> On 2022-11-04 12:53 p.m., Jon Turney wrote:
>> +<para>
>> +  (It may be necessary to use the <command>gdb</command> command <command>set
>> +  disable-randomization on</command> to turn off ASLR for the debugee to
>> +  prevent the base address getting randomized.)
>> +</para>
>>   </answer></qandaentry>
>>   
> 
> Typo: debugee -> debuggee

Thanks for catching that.

Patch attached.

> Note that "on" is the default.

True.  But the API used by gdb to turn off ASLR isn't supported by some 
versions of Windows.

This sentence could be a lot more explicit about all the details here, 
but I'm just trying to be brief.

--------------2aessfp3w0dQf0faDlyv8rsP
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-Fix-typo-in-FAQ.patch"
Content-Disposition: attachment; filename="0001-Cygwin-Fix-typo-in-FAQ.patch"
Content-Transfer-Encoding: base64

RnJvbSBiZTI0YzliNjllNzI2NDg2OTBhNDc3ZmQyZjE1YjBhOWM2Mzc0NzEzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKb24gVHVybmV5IDxqb24udHVybmV5QGRyb25lY29k
ZS5vcmcudWs+CkRhdGU6IFNhdCwgMTIgTm92IDIwMjIgMTQ6MTY6MzYgKzAwMDAKU3ViamVj
dDogW1BBVENIXSBDeWd3aW46IEZpeCB0eXBvIGluIEZBUQoKVGhlIGNvbnNvbmFudCBpbiAn
ZGVidWcnIGlzIGRvdWJsZWQgaW4gJ2RlYnVnZ2VlJyBqdXN0IGFzIGl0IGlzIGluCidkZWJ1
Z2dlcicuCgpGaXhlczogOGM2OGE4YTQKLS0tCiB3aW5zdXAvZG9jL2ZhcS1wcm9ncmFtbWlu
Zy54bWwgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvZG9jL2ZhcS1wcm9ncmFtbWluZy54bWwgYi93
aW5zdXAvZG9jL2ZhcS1wcm9ncmFtbWluZy54bWwKaW5kZXggMzZkMGE0MDFmLi44OWMzMDlh
ZjIgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9kb2MvZmFxLXByb2dyYW1taW5nLnhtbAorKysgYi93
aW5zdXAvZG9jL2ZhcS1wcm9ncmFtbWluZy54bWwKQEAgLTg0Nyw3ICs4NDcsNyBAQCBHdWlk
ZSBoZXJlOiA8dWxpbmsgdXJsPSJodHRwczovL2N5Z3dpbi5jb20vY3lnd2luLXVnLW5ldC9k
bGwuaHRtbCIvPi4KIAogPHBhcmE+CiAgIChJdCBtYXkgYmUgbmVjZXNzYXJ5IHRvIHVzZSB0
aGUgPGNvbW1hbmQ+Z2RiPC9jb21tYW5kPiBjb21tYW5kIDxjb21tYW5kPnNldAotICBkaXNh
YmxlLXJhbmRvbWl6YXRpb24gb248L2NvbW1hbmQ+IHRvIHR1cm4gb2ZmIEFTTFIgZm9yIHRo
ZSBkZWJ1Z2VlIHRvCisgIGRpc2FibGUtcmFuZG9taXphdGlvbiBvbjwvY29tbWFuZD4gdG8g
dHVybiBvZmYgQVNMUiBmb3IgdGhlIGRlYnVnZ2VlIHRvCiAgIHByZXZlbnQgdGhlIGJhc2Ug
YWRkcmVzcyBnZXR0aW5nIHJhbmRvbWl6ZWQuKQogPC9wYXJhPgogPC9hbnN3ZXI+PC9xYW5k
YWVudHJ5PgotLSAKMi4zOC4xCgo=

--------------2aessfp3w0dQf0faDlyv8rsP--
