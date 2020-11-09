Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-042.btinternet.com (mailomta28-re.btinternet.com
 [213.120.69.121])
 by sourceware.org (Postfix) with ESMTPS id 5FDB53857810
 for <cygwin-patches@cygwin.com>; Mon,  9 Nov 2020 16:25:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5FDB53857810
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
 by re-prd-fep-042.btinternet.com with ESMTP id
 <20201109162526.NQMA19415.re-prd-fep-042.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Mon, 9 Nov 2020 16:25:26 +0000
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9C506195E6E59
X-Originating-IP: [86.139.158.14]
X-OWM-Source-IP: 86.139.158.14 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrudduhedgledtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgesmhdtreertdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepudetfeevffeuleegiefhhffggeeujeekuefgiedtheekleekteelvddvteevgeeunecukfhppeekiedrudefledrudehkedrudegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurdduuddungdpihhnvghtpeekiedrudefledrudehkedrudegpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (86.139.158.14) by
 re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C506195E6E59 for cygwin-patches@cygwin.com;
 Mon, 9 Nov 2020 16:25:26 +0000
Subject: Re: [PATCH 11/11] Ensure temporary directory used by tests exists
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20201105194748.31282-1-jon.turney@dronecode.org.uk>
 <20201105194748.31282-12-jon.turney@dronecode.org.uk>
 <8e13e92f-7aca-65ee-8978-d0b6cd7b062f@cornell.edu>
 <bae783a3-1098-85da-c2b8-00a65db6e00c@dronecode.org.uk>
 <643396a1-21b0-88a6-3f6b-2eb2083821e7@cornell.edu>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <666af9fa-194d-7b6e-a165-18f8d5169b94@dronecode.org.uk>
Date: Mon, 9 Nov 2020 16:25:24 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <643396a1-21b0-88a6-3f6b-2eb2083821e7@cornell.edu>
Content-Type: multipart/mixed; boundary="------------8BA32DDA27A5D1ED1CB8C24C"
Content-Language: en-GB
X-Spam-Status: No, score=-1200.8 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS,
 SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Mon, 09 Nov 2020 16:25:49 -0000

This is a multi-part message in MIME format.
--------------8BA32DDA27A5D1ED1CB8C24C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/11/2020 19:27, Ken Brown via Cygwin-patches wrote:
> On 11/8/2020 1:52 PM, Jon Turney wrote:
>> On 08/11/2020 18:19, Ken Brown via Cygwin-patches wrote:
>>> On 11/5/2020 2:47 PM, Jon Turney wrote:
>>>> +# temporary directory to be used for files created by tests (as an 
>>>> absolute,
>>>> +# /cygdrive path, so it can be understood by the test DLL, which 
>>>> will have
>>>> +# different mount table)
>>>> +tmpdir = $(shell cygpath -ma $(objdir)/testsuite/tmp/ | sed -e 
>>>> 's#^\([A-Z]\):#/cygdrive/\L\1#')
>>>
>>> This isn't right if the cygdrive prefix is not 'cygdrive'.  Maybe use 
>>> 'proc/cygdrive' instead of 'cygdrive'?
>>>
>>
>> That's how I originally had it.  Unfortunately, test ltp/symlink01 
>> relies on the test directory being specified as a canonicalized 
>> pathname (i.e. is the same after realpath()).
>>
>> Since there's no /etc/fstab in the the filesystem relative to the test 
>> DLL, I think it should always be using the default cygdrive prefix?
> 
> But there's a mkdir command that seems to be run in the context of the 
> user running 'make check'.  If the cygdrive prefix is not 'cygdrive', 
> 'make check' fails as follows:
> 
> ERROR: tcl error sourcing 
> /home/kbrown/src/cygdll/newlib-cygwin/winsup/testsuite/winsup.api/winsup.exp. 
> 
> ERROR: can't create directory "/cygdrive": permission denied
>      while executing
> "file mkdir $tmpdir/$base"
> 

Ah, I see.

Maybe something like the attached is needed.

