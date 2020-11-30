Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-046.btinternet.com (mailomta6-sa.btinternet.com
 [213.120.69.12])
 by sourceware.org (Postfix) with ESMTPS id 7587E3857811
 for <cygwin-patches@cygwin.com>; Mon, 30 Nov 2020 17:02:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 7587E3857811
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
 by sa-prd-fep-046.btinternet.com with ESMTP id
 <20201130170215.IXGU28150.sa-prd-fep-046.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Mon, 30 Nov 2020 17:02:15 +0000
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9B8A71CCD724A
X-Originating-IP: [86.139.158.14]
X-OWM-Source-IP: 86.139.158.14 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrudeitddgleehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgesmhdtreertdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepudetfeevffeuleegiefhhffggeeujeekuefgiedtheekleekteelvddvteevgeeunecukfhppeekiedrudefledrudehkedrudegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurdduuddungdpihhnvghtpeekiedrudefledrudehkedrudegpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (86.139.158.14) by
 sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9B8A71CCD724A for cygwin-patches@cygwin.com;
 Mon, 30 Nov 2020 17:02:15 +0000
Subject: Re: [PATCH] Use automake (v3)
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20201124133720.45823-1-jon.turney@dronecode.org.uk>
 <20201130102524.GC303847@calimero.vinschen.de>
 <20201130104718.GD303847@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <6fa43a94-c29d-fa48-07d0-1ef095d9f5e3@dronecode.org.uk>
Date: Mon, 30 Nov 2020 17:02:14 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201130104718.GD303847@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------41F45A2FB270006D24B7DDC1"
Content-Language: en-GB
X-Spam-Status: No, score=-1200.6 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Mon, 30 Nov 2020 17:02:18 -0000

This is a multi-part message in MIME format.
--------------41F45A2FB270006D24B7DDC1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/11/2020 10:47, Corinna Vinschen wrote:
> On Nov 30 11:25, Corinna Vinschen wrote:
> 
> Also, after applying the patch and autogen-ing, a full build from
> top-level fails with some warnings and a final undefined symbol:

The warnings are expected at this stage.

> make[5]: Entering directory '[...]/x86_64-pc-cygwin/winsup/utils/mingw'
>    CXX      ../bloda.o
>    CXX      ../cygcheck.o
>    CXX      ../dump_setup.o
>    CXX      ../ldh.o
>    CXX      ../path.o
>    CXX      ../cygwin-console-helper.o
>    CXX      ../path_testsuite-path.o
>    CXX      ../strace.o
>    CXX      ../path_testsuite-testsuite.o
> [...]/winsup/utils/mingw/../testsuite.cc:18: warning: "TESTSUITE" redefined
>     18 | #define TESTSUITE

This redefinition should probably be inside #ifndef TESTSUITE/#endif

> <command-line>: note: this is the location of the previous definition
>    CXXLD    cygwin-console-helper.exe
>    CXXLD    ldh.exe
> In file included from [...]/winsup/utils/mingw/../path.cc:263:
> [...]/winsup/utils/mingw/../testsuite.h:22:24: warning: ISO C++ forbids converting a string constant to 'char*' [-Wwrite-strings]
>     22 | #define TESTSUITE_ROOT "X:\\xyzroot"

I'm not sure how to restructure things to avoid this warning.

The '-Wno-error=write-strings' flag is added when building this test to 
avoid this being fatal.

