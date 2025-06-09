Return-Path: <SRS0=tlHB=YY=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo006.btinternet.com (btprdrgo006.btinternet.com [65.20.50.80])
	by sourceware.org (Postfix) with ESMTP id D004A3858D38
	for <cygwin-patches@cygwin.com>; Mon,  9 Jun 2025 23:04:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D004A3858D38
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D004A3858D38
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.80
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1749510275; cv=none;
	b=I4vhJYt7YOvAnBMwoLINSzk/wak6jN2cGy1FQbbqfPJBKIbaVsaJ9sZvYU0GfYUiNA5H6MAQK9rCVGVykx1iLzED2lC7Gbr77UgVYzAQ7DkWGlJoXfRblXvsnfsCV47frG2VgsmolN/l75HFysP0Ys208W2yzUDeHw8GbWJ1whU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1749510275; c=relaxed/simple;
	bh=tvQt+0fySiwVwioFzX51mmsjKaAcU1mqdYpcyTI0ft4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=w7xoYbUL4A7KavHKrGiJenFTAm297F1TFQJvWyZuy0iBnshgAncSZJ/jlJ/SOFHIcmlN+DDcX/0uO1VAtXnvX5119GcBdkKIr+4BElX94VxdEg7wawC1qeTVtMdkit33MBzo0Diqf6R4hpVUeCAMxJFGtGOuFnfOZBbJd3S1JBQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D004A3858D38
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89D1C0940CE19
X-Originating-IP: [86.144.161.4]
X-OWM-Source-IP: 86.144.161.4
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdelleefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurheptgfkffggfgfuvfhfhfevjgesmhdtreertddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepkeetudetvedugfehgeeuheevudekueeuffehjeffieevfeegieefffekvdetgfdunecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepkeeirddugeegrdduiedurdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudeggedrudeiuddrgedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudeggedqudeiuddqgedrrhgrnhhgvgekiedqudeggedrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtiedpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgt
	ohhmpdhrtghpthhtoheptgihghifihhnsehjughrrghkvgdrtghomh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.144.161.4) by btprdrgo006.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89D1C0940CE19; Tue, 10 Jun 2025 00:04:32 +0100
Content-Type: multipart/mixed; boundary="------------fDcjuIE16ci43nQG73hqOQ0R"
Message-ID: <05bf71ad-5238-4f86-8b2d-21e16e4bf071@dronecode.org.uk>
Date: Tue, 10 Jun 2025 00:04:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix compatibility with MinGW v13 headers
To: Jeremy Drake <cygwin@jdrake.com>
References: <DB9PR83MB09238924363B70583AA08BA5926BA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <7178d417-9d6b-14b2-95cb-b5c4fb53b463@jdrake.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <7178d417-9d6b-14b2-95cb-b5c4fb53b463@jdrake.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------fDcjuIE16ci43nQG73hqOQ0R
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/06/2025 19:54, Jeremy Drake via Cygwin-patches wrote:
> On Mon, 9 Jun 2025, Radek Barton via Cygwin-patches wrote:
> 
>> Hello
>>
>> Since today, https://github.com/cygwin/cygwin/actions/runs/15537033468 workflow started to fail as it seems that `cygwin/cygwin-install-action@master` action started to use newer MinGW headers.
>>
>> The attached patch fixes compatibility with v13 MinGW headers while preserving compatibility with v12.
>>
>> Radek
> 
> The change to cygwin/socket.h concerns me, that is a public header, and
> you can't assume they are including MinGW headers, and if they are how
> they are configuring them (ie, _WIN32_WINNT define) or which ones they
> are including.  It looks like the mingw-w64 header #defines cmsghdr, maybe

Yeah.

That requires a different solution.

> an #ifndef cmsghdr with a comment about this situation?  Or how do other
> Cygwin headers handle potential conflicts with Windows headers?
I think something like the attached to avoid seeing the conflicting 
definitions? (unpleasant, but perhaps necessary)

--------------fDcjuIE16ci43nQG73hqOQ0R
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-Fix-compatibility-with-w32api-v13-headers.patch"
Content-Disposition: attachment;
 filename*0="0001-Cygwin-Fix-compatibility-with-w32api-v13-headers.patch"
Content-Transfer-Encoding: base64

