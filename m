Return-Path: <SRS0=PxbH=DD=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-043.btinternet.com (mailomta28-sa.btinternet.com [213.120.69.34])
	by sourceware.org (Postfix) with ESMTPS id C31F93858423
	for <cygwin-patches@cygwin.com>; Mon, 17 Jul 2023 11:51:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C31F93858423
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
          by sa-prd-fep-043.btinternet.com with ESMTP
          id <20230717115138.HRMD1396.sa-prd-fep-043.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>
          for <cygwin-patches@cygwin.com>; Mon, 17 Jul 2023 12:51:38 +0100
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 64AECEEE007B452E
X-Originating-IP: [81.129.146.179]
X-OWM-Source-IP: 81.129.146.179 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrgedvgdeghecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurheptgfkffggfgfuhffvfhgjsehmtderredtfeejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeffuedvgfeggefflefhtdefffdvgfetffefjeelgefggfejtdekgeehhefhteeggeenucfkphepkedurdduvdelrddugeeirddujeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdeingdpihhnvghtpeekuddruddvledrudegiedrudejledpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedupdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgvvhfkrfephhhoshhtkeduqdduvdelqddugeeiqddujeelrdhrrghnghgvkeduqdduvdelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpehsrgdqphhr
	ugdqrhhgohhuthdqtddtvd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.106] (81.129.146.179) by sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 64AECEEE007B452E for cygwin-patches@cygwin.com; Mon, 17 Jul 2023 12:51:38 +0100
Content-Type: multipart/mixed; boundary="------------lfbAVAtZ2AEND9LCKLpe2BnU"
Message-ID: <8a504ebe-9ce0-867a-f1a3-f38411129019@dronecode.org.uk>
Date: Mon, 17 Jul 2023 12:51:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 08/11] Cygwin: testsuite: Busy-wait in cancel3 and cancel5
From: Jon Turney <jon.turney@dronecode.org.uk>
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
 <20230713113904.1752-9-jon.turney@dronecode.org.uk>
 <ZLA/j6L/tPcqHiG7@calimero.vinschen.de>
 <ZLBEajmAonZGmsqx@calimero.vinschen.de>
 <ZLBIJTlbCtRvYlU9@calimero.vinschen.de>
 <5aa21952-a13d-f304-8b63-18ee4885c308@dronecode.org.uk>
Content-Language: en-GB
In-Reply-To: <5aa21952-a13d-f304-8b63-18ee4885c308@dronecode.org.uk>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,KAM_NUMSUBJECT,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------lfbAVAtZ2AEND9LCKLpe2BnU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/07/2023 14:04, Jon Turney wrote:
> On 13/07/2023 19:53, Corinna Vinschen wrote:
>>>>> normally after 10 seconds. (See the commentary in pthread::cancel() in
>>>>> thread.cc, where it checks if the target thread is inside the kernel,
>>>>> and silently converts the cancellation into a deferred one)
>>>>
>>>> Nevertheless, I think this is ok to do.  The description of 
>>>> pthread_cancel
>>>> contains this:
>>>>
>>>>    Asynchronous cancelability means that the thread can be canceled at
>>>>    any time (usually immediately, but the system does not guarantee 
>>>> this).
>>>>
>>>> And
>>>>
>>>>    The above steps happen asynchronously with respect to the
>>>>    pthread_cancel() call; the return status of pthread_cancel() merely
>>>>    informs the caller whether the cancellation request was successfully
>>>>    queued.
>>>>
>>>> So any assumption *when* the cancallation takes place is may be wrong.
> 
> Yeah.
> 
> I think the flakiness is when we happen to try to async cancel while in 
> the Windows kernel, which implicitly converts to a deferred 
> cancellation, but there are no cancellation points in the the thread, so 
> it arrives at pthread_exit() and returns a exit code other than 
> PTHREAD_CANCELED.
> 
> I did consider making the test non-flaky by adding a final call to 
> pthread_testcancel(), to notice any failed async cancellation which has 
> been converted to a deferred one.
> 
> But then that is just the same as the deferred cancellation tests, and 
> confirms the cancellation happens, but not that it's async, which is 
> part of the point of the test.
> 
> I guess this could also check that not all of the threads ran for all 10 
> seconds, which would indicate that at least some of them were cancelled 
> asynchronously.

I wrote this, attached, which does indeed make this test more reliable.

You point is well made that this is making assumptions about how quickly 
async cancellation works that are not required by the standard

(It would be a valid, if strange implementation, if async cancellation 
always took 10 seconds to take effect, which this test assumes isn't the 
case)