--------------8BA32DDA27A5D1ED1CB8C24C
Content-Type: text/plain; charset=UTF-8;
 name="0001-Fix-testsuite-tmpdir-creation-with-non-default-cygdr.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Fix-testsuite-tmpdir-creation-with-non-default-cygdr.pa";
 filename*1="tch"

RnJvbSAzZjE0ZDFhM2M2MTk3ZTUyZTA4M2ViOGE4Njk1NzNjNWUyYWFiNGVmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKb24gVHVybmV5IDxqb24udHVybmV5QGRyb25lY29k
ZS5vcmcudWs+CkRhdGU6IE1vbiwgOSBOb3YgMjAyMCAxMzo0ODozOCArMDAwMApTdWJqZWN0
OiBbUEFUQ0hdIEZpeCB0ZXN0c3VpdGUgdG1wZGlyIGNyZWF0aW9uIHdpdGggbm9uLWRlZmF1
bHQgY3lnZHJpdmUKIHByZWZpeAoKLS0tCiB3aW5zdXAvdGVzdHN1aXRlL01ha2VmaWxlLmlu
ICAgICAgICAgICB8IDEwICsrKysrKy0tLS0KIHdpbnN1cC90ZXN0c3VpdGUvd2luc3VwLmFw
aS93aW5zdXAuZXhwIHwgIDIgKy0KIDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
LCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC90ZXN0c3VpdGUvTWFrZWZp
bGUuaW4gYi93aW5zdXAvdGVzdHN1aXRlL01ha2VmaWxlLmluCmluZGV4IDdlMTg4MTc2MS4u
ZGExNjg0YWVmIDEwMDY0NAotLS0gYS93aW5zdXAvdGVzdHN1aXRlL01ha2VmaWxlLmluCisr
KyBiL3dpbnN1cC90ZXN0c3VpdGUvTWFrZWZpbGUuaW4KQEAgLTEwOCwxMCArMTA4LDExIEBA
ICQoUlVOVElNRSkgOiAkKGN5Z3dpbl9idWlsZCkvTWFrZWZpbGUKICMgU2V0IHRvICQodGFy
Z2V0X2FsaWFzKS8gZm9yIGNyb3NzLgogdGFyZ2V0X3N1YmRpciA9IEB0YXJnZXRfc3ViZGly
QAogCi0jIHRlbXBvcmFyeSBkaXJlY3RvcnkgdG8gYmUgdXNlZCBmb3IgZmlsZXMgY3JlYXRl
ZCBieSB0ZXN0cyAoYXMgYW4gYWJzb2x1dGUsCi0jIC9jeWdkcml2ZSBwYXRoLCBzbyBpdCBj
YW4gYmUgdW5kZXJzdG9vZCBieSB0aGUgdGVzdCBETEwsIHdoaWNoIHdpbGwgaGF2ZQotIyBk
aWZmZXJlbnQgbW91bnQgdGFibGUpCi10bXBkaXIgPSAkKHNoZWxsIGN5Z3BhdGggLW1hICQo
b2JqZGlyKS90ZXN0c3VpdGUvdG1wLyB8IHNlZCAtZSAncyNeXChbQS1aXVwpOiMvY3lnZHJp
dmUvXExcMSMnKQorIyBhIHRlbXBvcmFyeSBkaXJlY3RvcnksIHRvIGJlIHVzZWQgZm9yIGZp
bGVzIGNyZWF0ZWQgYnkgdGVzdHMKK3RtcGRpciA9ICQoYWJzcGF0aCAkKG9iamRpcikvdGVz
dHN1aXRlL3RtcC8pCisjIHRoZSBzYW1lIHRlbXBvcmFyeSBkaXJlY3RvcnksIGFzIGFuIGFi
c29sdXRlLCAvY3lnZHJpdmUgcGF0aCAoc28gaXQgY2FuIGJlCisjIHVuZGVyc3Rvb2QgYnkg
dGhlIHRlc3QgRExMLCB3aGljaCB3aWxsIGhhdmUgYSBkaWZmZXJlbnQgbW91bnQgdGFibGUp
Cit0ZXN0ZGxsX3RtcGRpciA9ICQoc2hlbGwgY3lncGF0aCAtbWEgJCh0bXBkaXIpIHwgc2Vk
IC1lICdzI15cKFtBLVpdXCk6Iy9jeWdkcml2ZS9cTFwxIycpCiAKIHNpdGUuZXhwOiAuL2Nv
bmZpZy5zdGF0dXMgTWFrZWZpbGUKIAlAZWNobyAiTWFraW5nIGEgbmV3IGNvbmZpZyBmaWxl
Li4uIgpAQCAtMTMyLDYgKzEzMyw3IEBAIHNpdGUuZXhwOiAuL2NvbmZpZy5zdGF0dXMgTWFr
ZWZpbGUKIAlAZWNobyAic2V0IENGTEFHUyBcIiQoSU5DTFVERVMpXCIiID4+IC4vdG1wMAog
CUBlY2hvICJzZXQgTUlOR1dfQ1hYIFwiJChNSU5HV19DWFgpXCIiID4+IC4vdG1wMAogCUBl
Y2hvICJzZXQgdG1wZGlyICQodG1wZGlyKSIgPj4gLi90bXAwCisJQGVjaG8gInNldCB0ZXN0
ZGxsX3RtcGRpciAkKHRlc3RkbGxfdG1wZGlyKSIgPj4gLi90bXAwCiAJQGVjaG8gInNldCBs
dHBfaW5jbHVkZXMgXCIkKHJlYWxwYXRoICQobGlibHRwX3NyY2RpcikpL2luY2x1ZGVcIiIg
Pj4gLi90bXAwCiAJQGVjaG8gIiMjIEFsbCB2YXJpYWJsZXMgYWJvdmUgYXJlIGdlbmVyYXRl
ZCBieSBjb25maWd1cmUuIERvIE5vdCBFZGl0ICMjIiA+PiAuL3RtcDAKIAlAY2F0IC4vdG1w
MCA+IHNpdGUuZXhwCmRpZmYgLS1naXQgYS93aW5zdXAvdGVzdHN1aXRlL3dpbnN1cC5hcGkv
d2luc3VwLmV4cCBiL3dpbnN1cC90ZXN0c3VpdGUvd2luc3VwLmFwaS93aW5zdXAuZXhwCmlu
ZGV4IGNkNTk2NGQ0Ny4uNDk3ODEzNmExIDEwMDY0NAotLS0gYS93aW5zdXAvdGVzdHN1aXRl
L3dpbnN1cC5hcGkvd2luc3VwLmV4cAorKysgYi93aW5zdXAvdGVzdHN1aXRlL3dpbnN1cC5h
cGkvd2luc3VwLmV4cApAQCAtNjksNyArNjksNyBAQCBmb3JlYWNoIHNyYyBbbHNvcnQgW2ds
b2IgLW5vY29tcGxhaW4gJHNyY2Rpci8kc3ViZGlyLyouYyAkc3JjZGlyLyRzdWJkaXIvKi8q
LntjYwogCSAgICAgICBzZXQgcmVkaXJlY3Rfb3V0cHV0IC9kZXYvbnVsbAogCSAgICB9CiAJ
ICAgIGZpbGUgbWtkaXIgJHRtcGRpci8kYmFzZQotCSAgICB3c19zcGF3biAiJHJvb3RtZS9j
eWdydW4gLi8kYmFzZS5leGUgJHRtcGRpci8kYmFzZSA+ICRyZWRpcmVjdF9vdXRwdXQiCisJ
ICAgIHdzX3NwYXduICIkcm9vdG1lL2N5Z3J1biAuLyRiYXNlLmV4ZSAkdGVzdGRsbF90bXBk
aXIvJGJhc2UgPiAkcmVkaXJlY3Rfb3V0cHV0IgogCSAgICBmaWxlIGRlbGV0ZSAtZm9yY2Ug
JHRtcGRpci8kYmFzZQogCSAgICBpZiB7ICRydiB9IHsKIAkJZmFpbCAiJHRlc3RjYXNlIChl
eGVjdXRlKSIKLS0gCjIuMjkuMgoK
--------------8BA32DDA27A5D1ED1CB8C24C--