RnJvbSBmMjRkZGI1MTA0ZjY0OTZlMDZmOGU5ZmFmMmE2YzkxZTczMjliMjJjIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89
IDxyYWRlay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogTW9uLCA5IEp1biAyMDI1IDE4
OjE0OjE0ICswMjAwClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBGaXggY29tcGF0aWJpbGl0
eSB3aXRoIHczMmFwaSB2MTMgaGVhZGVycwoKLS0tCiB3aW5zdXAvY3lnd2luL2ZoYW5kbGVy
L3NvY2tldF9pbmV0LmNjICB8IDUgKysrKysKIHdpbnN1cC9jeWd3aW4vZmhhbmRsZXIvc29j
a2V0X2xvY2FsLmNjIHwgNSArKysrKwogd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9u
dGRsbC5oICAgfCA0ICsrKysKIHdpbnN1cC9jeWd3aW4vbmV0LmNjICAgICAgICAgICAgICAg
ICAgIHwgNSArKysrKwogNCBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9maGFuZGxlci9zb2NrZXRfaW5ldC5jYyBiL3dpbnN1
cC9jeWd3aW4vZmhhbmRsZXIvc29ja2V0X2luZXQuY2MKaW5kZXggMjJkZmVkNjNkLi41ZWQw
Y2IwZWMgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXIvc29ja2V0X2luZXQu
Y2MKKysrIGIvd2luc3VwL2N5Z3dpbi9maGFuZGxlci9zb2NrZXRfaW5ldC5jYwpAQCAtMjAs
NyArMjAsMTIgQEAKICN1bmRlZiB1X2xvbmcKICNkZWZpbmUgdV9sb25nIF9fbXNfdV9sb25n
CiAjaW5jbHVkZSA8dzMyYXBpL3dzMnRjcGlwLmg+CisvKiAyMDI1LTA2LTA5OiB3aW4zMmFw
aSBoZWFkZXJzIHYxMyBub3cgZGVmaW5lIGEgY21zZ2hkciB0eXBlIHdoaWNoIGNsYXNoZXMg
d2l0aAorICAgb3VyIHNvY2tldC5oLiBBcnJhbmdlIG5vdCB0byBzZWUgaXQgaGVyZS4gKi8K
KyN1bmRlZiBjbXNnaGRyCisjZGVmaW5lIGNtc2doZHIgX19tc19jbXNnaGRyCiAjaW5jbHVk
ZSA8dzMyYXBpL21zd3NvY2suaD4KKyN1bmRlZiBjbXNnaGRyCiAjaW5jbHVkZSA8dzMyYXBp
L21zdGNwaXAuaD4KICNpbmNsdWRlIDxuZXRpbmV0L3RjcC5oPgogI2luY2x1ZGUgPG5ldGlu
ZXQvdWRwLmg+CmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2ZoYW5kbGVyL3NvY2tldF9s
b2NhbC5jYyBiL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXIvc29ja2V0X2xvY2FsLmNjCmluZGV4
IGVhNWVlNjdjYy4uMDQ5OGVkYzQwIDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL2ZoYW5k
bGVyL3NvY2tldF9sb2NhbC5jYworKysgYi93aW5zdXAvY3lnd2luL2ZoYW5kbGVyL3NvY2tl
dF9sb2NhbC5jYwpAQCAtMjEsNyArMjEsMTIgQEAKICNkZWZpbmUgdV9sb25nIF9fbXNfdV9s
b25nCiAjaW5jbHVkZSAibnRzZWNhcGkuaCIKICNpbmNsdWRlIDx3MzJhcGkvd3MydGNwaXAu
aD4KKy8qIDIwMjUtMDYtMDk6IHdpbjMyYXBpIGhlYWRlcnMgdjEzIG5vdyBkZWZpbmUgYSBj
bXNnaGRyIHR5cGUgd2hpY2ggY2xhc2hlcyB3aXRoCisgICBvdXIgc29ja2V0LmguIEFycmFu
Z2Ugbm90IHRvIHNlZSBpdCBoZXJlLiAqLworI3VuZGVmIGNtc2doZHIKKyNkZWZpbmUgY21z
Z2hkciBfX21zX2Ntc2doZHIKICNpbmNsdWRlIDx3MzJhcGkvbXN3c29jay5oPgorI3VuZGVm
IGNtc2doZHIKICNpbmNsdWRlIDx1bmlzdGQuaD4KICNpbmNsdWRlIDxhc20vYnl0ZW9yZGVy
Lmg+CiAjaW5jbHVkZSA8c3lzL3NvY2tldC5oPgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dp
bi9sb2NhbF9pbmNsdWRlcy9udGRsbC5oIGIvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRl
cy9udGRsbC5oCmluZGV4IDk3YTgzZDFlMy4uZmMyYWI3YTJlIDEwMDY0NAotLS0gYS93aW5z
dXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL250ZGxsLmgKKysrIGIvd2luc3VwL2N5Z3dpbi9s
b2NhbF9pbmNsdWRlcy9udGRsbC5oCkBAIC00OTAsNiArNDkwLDggQEAgdHlwZWRlZiBzdHJ1
Y3QgX0ZJTEVfRElTUE9TSVRJT05fSU5GT1JNQVRJT05fRVgJLy8gNjQKICAgVUxPTkcgRmxh
Z3M7CiB9IEZJTEVfRElTUE9TSVRJT05fSU5GT1JNQVRJT05fRVgsICpQRklMRV9ESVNQT1NJ
VElPTl9JTkZPUk1BVElPTl9FWDsKIAorI2lmIF9fTUlOR1c2NF9WRVJTSU9OX01BSk9SIDwg
MTMKKwogdHlwZWRlZiBzdHJ1Y3QgX0ZJTEVfU1RBVF9JTkZPUk1BVElPTgkJLy8gNjgKIHsK
ICAgTEFSR0VfSU5URUdFUiBGaWxlSWQ7CkBAIC01MTAsNiArNTEyLDggQEAgdHlwZWRlZiBz
dHJ1Y3QgX0ZJTEVfQ0FTRV9TRU5TSVRJVkVfSU5GT1JNQVRJT04JLy8gNzEKICAgVUxPTkcg
RmxhZ3M7CiB9IEZJTEVfQ0FTRV9TRU5TSVRJVkVfSU5GT1JNQVRJT04sICpQRklMRV9DQVNF
X1NFTlNJVElWRV9JTkZPUk1BVElPTjsKIAorI2VuZGlmCisKIGVudW0gewogICBGSUxFX0xJ
TktfUkVQTEFDRV9JRl9FWElTVFMJCQkJPSAweDAxLAogICBGSUxFX0xJTktfUE9TSVhfU0VN
QU5USUNTCQkJCT0gMHgwMiwKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vbmV0LmNjIGIv
d2luc3VwL2N5Z3dpbi9uZXQuY2MKaW5kZXggOWQ3MjI0YTIxLi41NzliMWE3MGIgMTAwNjQ0
Ci0tLSBhL3dpbnN1cC9jeWd3aW4vbmV0LmNjCisrKyBiL3dpbnN1cC9jeWd3aW4vbmV0LmNj
CkBAIC0xOCw3ICsxOCwxMiBAQCBkZXRhaWxzLiAqLwogI3VuZGVmIHVfbG9uZwogI2RlZmlu
ZSB1X2xvbmcgX19tc191X2xvbmcKICNpbmNsdWRlIDx3MzJhcGkvd3MydGNwaXAuaD4KKy8q
IDIwMjUtMDYtMDk6IHdpbjMyYXBpIGhlYWRlcnMgdjEzIG5vdyBkZWZpbmUgYSBjbXNnaGRy
IHR5cGUgd2hpY2ggY2xhc2hlcyB3aXRoCisgICBvdXIgc29ja2V0LmguIEFycmFuZ2Ugbm90
IHRvIHNlZSBpdCBoZXJlLiAqLworI3VuZGVmIGNtc2doZHIKKyNkZWZpbmUgY21zZ2hkciBf
X21zX2Ntc2doZHIKICNpbmNsdWRlIDx3MzJhcGkvbXN3c29jay5oPgorI3VuZGVmIGNtc2do
ZHIKICNpbmNsdWRlIDx3MzJhcGkvaXBobHBhcGkuaD4KICNkZWZpbmUgZ2V0aG9zdG5hbWUg
Y3lnd2luX2dldGhvc3RuYW1lCiAjaW5jbHVkZSA8dW5pc3RkLmg+Ci0tIAoyLjQ1LjEKCg==


--------------fDcjuIE16ci43nQG73hqOQ0R--
