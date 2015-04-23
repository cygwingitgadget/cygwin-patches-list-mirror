Return-Path: <cygwin-patches-return-8132-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 42018 invoked by alias); 23 Apr 2015 13:53:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 42002 invoked by uid 89); 23 Apr 2015 13:53:20 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2
X-HELO: out4-smtp.messagingengine.com
Received: from out4-smtp.messagingengine.com (HELO out4-smtp.messagingengine.com) (66.111.4.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Thu, 23 Apr 2015 13:53:18 +0000
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])	by mailout.nyi.internal (Postfix) with ESMTP id 9E48D20728	for <cygwin-patches@cygwin.com>; Thu, 23 Apr 2015 09:53:16 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])  by compute1.internal (MEProxy); Thu, 23 Apr 2015 09:53:16 -0400
Received: from [192.168.1.102] (unknown [86.141.129.242])	by mail.messagingengine.com (Postfix) with ESMTPA id 3C1C4C0001C	for <cygwin-patches@cygwin.com>; Thu, 23 Apr 2015 09:53:16 -0400 (EDT)
Message-ID: <5538F94A.3080402@dronecode.org.uk>
Date: Thu, 23 Apr 2015 13:53:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/3] Provide ucontext to signal handlers
References: <1427894373-2576-1-git-send-email-jon.turney@dronecode.org.uk> <1427894373-2576-3-git-send-email-jon.turney@dronecode.org.uk> <20150401142219.GY13285@calimero.vinschen.de> <551C2CB7.4@dronecode.org.uk>
In-Reply-To: <551C2CB7.4@dronecode.org.uk>
Content-Type: multipart/mixed; boundary="------------030203060101050308090201"
X-SW-Source: 2015-q2/txt/msg00033.txt.bz2

This is a multi-part message in MIME format.
--------------030203060101050308090201
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1403

On 01/04/2015 18:36, Jon TURNEY wrote:
> On 01/04/2015 15:22, Corinna Vinschen wrote:
>> On Apr  1 14:19, Jon TURNEY wrote:
>>> Add ucontext.h header, defining ucontext_t and mcontext_t types.
>>>
>>> Provide sigaction sighandlers with a ucontext_t parameter, containing
>>> stack and
>>> context information.
>>>
>>>     * include/sys/ucontext.h : New header.
>>>     * include/ucontext.h : Ditto.
>>>     * exceptions.cc (call_signal_handler): Provide ucontext_t
>>>     parameter to signal handler function.
>>
>> Patch is ok with a single change:  Please add a "FIXME?" comment to:
>>
>>    else
>>      RtlCaptureContext();
>>
>> On second thought, calling RtlCaptureContext here is probably wrong.
>>
>> What we really need is the context of the thread when calling
>> call_signal_handler I think.
>
> I had the same thought, but this is going to be quite tricky to achieve.

>> It would be better to call RtlCaptureContext
>> before calling call_signal_handler.  But this requires a change in how
>> call_signal_handler is called.
>>
>> We should discuss this at one point, I think.

I noticed that we already prepare a context for continuing after the 
signal for the debugger, so perhaps this is not quite as complex as I 
thought and something like the attached is needed.

It's very hard to reason about if this is doing the right thing when the 
signal is delivered across threads, though.


--------------030203060101050308090201
Content-Type: text/plain; charset=windows-1252;
 name="0001-Use-the-same-continuation-context-in-a-signal-as-we-.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Use-the-same-continuation-context-in-a-signal-as-we-.pa";
 filename*1="tch"
Content-length: 2298

