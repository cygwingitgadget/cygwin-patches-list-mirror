Return-Path: <SRS0=mHvt=JB=dronecode.org.uk=jon.turney@sourceware.org>
Received: from re-prd-fep-045.btinternet.com (mailomta9-re.btinternet.com [213.120.69.102])
	by sourceware.org (Postfix) with ESMTPS id 5C9BA38582A1
	for <cygwin-patches@cygwin.com>; Tue, 23 Jan 2024 14:20:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5C9BA38582A1
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5C9BA38582A1
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=213.120.69.102
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1706019632; cv=none;
	b=gggesADkm1OoZqU3CMIXZs2qtPIYC6m20d8XslStePP3nnyrRCjjsMWI1mKFvU6NTV2vPm/lv4SeqVwaq54aLko9m0DbQclykUjLbnDjg8zZ2WRlnP6kMFfOH54XaIWhJjaENg0+H2kcS3AQK7IPM/MCX7+QuaRkTvvkaPW9Km4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1706019632; c=relaxed/simple;
	bh=1DAaLXTR3b90xIFKsMU8GBUN8JP7KmOcYuWtG3f2BkQ=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=uqrfcT0YN8J5bX1dAWvtn/2VRlHnmRTSUUQz9Jc5CPbWDoHU7hHVlzk3c+Wso27ylAsoKvny9ZON+YTjDRBMqqUzQEVp1CmfbnRLN+y26gUGdWqk87pw4nW9HYA8KlFK8bY3l2acmMEJpdPIrYNjiUb3pnZTZ6gDO4eooa1i2x0=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from re-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.54.8])
          by re-prd-fep-045.btinternet.com with ESMTP
          id <20240123142027.YEEW21611.re-prd-fep-045.btinternet.com@re-prd-rgout-005.btmx-prd.synchronoss.net>
          for <cygwin-patches@cygwin.com>; Tue, 23 Jan 2024 14:20:27 +0000
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 6577B9C50503D60F
X-Originating-IP: [86.140.193.68]
X-OWM-Source-IP: 86.140.193.68
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=30/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekkedgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecumhhishhsihhnghcuvffquchfihgvlhguucdlfedtmdenucfjughrpegtkfffgggfufhfhfevjgesmhdtreertddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepleekkeegffekffduieejkeelieekhfffieeiieduudekgeelgffggfetheeitdevnecukfhppeekiedrudegtddrudelfedrieeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudegtddrudelfedrieekpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepuddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrvghvkffrpehhohhsthekiedqudegtddqudelfedqieekrdhrrghnghgvkeeiqddugedtrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpehrvgdqphhr
	ugdqrhhgohhuthdqtddthe
X-RazorGate-Vade-Verdict: clean 30
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (86.140.193.68) by re-prd-rgout-005.btmx-prd.synchronoss.net (authenticated as jonturney@btinternet.com)
        id 6577B9C50503D60F for cygwin-patches@cygwin.com; Tue, 23 Jan 2024 14:20:27 +0000
Content-Type: multipart/mixed; boundary="------------OLFMZrmnw4BD6qnlOUZgLWJp"
Message-ID: <238901bf-db88-4d99-bb82-2b98ff6ebdf6@dronecode.org.uk>
Date: Tue, 23 Jan 2024 14:20:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] Cygwin: Make 'ulimit -c' control writing a coredump
References: <20240112140958.1694-1-jon.turney@dronecode.org.uk>
 <20240112140958.1694-2-jon.turney@dronecode.org.uk>
Content-Language: en-GB
From: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20240112140958.1694-2-jon.turney@dronecode.org.uk>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------OLFMZrmnw4BD6qnlOUZgLWJp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/01/2024 14:09, Jon Turney wrote:
> Pre-format a command to be executed on a fatal error to run 'dumper'
> (using an absolute path).
> 
> Factor out executing a pre-formatted command, so we can use that for
> invoking the JIT debugger in try_to_debug() (if error_start is present
> in the CYGWIN env var) and to invoke dumper when a fatal error occurs.
> 

So, there is a small problem with this change: because dumper itself 
terminates the dumped process, it doesn't go on to exit with the 
signal+128 exit status.