>    CXXLD    path-testsuite.exe
> /usr/lib/gcc/x86_64-w64-mingw32/9.2.1/../../../../x86_64-w64-mingw32/bin/ld: ../path_testsuite-path.o:path.cc:(.rdata$.refptr.max_mount_entry[.refptr.max_mount_entry]+0x0): undefined reference to `max_mount_entry'

This is a bit puzzling.  I don't get this when building locally, but idk 
why since there is only a tentative definition of this variable.

I'm not sure how this being built is changed by automaking to stop it 
working for you (perhaps optimization flags are now being used?)

Perhaps the attached helps, although what is getting stubbed out when 
testing could be clearer.


--------------41F45A2FB270006D24B7DDC1
Content-Type: text/plain; charset=UTF-8;
 name="0001-Fix-building-of-utils-testsuite.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Fix-building-of-utils-testsuite.patch"

RnJvbSBkZGY4YzBjMDU5ZGQ2NjZmNDEzOGE1YjBiMTIzNzEzYWYxYWYzYWIxIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKb24gVHVybmV5IDxqb24udHVybmV5QGRyb25lY29k
ZS5vcmcudWs+CkRhdGU6IE1vbiwgMzAgTm92IDIwMjAgMTY6NTg6MDIgKzAwMDAKU3ViamVj
dDogW1BBVENIXSBGaXggYnVpbGRpbmcgb2YgdXRpbHMgdGVzdHN1aXRlCgotLS0KIHdpbnN1
cC91dGlscy9wYXRoLmNjIHwgNCArKysrCiB3aW5zdXAvdXRpbHMvcGF0aC5oICB8IDIgKy0K
IDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZm
IC0tZ2l0IGEvd2luc3VwL3V0aWxzL3BhdGguY2MgYi93aW5zdXAvdXRpbHMvcGF0aC5jYwpp
bmRleCBkOGMyMDgxMjMuLjRjMWJiNDAyOSAxMDA2NDQKLS0tIGEvd2luc3VwL3V0aWxzL3Bh
dGguY2MKKysrIGIvd2luc3VwL3V0aWxzL3BhdGguY2MKQEAgLTgyNCw4ICs4MjQsMTAgQEAg
dmN5Z3BhdGggKGNvbnN0IGNoYXIgKmN3ZCwgY29uc3QgY2hhciAqcywgdmFfbGlzdCB2KQog
ICBzaXplX3QgbWF4X2xlbiA9IDA7CiAgIG1udF90ICptLCAqbWF0Y2ggPSBOVUxMOwogCisj
aWZuZGVmIFRFU1RTVUlURQogICBpZiAoIW1heF9tb3VudF9lbnRyeSkKICAgICByZWFkX21v
dW50cyAoKTsKKyNlbmRpZgogICBjaGFyICpwYXRoOwogICBpZiAoc1swXSA9PSAnLicgJiYg
aXNzbGFzaCAoc1sxXSkpCiAgICAgcyArPSAyOwpAQCAtOTEyLDggKzkxNCwxMCBAQCBleHRl
cm4gIkMiIEZJTEUgKgogc2V0bW50ZW50IChjb25zdCBjaGFyICosIGNvbnN0IGNoYXIgKikK
IHsKICAgbSA9IG1vdW50X3RhYmxlOworI2lmbmRlZiBURVNUU1VJVEUKICAgaWYgKCFtYXhf
bW91bnRfZW50cnkpCiAgICAgcmVhZF9tb3VudHMgKCk7CisjZW5kaWYKICAgcmV0dXJuIE5V
TEw7CiB9CiAKZGlmZiAtLWdpdCBhL3dpbnN1cC91dGlscy9wYXRoLmggYi93aW5zdXAvdXRp
bHMvcGF0aC5oCmluZGV4IGFmNWRlZWJhNi4uYTE4NDBhMDAzIDEwMDY0NAotLS0gYS93aW5z
dXAvdXRpbHMvcGF0aC5oCisrKyBiL3dpbnN1cC91dGlscy9wYXRoLmgKQEAgLTI0LDggKzI0
LDggQEAgYm9vbCBmcm9tX2ZzdGFiX2xpbmUgKG1udF90ICptLCBjaGFyICpsaW5lLCBib29s
IHVzZXIpOwogCiAjaWZuZGVmIFRFU1RTVUlURQogZXh0ZXJuIG1udF90IG1vdW50X3RhYmxl
WzI1NV07Ci0jZW5kaWYKIGV4dGVybiBpbnQgbWF4X21vdW50X2VudHJ5OworI2VuZGlmCiAK
ICNpZm5kZWYgU1lNTElOS19NQVgKICNkZWZpbmUgU1lNTElOS19NQVggNDA5NSAgLyogUEFU
SF9NQVggLSAxICovCi0tIAoyLjI5LjIKCg==
--------------41F45A2FB270006D24B7DDC1--