RnJvbSBkNjM4NWFhNjZlMjZlODY4MzJlMWU5NTIyMmU4MDI2MTQ2YmI2M2Rm
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKb24gVFVSTkVZIDxq
b24udHVybmV5QGRyb25lY29kZS5vcmcudWs+CkRhdGU6IFRodSwgMjMgQXBy
IDIwMTUgMTQ6NDU6MDUgKzAxMDAKU3ViamVjdDogW1BBVENIXSBVc2UgdGhl
IHNhbWUgY29udGludWF0aW9uIGNvbnRleHQgaW4gYSBzaWduYWwgYXMgd2Ug
d291bGQKIHNlbmQgdG8gdGhlIGRlYnVnZ2VyCgotLS0KIHdpbnN1cC9jeWd3
aW4vZXhjZXB0aW9ucy5jYyB8IDEyICsrKystLS0tLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS93aW5zdXAvY3lnd2luL2V4Y2VwdGlvbnMuY2MgYi93aW5zdXAv
Y3lnd2luL2V4Y2VwdGlvbnMuY2MKaW5kZXggNGE2YzIxZS4uYzk3Y2MxOSAx
MDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9leGNlcHRpb25zLmNjCisrKyBi
L3dpbnN1cC9jeWd3aW4vZXhjZXB0aW9ucy5jYwpAQCAtMTUwMywxMiArMTUw
Myw3IEBAIF9jeWd0bHM6OmNhbGxfc2lnbmFsX2hhbmRsZXIgKCkKIAkgIGlm
ICh0aGlzc2kuc2lfY3lnKQogCSAgICBtZW1jcHkgKCZjb250ZXh0LnVjX21j
b250ZXh0LCAoKGN5Z3dpbl9leGNlcHRpb24gKil0aGlzc2kuc2lfY3lnKS0+
Y29udGV4dCgpLCBzaXplb2YoQ09OVEVYVCkpOwogCSAgZWxzZQotCSAgICB7
Ci0JICAgICAgLyogRklYTUU6IFJlYWxseSB0aGlzIHNob3VsZCBiZSB0aGUg
Y29udGV4dCB3aGljaCB0aGUgc2lnbmFsIGludGVycnVwdGVkPyAqLwotCSAg
ICAgIG1lbXNldCgmY29udGV4dC51Y19tY29udGV4dCwgMCwgc2l6ZW9mKHN0
cnVjdCBfX21jb250ZXh0KSk7Ci0JICAgICAgY29udGV4dC51Y19tY29udGV4
dC5jdHhmbGFncyA9IENPTlRFWFRfRlVMTDsKLQkgICAgICBSdGxDYXB0dXJl
Q29udGV4dCAoKENPTlRFWFQgKikmY29udGV4dC51Y19tY29udGV4dCk7Ci0J
ICAgIH0KKwkgICAgbWVtY3B5ICgmY29udGV4dC51Y19tY29udGV4dCwgJnRo
cmVhZF9jb250ZXh0LCBzaXplb2YoQ09OVEVYVCkpOwogCiAJICAvKiBGSVhN
RTogSWYvd2hlbiBzaWdhbHRzdGFjayBpcyBpbXBsZW1lbnRlZCwgdGhpcyB3
aWxsIG5lZWQgdG8gZG8KIAkgICAgIHNvbWV0aGluZyBtb3JlIGNvbXBsaWNh
dGVkICovCkBAIC0xNTQ5LDkgKzE1NDQsMTAgQEAgdm9pZAogX2N5Z3Rsczo6
c2lnbmFsX2RlYnVnZ2VyIChzaWdpbmZvX3QmIHNpKQogewogICBIQU5ETEUg
dGg7Ci0gIC8qIElmIHNpLnNpX2N5ZyBpcyBzZXQgdGhlbiB0aGUgc2lnbmFs
IHdhcyBhbHJlYWR5IHNlbnQgdG8gdGhlIGRlYnVnZ2VyLiAqLworICAvKiBJ
ZiBzaS5zaV9jeWcgaXMgc2V0IHRoZW4gdGhlIHNpZ25hbCB3YXMgY2F1c2Vk
IGJ5IGFuIGV4Y2VwdGlvbiB3aGljaCBoYXMKKyAgICAgYWxyZWFkeSBiZWVu
IHNlbnQgdG8gdGhlIGRlYnVnZ2VyLiAqLwogICBpZiAoaXNpbml0aWFsaXpl
ZCAoKSAmJiAhc2kuc2lfY3lnICYmICh0aCA9IChIQU5ETEUpICp0aGlzKQot
ICAgICAgJiYgYmVpbmdfZGVidWdnZWQgKCkgJiYgU3VzcGVuZFRocmVhZCAo
dGgpID49IDApCisgICAgICAmJiBTdXNwZW5kVGhyZWFkICh0aCkgPj0gMCkK
ICAgICB7CiAgICAgICBDT05URVhUIGM7CiAgICAgICBjLkNvbnRleHRGbGFn
cyA9IENPTlRFWFRfRlVMTDsKLS0gCjIuMS40Cgo=

--------------030203060101050308090201--
