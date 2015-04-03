Return-Path: <cygwin-patches-return-8117-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 119523 invoked by alias); 3 Apr 2015 22:09:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 119510 invoked by uid 89); 3 Apr 2015 22:09:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.3 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2
X-HELO: out4-smtp.messagingengine.com
Received: from out4-smtp.messagingengine.com (HELO out4-smtp.messagingengine.com) (66.111.4.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Fri, 03 Apr 2015 22:09:43 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])	by mailout.nyi.internal (Postfix) with ESMTP id 5286520612	for <cygwin-patches@cygwin.com>; Fri,  3 Apr 2015 18:09:37 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])  by compute5.internal (MEProxy); Fri, 03 Apr 2015 18:09:40 -0400
Received: from [192.168.1.102] (unknown [31.51.205.126])	by mail.messagingengine.com (Postfix) with ESMTPA id 5BA06C00015	for <cygwin-patches@cygwin.com>; Fri,  3 Apr 2015 18:09:40 -0400 (EDT)
Message-ID: <551F0FA2.2020304@dronecode.org.uk>
Date: Fri, 03 Apr 2015 22:09:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/3] Provide ucontext to signal handlers
References: <1427894373-2576-1-git-send-email-jon.turney@dronecode.org.uk> <1427894373-2576-3-git-send-email-jon.turney@dronecode.org.uk> <20150401142219.GY13285@calimero.vinschen.de>
In-Reply-To: <20150401142219.GY13285@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------040001030900090109070503"
X-SW-Source: 2015-q2/txt/msg00018.txt.bz2

This is a multi-part message in MIME format.
--------------040001030900090109070503
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1786

On 01/04/2015 15:22, Corinna Vinschen wrote:
> On Apr  1 14:19, Jon TURNEY wrote:
>> Add ucontext.h header, defining ucontext_t and mcontext_t types.
>>
>> Provide sigaction sighandlers with a ucontext_t parameter, containing stack and
>> context information.
>>
>> 	* include/sys/ucontext.h : New header.
>> 	* include/ucontext.h : Ditto.
>> 	* exceptions.cc (call_signal_handler): Provide ucontext_t
>> 	parameter to signal handler function.
>
> Patch is ok with a single change:  Please add a "FIXME?" comment to:
>
>    else
>      RtlCaptureContext();
>
> On second thought, calling RtlCaptureContext here is probably wrong.

Wrong and also dangerous.

This causes random crashes on x86.

It seems that RtlCaptureContext requires the framepointer of the calling 
function in ebp, which it uses to report the rip and rsp of it's caller.

It also seems that gcc can decide to optimize the setting of the 
framepointer away, irrespective of the fact that -fomit-frame-pointer is 
not used when building exceptions.cc

If _cygtls::call_signal_handler() happens to get called with ebp 
pointing to an invalid memory address, as seems to happen occasionally, 
we will fault in RtlCaptureContext.  (in all cases, the eip and ebp in 
the returned context are incorrect)

I wrote the attached patch, which fakes a callframe for 
RtlCaptureContext to avoid these possible crashes, but this needs more 
work to correctly report eip and ebp

However, I'm not sure that is worthwhile effort as it's heading in the 
wrong direction, because ....

> What we really need is the context of the thread when calling
> call_signal_handler I think.  It would be better to call RtlCaptureContext
> before calling call_signal_handler.  But this requires a change in how
> call_signal_handler is called.


--------------040001030900090109070503
Content-Type: text/plain; charset=windows-1252;
 name="0001-Avoid-random-crashes-in-RtlCaptureContext-on-x86.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Avoid-random-crashes-in-RtlCaptureContext-on-x86.patch"
Content-length: 3766

