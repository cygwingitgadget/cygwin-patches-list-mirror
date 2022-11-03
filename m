Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-042.btinternet.com (mailomta30-sa.btinternet.com [213.120.69.36])
	by sourceware.org (Postfix) with ESMTPS id 3FC103858C3A
	for <cygwin-patches@cygwin.com>; Thu,  3 Nov 2022 17:02:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 3FC103858C3A
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-042.btinternet.com with ESMTP
          id <20221103170231.NJOO3231.sa-prd-fep-042.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>
          for <cygwin-patches@cygwin.com>; Thu, 3 Nov 2022 17:02:31 +0000
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 6139429041A08072
X-Originating-IP: [81.153.98.206]
X-OWM-Source-IP: 81.153.98.206 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvgedrudelgdeludcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurheptgfkffggfgfuvfhfhfgjsehmtderredtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeehhfeigeeukedtgfefkeelgedvgeffvdejheevgfffgfduveejffelvedtffekfeenucfkphepkedurdduheefrdelkedrvddtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtiegnpdhinhgvthepkedurdduheefrdelkedrvddtiedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedupdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.106] (81.153.98.206) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as jonturney@btinternet.com)
        id 6139429041A08072 for cygwin-patches@cygwin.com; Thu, 3 Nov 2022 17:02:31 +0000
Content-Type: multipart/mixed; boundary="------------kw0zFpDsQdrLheythRdgBQO6"
Message-ID: <d82f87ff-6708-b3bb-60f4-7f77ea47fd66@dronecode.org.uk>
Date: Thu, 3 Nov 2022 17:02:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 3/3] Cygwin: Add loaded module base address list to
 stackdump
Content-Language: en-GB
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20221028150558.2300-1-jon.turney@dronecode.org.uk>
 <20221028150558.2300-4-jon.turney@dronecode.org.uk>
 <Y1zlNBjeblW9dvfW@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
In-Reply-To: <Y1zlNBjeblW9dvfW@calimero.vinschen.de>
X-Spam-Status: No, score=-1196.7 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------kw0zFpDsQdrLheythRdgBQO6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/10/2022 09:32, Corinna Vinschen wrote:
> On Oct 28 16:05, Jon Turney wrote:
>> This adds an extra section to the stackdump, which lists the loaded
>> modules and their base address.  This is perhaps useful as it makes it
>> immediately clear if RandomCrashInjectedDll.dll is loaded...
>>
>> XXX: It seems like the 'InMemoryOrder' part of 'InMemoryOrderModuleList' is a lie?
> 
> Probably just an alternative fact...

Yeah.  I did stared a bit at the code wondering if the structure layouts 
were incorrect so we were somehow traversing one of the other module 
lists with a different ordering, but everything looks correct.

The attached might be a good idea, then, to ensure that module+offset is 
calculated correctly.

--------------kw0zFpDsQdrLheythRdgBQO6
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-Handle-out-of-order-modules-for-module-offset.patch"
Content-Disposition: attachment;
 filename*0="0001-Cygwin-Handle-out-of-order-modules-for-module-offset.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBlYTQ3ODI2MDQ3ZThiYjE3NWIxYjBlMDI4NmQ3ZDdiOGNmMTVjN2ZlIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKb24gVHVybmV5IDxqb24udHVybmV5QGRyb25lY29k
ZS5vcmcudWs+CkRhdGU6IFR1ZSwgMSBOb3YgMjAyMiAxNDowMTowOCArMDAwMApTdWJqZWN0
OiBbUEFUQ0hdIEN5Z3dpbjogSGFuZGxlIG91dCBvZiBvcmRlciBtb2R1bGVzIGZvciBtb2R1
bGUgb2Zmc2V0cyBpbgogc3RhY2tkdW1wCgpJbXByb3ZlIGFkZHJlc3MgdG8gbW9kdWxlK29m
ZnNldCBjb252ZXJzaW9uLCB0byB3b3JrIGNvcnJlY3RseSBpbiB0aGUKcHJlc2VuY2Ugb2Yg
b3V0LW9mLW9yZGVyIGVsZW1lbnRzIGluIEluTWVtb3J5T3JkZXJNb2R1bGVMaXN0LgoKRml4
ZXM6IGQ1OTY1MWQ0Ci0tLQogd2luc3VwL2N5Z3dpbi9leGNlcHRpb25zLmNjIHwgNCArKyst
CiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZm
IC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9leGNlcHRpb25zLmNjIGIvd2luc3VwL2N5Z3dpbi9l
eGNlcHRpb25zLmNjCmluZGV4IDhjYzQ1NGM5MC4uYzM0MzNhYjk0IDEwMDY0NAotLS0gYS93
aW5zdXAvY3lnd2luL2V4Y2VwdGlvbnMuY2MKKysrIGIvd2luc3VwL2N5Z3dpbi9leGNlcHRp
b25zLmNjCkBAIC0zNDIsMTEgKzM0MiwxMyBAQCBwcmV0dHlwcmludF92YSAoUFZPSUQgZnVu
Y192YSkKICAgICB7CiAgICAgICBQTERSX0RBVEFfVEFCTEVfRU5UUlkgbW9kID0gQ09OVEFJ
TklOR19SRUNPUkQgKHgsIExEUl9EQVRBX1RBQkxFX0VOVFJZLAogCQkJCQkJICAgICBJbk1l
bW9yeU9yZGVyTGlua3MpOwotICAgICAgaWYgKG1vZC0+RGxsQmFzZSA+IGZ1bmNfdmEpCisg
ICAgICBpZiAoKGZ1bmNfdmEgPCBtb2QtPkRsbEJhc2UpIHx8CisJICAoZnVuY192YSA+IChQ
Vk9JRCkoKERXT1JEX1BUUiltb2QtPkRsbEJhc2UgKyBtb2QtPlNpemVPZkltYWdlKSkpCiAJ
Y29udGludWU7CiAKICAgICAgIF9fc21hbGxfc3ByaW50ZiAoYnVmLCAiJVMrMHgleCIsICZt
b2QtPkJhc2VEbGxOYW1lLAogCQkgICAgICAgKERXT1JEX1BUUilmdW5jX3ZhIC0gKERXT1JE
X1BUUiltb2QtPkRsbEJhc2UpOworICAgICAgYnJlYWs7CiAgICAgfQogCiAgIHJldHVybiBi
dWY7Ci0tIAoyLjM4LjEKCg==

--------------kw0zFpDsQdrLheythRdgBQO6--
