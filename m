Return-Path: <SRS0=huW9=PF=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo003.btinternet.com (btprdrgo003.btinternet.com [65.20.50.240])
	by sourceware.org (Postfix) with ESMTP id E2B063858C56;
	Tue,  6 Aug 2024 18:58:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E2B063858C56
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E2B063858C56
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.240
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1722970739; cv=none;
	b=GfQE7qNLk07RVmY2aXmY2dZhhDJoEbCeZ2mTkYGuxG9cRDNl8X+fE8s8+rCd43rEJmCfXHcYx/OUrr1Q/xAnwTkcBstkvRu6rd8AiIgmr4GMEhvr03iFZDIDqkIYukA7pWrumk7h+zAj+rRosu6GM501i7azEQV+Ped8/wHrOhg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1722970739; c=relaxed/simple;
	bh=SsNyaHIAD3blh/9/LgxCTxYqjogZSmJuC1c/UMBSU+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=TcXaZWF5zCMiAh/Py7C/rF4EQfRQOLlnqo/FrKNeEapS8zBrAiKjHff0dtjxaQWVIwPQzCT6BNsfAs6MsCbMWNBKAUdYy9oVtMW7kwQmwxkNfYYJZOhTRs4AKOvpbQAW/yCOrDhn0CE68oYxt3hLWCsfYZvJFB2FXsWhreIRWiw=
ARC-Authentication-Results: i=1; server2.sourceware.org
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 6694414B02AB90EF
X-Originating-IP: [86.140.193.104]
X-OWM-Source-IP: 86.140.193.104
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgddufeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurheptgfkffggfgfuvfhfhfevjgesmhdtreertddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepheevfedvfeevtddufeetgefgvdfhueeguedvhfetheehudefieeitdeftedtieetnecukfhppeekiedrudegtddrudelfedruddtgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkeeirddugedtrdduleefrddutdegpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegtohhrihhnnhgrqdgthihgfihinhestgihghifihhnrdgtohhmpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgvvhfkrfephhhoshhtkeeiqddugedtqdduleefqddutdegrdhrrghnghgvkeeiqddugedtrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfep
	ifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdef
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (86.140.193.104) by btprdrgo003.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6694414B02AB90EF; Tue, 6 Aug 2024 19:58:55 +0100
Content-Type: multipart/mixed; boundary="------------4Onfidxn0sz0V9jDFGveDHvR"
Message-ID: <4deb7dbe-1ac0-478c-bd36-76d3937864cc@dronecode.org.uk>
Date: Tue, 6 Aug 2024 19:58:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] Cygwin: Fix warnings about narrowing conversions of
 socket ioctls