RnJvbSA2NDZlYzRjMmMxYmM4OWM0MjQzYjY5NjQzZjE3MmViMjBkNTg3NmMx
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKb24gVFVSTkVZIDxq
b24udHVybmV5QGRyb25lY29kZS5vcmcudWs+CkRhdGU6IEZyaSwgMyBBcHIg
MjAxNSAyMjoyNjoyMSArMDEwMApTdWJqZWN0OiBbUEFUQ0hdIEF2b2lkIHJh
bmRvbSBjcmFzaGVzIGluIFJ0bENhcHR1cmVDb250ZXh0IG9uIHg4NgoKUnRs
Q2FwdHVyZUNvbnRleHQgcmVxdWlyZXMgdGhlIGZyYW1lcG9pbnRlciBvZiB0
aGUgY2FsbGluZyBmdW5jdGlvbiBpbiBlYnAsCndoaWNoIGl0IHVzZXMgdG8g
cmVwb3J0IHRoZSByaXAgYW5kIHJzcCBvZiBpdCdzIGNhbGxlci4gQnV0IGl0
IHNlZW1zIHRoYXQgZ2NjCm1heSBkZWNpZGUgdG8gb3B0aW1pemUgdGhlIHNl
dHRpbmcgb2YgdGhlIGZyYW1lcG9pbnRlciBhd2F5LCBpcnJlc3BlY3RpdmUg
b2YKLWZvbWl0LWZyYW1lLXBvaW50ZXIuCgpJZiBfY3lndGxzOjpjYWxsX3Np
Z25hbF9oYW5kbGVyKCkgaXMgY2FsbGVkIHdpdGggZWJwIHBvaW50aW5nIHRv
IGFuIGludmFsaWQKbWVtb3J5IGFkZHJlc3MsIGFzIHNlZW1zIHRvIGhhcHBl
biBvY2Nhc2lvbmFsbHksIHdlIHdpbGwgZmF1bHQgaW4KUnRsQ2FwdHVyZUNv
bnRleHQuCgpUaGlzIHBhdGNoIG1hbnVhbGx5IGNyZWF0ZXMgYSBzdGNhbGwg
Y2FsbGZyYW1lIGFyb3VuZCBSdGxDYXB0dXJlQ29udGV4dCB0byBiZQpzYWZl
LCBidXQgSSdtIG5vdCBzdXJlIHRoYXQncyB0aGUgYmVzdCBhcHByb2FjaC4K
ClJ0bENhcHR1cmVDb250ZXh0IGRvZXMgc28gbGl0dGxlLCBpdCdzIHByb2Jh
Ymx5IGp1c3QgYXMgZWZmZWN0aXZlIHRvIHdyaXRlIG91cgpvd24gdmVyc2lv
bi4KClRoaXMgaXMgaGVhZGluZyBmdXJ0aGVyIGluIHRoZSB3cm9uZyBkaXJl
Y3Rpb24sIGFzIHRoZSBjb250ZXh0IHRoYXQgaXMgd2FudGVkCmlzbid0IHRo
ZSBjdXJyZW50IGNvbnRleHQsIGJ1dCB0aGUgY29udGV4dCBhdCB0aGUgdGlt
ZSBvZiB0aGUgc2lnbmFsLgoKVGhlcmUgYXJlIGEgY291cGxlIG9mIG90aGVy
IHVzZXMgb2YgUnRsQ2FwdHVyZUNvbnRleHQoKSwgYXJlIHRoZXkgb2s/Ci0t
LQogd2luc3VwL2N5Z3dpbi9leGNlcHRpb25zLmNjIHwgMjAgKysrKysrKysr
KysrKysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4v
ZXhjZXB0aW9ucy5jYyBiL3dpbnN1cC9jeWd3aW4vZXhjZXB0aW9ucy5jYwpp
bmRleCAwZDFmMzZkLi4wY2E2ZGQ4IDEwMDY0NAotLS0gYS93aW5zdXAvY3ln
d2luL2V4Y2VwdGlvbnMuY2MKKysrIGIvd2luc3VwL2N5Z3dpbi9leGNlcHRp
b25zLmNjCkBAIC0xNDk2LDggKzE0OTYsMjQgQEAgX2N5Z3Rsczo6Y2FsbF9z
aWduYWxfaGFuZGxlciAoKQogICAgICAgaWYgKHRoaXNzaS5zaV9jeWcpCiAg
ICAgICAgIG1lbWNweSAoJnRoaXNjb250ZXh0LnVjX21jb250ZXh0LCAoKGN5
Z3dpbl9leGNlcHRpb24gKil0aGlzc2kuc2lfY3lnKS0+Y29udGV4dCgpLCBz
aXplb2YoQ09OVEVYVCkpOwogICAgICAgZWxzZQotICAgICAgICBSdGxDYXB0
dXJlQ29udGV4dCAoKENPTlRFWFQgKikmdGhpc2NvbnRleHQudWNfbWNvbnRl
eHQpOwotICAgICAgICAvKiBGSVhNRTogUmVhbGx5IHRoaXMgc2hvdWxkIGJl
IHRoZSBjb250ZXh0IHdoaWNoIHRoZSBzaWduYWwgaW50ZXJydXB0ZWQ/ICov
CisgICAgICAgIHsKKyAgICAgICAgICAvKiBGSVhNRTogUmVhbGx5IHRoaXMg
c2hvdWxkIGJlIHRoZSBjb250ZXh0IHdoaWNoIHRoZSBzaWduYWwgaW50ZXJy
dXB0ZWQ/ICovCisjaWZkZWYgX194ODZfNjRfXworICAgICAgICAgIFJ0bENh
cHR1cmVDb250ZXh0ICgoQ09OVEVYVCAqKSZ0aGlzY29udGV4dC51Y19tY29u
dGV4dCk7CisjZWxzZQorICAgICAgICAgIG1lbXNldCgmdGhpc2NvbnRleHQu
dWNfbWNvbnRleHQsIDAsIHNpemVvZihzdHJ1Y3QgX19tY29udGV4dCkpOwor
ICAgICAgICAgIHRoaXNjb250ZXh0LnVjX21jb250ZXh0LmN0eGZsYWdzID0g
Q09OVEVYVF9GVUxMOworICAgICAgICAgIC8qIFJ0bENhcHR1cmVDb250ZXh0
IHJlcXVpcmVzIHRoZSBmcmFtZXBvaW50ZXIgb2YgdGhlIGNhbGxpbmcgZnVu
Y3Rpb24KKyAgICAgICAgICAgICBpbiBlYnAsIHdoaWNoIGl0IHVzZXMgdG8g
cmVwb3J0IHRoZSByaXAgYW5kIHJzcCBvZiBpdCdzIGNhbGxlci4KKyAgICAg
ICAgICAgICBCdXQgaXQgc2VlbXMgdGhhdCBnY2MgbWF5IGRlY2lkZSB0byBv
cHRpbWl6ZSB0aGUgc2V0dGluZyBvZiB0aGUKKyAgICAgICAgICAgICBmcmFt
ZXBvaW50ZXIgYXdheSwgaXJyZXNwZWN0aXZlIG9mIC1mb21pdC1mcmFtZS1w
b2ludGVyLiAgTWFudWFsbHkKKyAgICAgICAgICAgICBjcmVhdGUgYSBzdGNh
bGwgY2FsbGZyYW1lIHRvIGJlIHNhZmUuICovCisgICAgICAgICAgX19hc21f
XyAoICJtb3YgJSVlc3AsJSVlYnBcbiIKKyAgICAgICAgICAgICAgICAgICAg
InB1c2ggJTBcbiIKKyAgICAgICAgICAgICAgICAgICAgImNhbGwgX1J0bENh
cHR1cmVDb250ZXh0QDRcbiIKKyAgICAgICAgICAgICAgICAgICAgOiA6ICJy
IiAoJnRoaXNjb250ZXh0LnVjX21jb250ZXh0KSA6ICIlZWJwIiwgIiVlYXgi
LCAiJWVjeCIsICIlZWR4IiApOworI2VuZGlmCisgICAgICAgIH0KIAogICAg
ICAgLyogRklYTUU6IElmL3doZW4gc2lnYWx0c3RhY2sgaXMgaW1wbGVtZW50
ZWQsIHRoaXMgd2lsbCBuZWVkIHRvIGRvCiAgICAgICAgICBzb21ldGhpbmcg
bW9yZSBjb21wbGljYXRlZCAqLwotLSAKMi4xLjQKCg==

--------------040001030900090109070503--