(In fact, it seems to exit with status 0 when terminated by an attached 
debugger terminating, which isn't great)

That's relatively easy to fix: just use the '-n' option to dumper so it 
detaches before exiting, to prevent that terminating the dumped process, 
but then we run into the difficulties of reliably detecting that dumper 
has attached and done it's work, so it's safe for us to exit.

Attached patch does that, and documents the expectations on the 
error_start command a bit more clearly.

Even then this is clearly not totally bullet-proof. Maybe the right 
thing to do is add a suitable timeout here, so even if we fail to notice 
the DebugActiveProcess() (or there's a custom JIT debugger which just 
writes the fact a process crashed to a logfile or something), we'll exit 
eventually?

--------------OLFMZrmnw4BD6qnlOUZgLWJp
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-Don-t-terminate-via-dumper.patch"
Content-Disposition: attachment;
 filename="0001-Cygwin-Don-t-terminate-via-dumper.patch"
Content-Transfer-Encoding: base64

RnJvbSA4NTEyMGExNjk3Mjk0Y2Q5M2ZmNjhmNmIxODQwMTQ1MjUxY2U0MTg1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKb24gVHVybmV5IDxqb24udHVybmV5QGRyb25lY29k
ZS5vcmcudWs+CkRhdGU6IFR1ZSwgMTYgSmFuIDIwMjQgMTY6MTI6NTEgKzAwMDAKU3ViamVj
dDogW1BBVENIXSBDeWd3aW46IERvbid0IHRlcm1pbmF0ZSB2aWEgZHVtcGVyCgpBIHByb2Nl
c3Mgd2hpY2ggaXMgZXhpdGluZyBkdWUgdG8gYSBjb3JlIGR1bXBpbmcgc2lnbmFsIGRvZXNu
J3QKcHJvcGFnYXRlIHRoZSBjb3JyZWN0IGV4aXN0IHN0YXR1cyBhZnRlciBkdW1waW5nIGNv
cmUsIGJlY2F1c2UgJ2R1bXBlcicKaXRzZWxmIGZvcmNpYmx5IHRlcm1pbmF0ZXMgdGhlIHBy
b2Nlc3MuCgpVc2UgJ2R1bXBlciAtbicgdG8gYXZvaWQga2lsbGluZyB0aGUgZHVtcGVkIHBy
b2Nlc3MsIHNvIHdlIGNvbnRpbnVlIHRvCnRoZSBlbmQgb2Ygc2lnbmFsX2V4aXQoKSAsIHRv
IGV4aXQgd2l0aCB0aGUgMTI4K3NpZ25hbCBleGl0IHN0YXR1cy4KCkJ1c3ktd2FpdCBpbiBl
eGVjX3ByZXBhcmVkX2NvbW1hbmQoKSBpbiBhbiBhdHRlbXB0IHRvIHJlbGlhYmx5IG5vdGlj
ZQp0aGUgZHVtcGVyIGF0dGFjaGluZywgc28gd2UgZG9uJ3QgZ2V0IHN0dWNrIHRoZXJlLgoK
QWxzbzogZG9jdW1lbnQgdGhlc2UgaW1wb3J0YW50IGZhY3RzIGZvciBjdXN0b20gdXNlcyBv
ZiBlcnJvcl9zdGFydC4KLS0tCiB3aW5zdXAvY3lnd2luL2V4Y2VwdGlvbnMuY2MgfCA3ICsr
Ky0tLS0KIHdpbnN1cC9kb2MvY3lnd2luZW52LnhtbCAgICB8IDYgKysrKysrCiAyIGZpbGVz
IGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS93aW5zdXAvY3lnd2luL2V4Y2VwdGlvbnMuY2MgYi93aW5zdXAvY3lnd2luL2V4Y2VwdGlv
bnMuY2MKaW5kZXggOGIxYzU0OTNlLi4wZTFhODA0Y2EgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9j
eWd3aW4vZXhjZXB0aW9ucy5jYworKysgYi93aW5zdXAvY3lnd2luL2V4Y2VwdGlvbnMuY2MK
QEAgLTE0OSw3ICsxNDksNyBAQCBkdW1wZXJfaW5pdCAodm9pZCkKIAogICAvKiBDYWxjdWxh
dGUgdGhlIGxlbmd0aCBvZiB0aGUgY29tbWFuZCwgYWxsb3dpbmcgZm9yIGFuIGFwcGVuZGVk
IERXT1JEIFBJRCBhbmQKICAgICAgdGVybWluYXRpbmcgbnVsbCAqLwotICBpbnQgY21kX2xl
biA9IDEgKyB3Y3NsZW4oZGxsX2RpcikgKyAxMSArIDIgKyAxICsgd2NzbGVuKGdsb2JhbF9w
cm9nbmFtZSkgKyAxICsgMTAgKyAxOworICBpbnQgY21kX2xlbiA9IDEgKyB3Y3NsZW4oZGxs
X2RpcikgKyAxMSArIDUgKyAxICsgd2NzbGVuKGdsb2JhbF9wcm9nbmFtZSkgKyAxICsgMTAg
KyAxOwogICBpZiAoY21kX2xlbiA+IDMyNzY3KQogICAgIHsKICAgICAgIC8qIElmIHRoaXMg
Y29tZXMgdG8gbW9yZSB0aGFuIHRoZSAzMiw3NjcgY2hhcmFjdGVycyBDcmVhdGVQcm9jZXNz
KCkgY2FuCkBAIC0xNjMsNyArMTYzLDcgQEAgZHVtcGVyX2luaXQgKHZvaWQpCiAgIGNwID0g
d2NwY3B5IChjcCwgTCJcIiIpOwogICBjcCA9IHdjcGNweSAoY3AsIGRsbF9kaXIpOwogICBj
cCA9IHdjcGNweSAoY3AsIEwiXFxkdW1wZXIuZXhlIik7Ci0gIGNwID0gd2NwY3B5IChjcCwg
TCJcIiAiKTsKKyAgY3AgPSB3Y3BjcHkgKGNwLCBMIlwiIC1uICIpOwogICBjcCA9IHdjcGNw
eSAoY3AsIEwiXCIiKTsKICAgY3AgPSB3Y3BjcHkgKGNwLCBnbG9iYWxfcHJvZ25hbWUpOwog
ICB3Y3NjYXQgKGNwLCBMIlwiIik7CkBAIC01NzAsOSArNTcwLDggQEAgaW50IGV4ZWNfcHJl
cGFyZWRfY29tbWFuZCAoUFdDSEFSIGNvbW1hbmQpCiAgICAgc3lzdGVtX3ByaW50ZiAoIkZh
aWxlZCB0byBzdGFydCwgJUUiKTsKICAgZWxzZQogICAgIHsKLSAgICAgIFNldFRocmVhZFBy
aW9yaXR5IChHZXRDdXJyZW50VGhyZWFkICgpLCBUSFJFQURfUFJJT1JJVFlfSURMRSk7CiAg
ICAgICB3aGlsZSAoIWJlaW5nX2RlYnVnZ2VkICgpKQotCVNsZWVwICgxKTsKKwlTbGVlcCAo
MCk7CiAgICAgICBTbGVlcCAoMjAwMCk7CiAgICAgfQogCmRpZmYgLS1naXQgYS93aW5zdXAv
ZG9jL2N5Z3dpbmVudi54bWwgYi93aW5zdXAvZG9jL2N5Z3dpbmVudi54bWwKaW5kZXggZDk3
ZjJiNzdkLi4wNTY3MmM0MDQgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9kb2MvY3lnd2luZW52Lnht
bAorKysgYi93aW5zdXAvZG9jL2N5Z3dpbmVudi54bWwKQEAgLTQ2LDYgKzQ2LDEyIEBAIHRv
IHRoZSBjb21tYW5kIGFzIGFyZ3VtZW50cy4KICAgTm90ZTogVGhpcyBoYXMgbm8gZWZmZWN0
IGlmIGEgZGVidWdnZXIgaXMgYWxyZWFkeSBhdHRhY2hlZCB3aGVuIHRoZSBmYXRhbAogICBl
cnJvciBvY2N1cnMuCiA8L3BhcmE+Cis8cGFyYT4KKyAgTm90ZTogVGhlIGNvbW1hbmQgaW52
b2tlZCBtdXN0IGVpdGhlciAoaSkgYXR0YWNoIHRvIHRoZSBlcnJvcmVkIHByb2Nlc3Mgd2l0
aAorICA8ZnVuY3Rpb24+RGVidWdBY3RpdmVQcm9jZXNzKCk8L2Z1bmN0aW9uPiwgb3IgKGlp
KSBmb3JjaWJseSB0ZXJtaW5hdGUgdGhlCisgIGVycm9yZWQgcHJvY2VzcyAod2l0aCA8ZnVu
Y3Rpb24+VGVybWluYXRlUHJvY2VzcygpPC9mdW5jdGlvbj4gb3Igc2ltaWxhciksIGFzCisg
IG90aGVyd2lzZSB0aGUgZXJyb3JlZCBwcm9jZXNzIHdpbGwgd2FpdCBmb3JldmVyIGZvciBh
IGRlYnVnZ2VyIHRvIGF0dGFjaC4KKzwvcGFyYT4KIDwvbGlzdGl0ZW0+CiAKIDxsaXN0aXRl
bT4KLS0gCjIuNDMuMAoK

--------------OLFMZrmnw4BD6qnlOUZgLWJp--