Perhaps there is a better way to write a test that async cancellation 
works in the absence of cancellation points, but it eludes me...

--------------lfbAVAtZ2AEND9LCKLpe2BnU
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-testsuite-Make-cancel3-and-cancel5-more-robus.patch"
Content-Disposition: attachment;
 filename*0="0001-Cygwin-testsuite-Make-cancel3-and-cancel5-more-robus.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBkMDAyM2ZhM2VhMWU4ZjI5ZTgwZDQ3M2FiMTNkODIwMGJkZDJkYzNhIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKb24gVHVybmV5IDxqb24udHVybmV5QGRyb25lY29k
ZS5vcmcudWs+CkRhdGU6IFNhdCwgMTUgSnVsIDIwMjMgMTc6NTc6NDMgKzAxMDAKU3ViamVj
dDogW1BBVENIXSBDeWd3aW46IHRlc3RzdWl0ZTogTWFrZSBjYW5jZWwzIGFuZCBjYW5jZWw1
IG1vcmUgcm9idXN0CgpEZXNwaXRlIG91ciBlZmZvcnRzLCBzb21ldGltZXMgdGhlIGFzeW5j
IGNhbmNlbGxhdGlvbiBnZXRzIGRlZmVycmVkLgoKTm90aWNlIHRoaXMgYnkgY2FsbGluZyBw
dGhyZWFkX3Rlc3RjYW5jZWwoKSwgYW5kIHRoZW4gdHJ5IHRvIHdvcmsgb3V0IGlmCmFzeW5j
IGNhbmNlbGxhdGlvbiB3YXMgZXZlciBzdWNjZXNzZnVsIGJ5IGNoZWNraW5nIGlmIGFsbCB0
aHJlYWRzIHJhbgpmb3IgdGhlIGZ1bGwgMTAgc2Vjb25kcywgb3IgaWYgc29tZSB3ZXJlIHN0
b3BwZWQgZWFybHkuCi0tLQogd2luc3VwL3Rlc3RzdWl0ZS93aW5zdXAuYXBpL3B0aHJlYWQv
Y2FuY2VsMy5jIHwgMTYgKysrKysrKysrKysrKysrLQogd2luc3VwL3Rlc3RzdWl0ZS93aW5z
dXAuYXBpL3B0aHJlYWQvY2FuY2VsNS5jIHwgMTQgKysrKysrKysrKysrKysKIDIgZmlsZXMg
Y2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L3dpbnN1cC90ZXN0c3VpdGUvd2luc3VwLmFwaS9wdGhyZWFkL2NhbmNlbDMuYyBiL3dpbnN1
cC90ZXN0c3VpdGUvd2luc3VwLmFwaS9wdGhyZWFkL2NhbmNlbDMuYwppbmRleCAwN2ZlYjdj
OWIuLjA3NWYwNTJjYyAxMDA2NDQKLS0tIGEvd2luc3VwL3Rlc3RzdWl0ZS93aW5zdXAuYXBp
L3B0aHJlYWQvY2FuY2VsMy5jCisrKyBiL3dpbnN1cC90ZXN0c3VpdGUvd2luc3VwLmFwaS9w
dGhyZWFkL2NhbmNlbDMuYwpAQCAtOTIsNiArOTIsOSBAQCBteXRocmVhZCh2b2lkICogYXJn
KQogCX0KICAgICB9CiAKKyAgLyogTm90aWNlIGlmIGFzeW5jaHJvbm91cyBjYW5jZWwgZ290
IGRlZmVycmVkICovCisgIHB0aHJlYWRfdGVzdGNhbmNlbCgpOworCiAgIHJldHVybiByZXN1
bHQ7CiB9CiAKQEAgLTEwMSw2ICsxMDQsNyBAQCBtYWluKCkKICAgaW50IGZhaWxlZCA9IDA7
CiAgIGludCBpOwogICBwdGhyZWFkX3QgdFtOVU1USFJFQURTICsgMV07CisgIGludCByYW5f
dG9fY29tcGxldGlvbiA9IDA7CiAKICAgYXNzZXJ0KCh0WzBdID0gcHRocmVhZF9zZWxmKCkp
ICE9IE5VTEwpOwogCkBAIC0xMzAsNyArMTM0LDcgQEAgbWFpbigpCiAgICAqIFN0YW5kYXJk
IGNoZWNrIHRoYXQgYWxsIHRocmVhZHMgc3RhcnRlZC4KICAgICovCiAgIGZvciAoaSA9IDE7
IGkgPD0gTlVNVEhSRUFEUzsgaSsrKQotICAgIHsgCisgICAgewogICAgICAgaWYgKCF0aHJl
YWRiYWdbaV0uc3RhcnRlZCkKIAl7CiAJICBmYWlsZWQgfD0gIXRocmVhZGJhZ1tpXS5zdGFy
dGVkOwpAQCAtMTY2LDkgKzE3MCwxOSBAQCBtYWluKCkKIAkJICB0aHJlYWRiYWdbaV0uY291
bnQsCiAJCSAgcmVzdWx0KTsKIAl9CisKKyAgICAgIGlmICh0aHJlYWRiYWdbaV0uY291bnQg
Pj0gMTApCisJcmFuX3RvX2NvbXBsZXRpb24rKzsKKwogICAgICAgZmFpbGVkID0gKGZhaWxl
ZCB8fCBmYWlsKTsKICAgICB9CiAKKyAgaWYgKHJhbl90b19jb21wbGV0aW9uID49IDEwKQor
ICAgIHsKKyAgICAgIGZwcmludGYoc3RkZXJyLCAiQWxsIHRocmVhZHMgcmFuIHRvIGNvbXBs
ZXRpb24sIGFzeW5jIGNhbmNlbGxhdGlvbiBuZXZlciBoYXBwZW5lZFxuIik7CisgICAgICBm
YWlsZWQgPSBUUlVFOworICAgIH0KKwogICBhc3NlcnQoIWZhaWxlZCk7CiAKICAgLyoKZGlm
ZiAtLWdpdCBhL3dpbnN1cC90ZXN0c3VpdGUvd2luc3VwLmFwaS9wdGhyZWFkL2NhbmNlbDUu
YyBiL3dpbnN1cC90ZXN0c3VpdGUvd2luc3VwLmFwaS9wdGhyZWFkL2NhbmNlbDUuYwppbmRl
eCA5OTliM2M5NWMuLjIzYzAyYWZlNCAxMDA2NDQKLS0tIGEvd2luc3VwL3Rlc3RzdWl0ZS93
aW5zdXAuYXBpL3B0aHJlYWQvY2FuY2VsNS5jCisrKyBiL3dpbnN1cC90ZXN0c3VpdGUvd2lu
c3VwLmFwaS9wdGhyZWFkL2NhbmNlbDUuYwpAQCAtOTMsNiArOTMsOSBAQCBteXRocmVhZCh2
b2lkICogYXJnKQogCX0NCiAgICAgfQ0KIA0KKyAgLyogTm90aWNlIGlmIGFzeW5jaHJvbm91
cyBjYW5jZWwgZ290IGRlZmVycmVkICovDQorICBwdGhyZWFkX3Rlc3RjYW5jZWwoKTsNCisN
CiAgIHJldHVybiByZXN1bHQ7DQogfQ0KIA0KQEAgLTEwMiw2ICsxMDUsNyBAQCBtYWluKCkK
ICAgaW50IGZhaWxlZCA9IDA7DQogICBpbnQgaTsNCiAgIHB0aHJlYWRfdCB0W05VTVRIUkVB
RFMgKyAxXTsNCisgIGludCByYW5fdG9fY29tcGxldGlvbiA9IDA7DQogDQogICBmb3IgKGkg
PSAxOyBpIDw9IE5VTVRIUkVBRFM7IGkrKykNCiAgICAgew0KQEAgLTE2NSw5ICsxNjksMTkg
QEAgbWFpbigpCiAJCSAgdGhyZWFkYmFnW2ldLmNvdW50LA0KIAkJICByZXN1bHQpOw0KIAl9
DQorDQorICAgICAgaWYgKHRocmVhZGJhZ1tpXS5jb3VudCA+PSAxMCkNCisgICAgICAgcmFu
X3RvX2NvbXBsZXRpb24rKzsNCisNCiAgICAgICBmYWlsZWQgPSAoZmFpbGVkIHx8IGZhaWwp
Ow0KICAgICB9DQogDQorICBpZiAocmFuX3RvX2NvbXBsZXRpb24gPj0gMTApDQorICAgIHsN
CisgICAgICBmcHJpbnRmKHN0ZGVyciwgIkFsbCB0aHJlYWRzIHJhbiB0byBjb21wbGV0aW9u
LCBhc3luYyBjYW5jZWxsYXRpb24gbmV2ZXIgaGFwcGVuZWRcbiIpOw0KKyAgICAgIGZhaWxl
ZCA9IFRSVUU7DQorICAgIH0NCisNCiAgIGFzc2VydCghZmFpbGVkKTsNCiANCiAgIC8qDQot
LSAKMi4zOS4wCgo=

--------------lfbAVAtZ2AEND9LCKLpe2BnU--