To: Corinna Vinschen <corinna-cygwin@cygwin.com>
References: <20240804214829.43085-1-jon.turney@dronecode.org.uk>
 <20240804214829.43085-6-jon.turney@dronecode.org.uk>
 <ZrCn00PXmRT77OKj@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <ZrCn00PXmRT77OKj@calimero.vinschen.de>
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------4Onfidxn0sz0V9jDFGveDHvR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/08/2024 11:22, Corinna Vinschen wrote:
> On Aug  4 22:48, Jon Turney wrote:
>> Fix gcc 12 warnings about narrowing conversions of socket ioctl constants
>> when used as case labels, e.g:
>>
>>> ../../../../src/winsup/cygwin/net.cc: In function ‘int get_ifconf(ifconf*, int)’:
>>> ../../../../src/winsup/cygwin/net.cc:1940:18: error: narrowing conversion of ‘2152756069’ from ‘long int’ to ‘int’ [-Wnarrowing]
>> ---
>>   winsup/cygwin/net.cc | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/winsup/cygwin/net.cc b/winsup/cygwin/net.cc
>> index 08c584fe5..b76af2d19 100644
>> --- a/winsup/cygwin/net.cc
>> +++ b/winsup/cygwin/net.cc
>> @@ -1935,7 +1935,7 @@ get_ifconf (struct ifconf *ifc, int what)
>>   	{
>>   	  ++cnt;
>>   	  strcpy (ifr->ifr_name, ifp->ifa_name);
>> -	  switch (what)
>> +	  switch ((long int)what)
>>   	    {
>>   	    case SIOCGIFFLAGS:
>>   	      ifr->ifr_flags = ifp->ifa_ifa.ifa_flags;
>> -- 
>> 2.45.1
> 
> The only caller, fhandler_socket::ioctl, passes an unsigned int
> value to get_ifconf. Given how the value is defined, it would be
> more straightforward to convert get_ifconf to
> 
>    get_ifconf (struct ifconf *ifc, unsigned int what);
> 
> wouldn't it?

Yeah, I'm not sure why I didn't do that.  I think I got confused about 
where this is used from.

(These constants are long int though, for whatever reason, so it's not 
immediately obvious that they all can be converted to unsigned int 
without loss, but it seems they can)

Revised patch attached.

--------------4Onfidxn0sz0V9jDFGveDHvR
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-Fix-warnings-about-narrowing-conversions-of-s.patch"
Content-Disposition: attachment;
 filename*0="0001-Cygwin-Fix-warnings-about-narrowing-conversions-of-s.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBkZjhiMWZmZDZlZjdhOTgwOGEyZDVlZWJmNGI2NDE2ZDQ1ODQxZTM2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKb24gVHVybmV5IDxqb24udHVybmV5QGRyb25lY29k
ZS5vcmcudWs+CkRhdGU6IFN1biwgNCBBdWcgMjAyNCAxNzowMjowMCArMDEwMApTdWJqZWN0
OiBbUEFUQ0hdIEN5Z3dpbjogRml4IHdhcm5pbmdzIGFib3V0IG5hcnJvd2luZyBjb252ZXJz
aW9ucyBvZiBzb2NrZXQKIGlvY3RscwpNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6
IHRleHQvcGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzog
OGJpdAoKRml4IGdjYyAxMiB3YXJuaW5ncyBhYm91dCBuYXJyb3dpbmcgY29udmVyc2lvbnMg
b2Ygc29ja2V0IGlvY3RsIGNvbnN0YW50cwp3aGVuIHVzZWQgYXMgY2FzZSBsYWJlbHMsIGUu
ZzoKCj4gLi4vLi4vLi4vLi4vc3JjL3dpbnN1cC9jeWd3aW4vbmV0LmNjOiBJbiBmdW5jdGlv
biDigJhpbnQgZ2V0X2lmY29uZihpZmNvbmYqLCBpbnQp4oCZOgo+IC4uLy4uLy4uLy4uL3Ny
Yy93aW5zdXAvY3lnd2luL25ldC5jYzoxOTQwOjE4OiBlcnJvcjogbmFycm93aW5nIGNvbnZl
cnNpb24gb2Yg4oCYMjE1Mjc1NjA2OeKAmSBmcm9tIOKAmGxvbmcgaW504oCZIHRvIOKAmGlu
dOKAmSBbLVduYXJyb3dpbmddCgpTaWduZWQtb2ZmLWJ5OiBKb24gVHVybmV5IDxqb24udHVy
bmV5QGRyb25lY29kZS5vcmcudWs+Ci0tLQogd2luc3VwL2N5Z3dpbi9maGFuZGxlci9zb2Nr
ZXQuY2MgfCAyICstCiB3aW5zdXAvY3lnd2luL25ldC5jYyAgICAgICAgICAgICB8IDIgKy0K
IDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXIvc29ja2V0LmNjIGIvd2luc3VwL2N5
Z3dpbi9maGFuZGxlci9zb2NrZXQuY2MKaW5kZXggZjdjNWZmNjI5Li5jMGNlZjdkM2UgMTAw
NjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXIvc29ja2V0LmNjCisrKyBiL3dpbnN1
cC9jeWd3aW4vZmhhbmRsZXIvc29ja2V0LmNjCkBAIC04Niw3ICs4Niw3IEBAIHN0cnVjdCBf
X29sZF9pZnJlcSB7CiBpbnQKIGZoYW5kbGVyX3NvY2tldDo6aW9jdGwgKHVuc2lnbmVkIGlu
dCBjbWQsIHZvaWQgKnApCiB7Ci0gIGV4dGVybiBpbnQgZ2V0X2lmY29uZiAoc3RydWN0IGlm
Y29uZiAqaWZjLCBpbnQgd2hhdCk7IC8qIG5ldC5jYyAqLworICBleHRlcm4gaW50IGdldF9p
ZmNvbmYgKHN0cnVjdCBpZmNvbmYgKmlmYywgdW5zaWduZWQgaW50IHdoYXQpOyAvKiBuZXQu
Y2MgKi8KICAgaW50IHJlczsKICAgc3RydWN0IGlmY29uZiBpZmMsICppZmNwOwogICBzdHJ1
Y3QgaWZyZXEgKmlmcnA7CmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL25ldC5jYyBiL3dp
bnN1cC9jeWd3aW4vbmV0LmNjCmluZGV4IDA4YzU4NGZlNS4uNzM3ZTQ5NGY4IDEwMDY0NAot
LS0gYS93aW5zdXAvY3lnd2luL25ldC5jYworKysgYi93aW5zdXAvY3lnd2luL25ldC5jYwpA
QCAtMTkxMiw3ICsxOTEyLDcgQEAgZnJlZWlmYWRkcnMgKHN0cnVjdCBpZmFkZHJzICppZnAp
CiB9CiAKIGludAotZ2V0X2lmY29uZiAoc3RydWN0IGlmY29uZiAqaWZjLCBpbnQgd2hhdCkK
K2dldF9pZmNvbmYgKHN0cnVjdCBpZmNvbmYgKmlmYywgdW5zaWduZWQgaW50IHdoYXQpCiB7
CiAgIF9fdHJ5CiAgICAgewotLSAKMi40NS4xCgo=

--------------4Onfidxn0sz0V9jDFGveDHvR--
