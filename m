Return-Path: <cygwin-patches-return-8119-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30538 invoked by alias); 4 Apr 2015 16:06:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 30519 invoked by uid 89); 4 Apr 2015 16:06:27 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.3 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2
X-HELO: out4-smtp.messagingengine.com
Received: from out4-smtp.messagingengine.com (HELO out4-smtp.messagingengine.com) (66.111.4.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Sat, 04 Apr 2015 16:06:24 +0000
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])	by mailout.nyi.internal (Postfix) with ESMTP id 71B84204D7	for <cygwin-patches@cygwin.com>; Sat,  4 Apr 2015 12:06:19 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])  by compute6.internal (MEProxy); Sat, 04 Apr 2015 12:06:23 -0400
Received: from [192.168.1.102] (unknown [31.51.205.126])	by mail.messagingengine.com (Postfix) with ESMTPA id 89B6FC00015	for <cygwin-patches@cygwin.com>; Sat,  4 Apr 2015 12:06:22 -0400 (EDT)
Message-ID: <55200BFB.4070303@dronecode.org.uk>
Date: Sat, 04 Apr 2015 16:06:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/3] Provide ucontext to signal handlers
References: <1427894373-2576-1-git-send-email-jon.turney@dronecode.org.uk> <1427894373-2576-3-git-send-email-jon.turney@dronecode.org.uk> <20150401142219.GY13285@calimero.vinschen.de> <551F0FA2.2020304@dronecode.org.uk> <20150404084014.GW13285@calimero.vinschen.de>
In-Reply-To: <20150404084014.GW13285@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------030406010704090609070504"
X-SW-Source: 2015-q2/txt/msg00020.txt.bz2

This is a multi-part message in MIME format.
--------------030406010704090609070504
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 2749

On 04/04/2015 09:40, Corinna Vinschen wrote:
> On Apr  3 23:09, Jon TURNEY wrote:
>> On 01/04/2015 15:22, Corinna Vinschen wrote:
>>> On Apr  1 14:19, Jon TURNEY wrote:
>>>> Add ucontext.h header, defining ucontext_t and mcontext_t types.
>>>>
>>>> Provide sigaction sighandlers with a ucontext_t parameter, containing stack and
>>>> context information.
>>>>
>>>> 	* include/sys/ucontext.h : New header.
>>>> 	* include/ucontext.h : Ditto.
>>>> 	* exceptions.cc (call_signal_handler): Provide ucontext_t
>>>> 	parameter to signal handler function.
>>>
>>> Patch is ok with a single change:  Please add a "FIXME?" comment to:
>>>
>>>    else
>>>      RtlCaptureContext();
>>>
>>> On second thought, calling RtlCaptureContext here is probably wrong.
>>
>> Wrong and also dangerous.
>>
>> This causes random crashes on x86.
>>
>> It seems that RtlCaptureContext requires the framepointer of the calling
>> function in ebp, which it uses to report the rip and rsp of it's caller.
>>
>> It also seems that gcc can decide to optimize the setting of the
>> framepointer away, irrespective of the fact that -fomit-frame-pointer is not
>> used when building exceptions.cc
>>
>> If _cygtls::call_signal_handler() happens to get called with ebp pointing to
>> an invalid memory address, as seems to happen occasionally, we will fault in
>> RtlCaptureContext.  (in all cases, the eip and ebp in the returned context
>> are incorrect)
>>
>> I wrote the attached patch, which fakes a callframe for RtlCaptureContext to
>> avoid these possible crashes, but this needs more work to correctly report
>> eip and ebp
>
> Maybe it's simpler than that?  Looking into the GCC info pages, I found
> this:
>
>       Starting with GCC version 4.6, the default setting (when not
>       optimizing for size) for 32-bit GNU/Linux x86 and 32-bit Darwin x86
>       targets has been changed to '-fomit-frame-pointer'.  The default
>       can be reverted to '-fno-omit-frame-pointer' by configuring GCC
>       with the '--enable-frame-pointer' configure option.
>
>       Enabled at levels '-O', '-O2', '-O3', '-Os'.
>       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Very good.  I hadn't noticed that sentence and was just looking at the 
"-O also turns on -fomit-frame-pointer on machines where doing so does 
not interfere with debugging. "

> So it seems adding -fomit-frame-pointer file by file in Makefile.in
> (when building with -O2) is moot and only has an effect when building
> unoptimized, otherwise all files are built with -fomit-frame-pointer
> anyway.
>
> So, what if we drop all the -fomit-frame-pointer from Makefile.in and
> add an
>
>    exceptions_CFLAGS:=-fno-omit-frame-pointer
>
> Does that help?

Yes, that seems to do the trick.  Patch attached.


--------------030406010704090609070504
Content-Type: text/plain; charset=windows-1252;
 name="0001-Compile-exceptions.cc-with-fno-omit-frame-pointer-on.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Compile-exceptions.cc-with-fno-omit-frame-pointer-on.pa";
 filename*1="tch"
Content-length: 5763

RnJvbSBjZDg1MzI4MzJjOTJkMTBjMWEzYzFmYjllYzcwNWRmMGVhMDAzZTI4
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKb24gVFVSTkVZIDxq
b24udHVybmV5QGRyb25lY29kZS5vcmcudWs+CkRhdGU6IFNhdCwgNCBBcHIg
MjAxNSAxNjoxODo1NiArMDEwMApTdWJqZWN0OiBbUEFUQ0hdIENvbXBpbGUg
ZXhjZXB0aW9ucy5jYyB3aXRoIC1mbm8tb21pdC1mcmFtZS1wb2ludGVyIG9u
IHg4NgoKU2VsZWN0aXZlbHkgdXNpbmcgLWZvbWl0LWZyYW1lLXBvaW50ZXIg
d2hlbiAtTyBpcyB1c2VkIGRvZXNuJ3QgbWFrZSBzZW5zZQphbnltb3JlLCBh
cHBhcmVudGx5IHNpbmNlIGdjYyA0LjYsIC1PIGltcGxpZXMgLWZvbWl0LWZy
YW1lLXBvaW50ZXIuCgpleGNlcHRpb25zLmNjIG11c3QgYmUgY29tcGlsZWQg
d2l0aCAtZm5vLW9taXQtZnJhbWUtcG9pbnRlciBvbiB4ODYsIGFzIGl0IHVz
ZXMKUnRsQ2FwdHVyZUNvbnRleHQsIHdoaWNoIHJlcXVpcmVzIGEgZnJhbWUg
cG9pbnRlci4KCgkqIE1ha2VmaWxlLmluIDogUmVtb3ZlIHNldHRpbmcgLWZv
bWl0LWZyYW1lLXBvaW50ZXIgZm9yIGNvbXBpbGluZwoJdmFyaW91cyBmaWxl
cywgaXQgaXMgYWxyZWFkeSB0aGUgZGVmYXVsdC4gIFNldAoJLWZuby1vbWl0
LWZyYW1lLXBvaW50ZXIgZm9yIGV4Y2VwdGlvbnMuY2Mgb24geDg2LgoKU2ln
bmVkLW9mZi1ieTogSm9uIFRVUk5FWSA8am9uLnR1cm5leUBkcm9uZWNvZGUu
b3JnLnVrPgotLS0KIHdpbnN1cC9jeWd3aW4vQ2hhbmdlTG9nICAgfCAgNiAr
KysrKwogd2luc3VwL2N5Z3dpbi9NYWtlZmlsZS5pbiB8IDU3ICsrKystLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAyIGZp
bGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDUzIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vQ2hhbmdlTG9nIGIvd2lu
c3VwL2N5Z3dpbi9DaGFuZ2VMb2cKaW5kZXggNWFkYTM1ZC4uYThmNGUwMCAx
MDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9DaGFuZ2VMb2cKKysrIGIvd2lu
c3VwL2N5Z3dpbi9DaGFuZ2VMb2cKQEAgLTEsMyArMSw5IEBACisyMDE1LTA0
LTA0ICBKb24gVFVSTkVZICA8am9uLnR1cm5leUBkcm9uZWNvZGUub3JnLnVr
PgorCisJKiBNYWtlZmlsZS5pbiA6IFJlbW92ZSBzZXR0aW5nIC1mb21pdC1m
cmFtZS1wb2ludGVyIGZvciBjb21waWxpbmcKKwl2YXJpb3VzIGZpbGVzLCBp
dCBpcyBhbHJlYWR5IHRoZSBkZWZhdWx0LiAgU2V0CisJLWZuby1vbWl0LWZy
YW1lLXBvaW50ZXIgZm9yIGV4Y2VwdGlvbnMuY2Mgb24geDg2LgorCiAyMDE1
LTA0LTAzICBUYWthc2hpIFlhbm8gIDx0YWthc2hpLnlhbm9AbmlmdHkubmUu
anA+CiAKIAkqIGZoYW5kbGVyX3R0eS5jYyAoZmhhbmRsZXJfcHR5X3NsYXZl
OjpyZWFkKTogQ2hhbmdlIGNhbGN1bGF0aW9uIG9mCmRpZmYgLS1naXQgYS93
aW5zdXAvY3lnd2luL01ha2VmaWxlLmluIGIvd2luc3VwL2N5Z3dpbi9NYWtl
ZmlsZS5pbgppbmRleCA5YjgyZjBhLi5hZjlmYWY2IDEwMDY0NAotLS0gYS93
aW5zdXAvY3lnd2luL01ha2VmaWxlLmluCisrKyBiL3dpbnN1cC9jeWd3aW4v
TWFrZWZpbGUuaW4KQEAgLTQ0OSw1OSArNDQ5LDEwIEBAIElOU1RPQkpTOj1h
dXRvbW9kZS5vIGJpbm1vZGUubyB0ZXh0bW9kZS5vIHRleHRyZWFkbW9kZS5v
CiBUQVJHRVRfTElCUzo9JChMSUJfTkFNRSkgJChDWUdXSU5fU1RBUlQpICQo
R01PTl9TVEFSVCkgJChMSUJHTU9OX0EpICQoU1VCTElCUykgJChJTlNUT0JK
UykgJChFWFRSQUxJQlMpCiAKIGlmbmVxICIke2ZpbHRlciAtTyUsJChDRkxB
R1MpfSIgIiIKLWN5Z2hlYXBfQ0ZMQUdTOj0tZm9taXQtZnJhbWUtcG9pbnRl
cgotY3lndGhyZWFkX0NGTEFHUzo9LWZvbWl0LWZyYW1lLXBvaW50ZXIKLWN5
Z3Rsc19DRkxBR1M6PS1mb21pdC1mcmFtZS1wb2ludGVyCi1jeWd3YWl0X0NG
TEFHUz0tZm9taXQtZnJhbWUtcG9pbnRlcgotZGVscXVldWVfQ0ZMQUdTOj0t
Zm9taXQtZnJhbWUtcG9pbnRlcgotZGV2aWNlc19DRkxBR1M6PS1mb21pdC1m
cmFtZS1wb2ludGVyCi1kaXJfQ0ZMQUdTOj0tZm9taXQtZnJhbWUtcG9pbnRl
cgotZGxmY25fQ0ZMQUdTOj0tZm9taXQtZnJhbWUtcG9pbnRlcgotZGxsX2lu
aXRfQ0ZMQUdTOj0tZm9taXQtZnJhbWUtcG9pbnRlcgotZHRhYmxlX0NGTEFH
Uzo9LWZvbWl0LWZyYW1lLXBvaW50ZXIgLWZjaGVjay1uZXcKLWZjbnRsX0NG
TEFHUzo9LWZvbWl0LWZyYW1lLXBvaW50ZXIKLWZlbnZfQ0ZMQUdTOj0tZm9t
aXQtZnJhbWUtcG9pbnRlcgotZmhhbmRsZXJfQ0ZMQUdTOj0tZm9taXQtZnJh
bWUtcG9pbnRlcgotZmhhbmRsZXJfY2xpcGJvYXJkX0NGTEFHUzo9LWZvbWl0
LWZyYW1lLXBvaW50ZXIKLWZoYW5kbGVyX2NvbnNvbGVfQ0ZMQUdTOj0tZm9t
aXQtZnJhbWUtcG9pbnRlcgotZmhhbmRsZXJfZGlza19maWxlX0NGTEFHUzo9
LWZvbWl0LWZyYW1lLXBvaW50ZXIKLWZoYW5kbGVyX2RzcF9DRkxBR1M6PS1m
b21pdC1mcmFtZS1wb2ludGVyCi1maGFuZGxlcl9mbG9wcHlfQ0ZMQUdTOj0t
Zm9taXQtZnJhbWUtcG9pbnRlcgotZmhhbmRsZXJfbmV0ZHJpdmVfQ0ZMQUdT
Oj0tZm9taXQtZnJhbWUtcG9pbnRlcgotZmhhbmRsZXJfcHJvY19DRkxBR1M6
PS1mb21pdC1mcmFtZS1wb2ludGVyCi1maGFuZGxlcl9wcm9jZXNzX0NGTEFH
Uzo9LWZvbWl0LWZyYW1lLXBvaW50ZXIKLWZoYW5kbGVyX3JhbmRvbV9DRkxB
R1M6PS1mb21pdC1mcmFtZS1wb2ludGVyCi1maGFuZGxlcl9yYXdfQ0ZMQUdT
Oj0tZm9taXQtZnJhbWUtcG9pbnRlcgotZmhhbmRsZXJfcmVnaXN0cnlfQ0ZM
QUdTOj0tZm9taXQtZnJhbWUtcG9pbnRlcgotZmhhbmRsZXJfc2VyaWFsX0NG
TEFHUzo9LWZvbWl0LWZyYW1lLXBvaW50ZXIKLWZoYW5kbGVyX3NvY2tldF9D
RkxBR1M6PS1mb21pdC1mcmFtZS1wb2ludGVyCi1maGFuZGxlcl9zeXNsb2df
Q0ZMQUdTOj0tZm9taXQtZnJhbWUtcG9pbnRlcgotZmhhbmRsZXJfdGFwZV9D
RkxBR1M6PS1mb21pdC1mcmFtZS1wb2ludGVyCi1maGFuZGxlcl90ZXJtaW9z
X0NGTEFHUzo9LWZvbWl0LWZyYW1lLXBvaW50ZXIKLWZoYW5kbGVyX3R0eV9D
RkxBR1M6PS1mb21pdC1mcmFtZS1wb2ludGVyCi1maGFuZGxlcl92aXJ0dWFs
X0NGTEFHUzo9LWZvbWl0LWZyYW1lLXBvaW50ZXIKLWZoYW5kbGVyX3dpbmRv
d3NfQ0ZMQUdTOj0tZm9taXQtZnJhbWUtcG9pbnRlcgotZmhhbmRsZXJfemVy
b19DRkxBR1M6PS1mb21pdC1mcmFtZS1wb2ludGVyCi1mbG9ja19DRkxBR1M6
PS1mb21pdC1mcmFtZS1wb2ludGVyCi1ncnBfQ0ZMQUdTOj0tZm9taXQtZnJh
bWUtcG9pbnRlcgotbGlic3RkY3h4X3dyYXBwZXJfQ0ZMQUdTOj0tZm9taXQt
ZnJhbWUtcG9pbnRlcgotbG9jYWx0aW1lX0NGTEFHUzo9LWZ3cmFwdgotbWFs
bG9jX0NGTEFHUzo9LWZvbWl0LWZyYW1lLXBvaW50ZXIgLU8zCi1tYWxsb2Nf
d3JhcHBlcl9DRkxBR1M6PS1mb21pdC1mcmFtZS1wb2ludGVyCi1taXNjZnVu
Y3NfQ0ZMQUdTOj0tZm9taXQtZnJhbWUtcG9pbnRlcgotbmV0X0NGTEFHUzo9
LWZvbWl0LWZyYW1lLXBvaW50ZXIKLXBhc3N3ZF9DRkxBR1M6PS1mb21pdC1m
cmFtZS1wb2ludGVyCi1wYXRoX0NGTEFHUz0tZm9taXQtZnJhbWUtcG9pbnRl
cgotcmVnY29tcF9DRkxBR1M9LWZvbWl0LWZyYW1lLXBvaW50ZXIKLXJlZ2Vy
cm9yX0NGTEFHUz0tZm9taXQtZnJhbWUtcG9pbnRlcgotcmVnZXhlY19DRkxB
R1M9LWZvbWl0LWZyYW1lLXBvaW50ZXIKLXJlZ2ZyZWVfQ0ZMQUdTPS1mb21p
dC1mcmFtZS1wb2ludGVyCi1zaGFyZWRfQ0ZMQUdTOj0tZm9taXQtZnJhbWUt
cG9pbnRlcgotc3luY19DRkxBR1M6PS1mb21pdC1mcmFtZS1wb2ludGVyIC1P
Mwotc21hbGxwcmludF9DRkxBR1M6PS1mb21pdC1mcmFtZS1wb2ludGVyCi1z
eXNjYWxsc19DRkxBR1M6PS1mb21pdC1mcmFtZS1wb2ludGVyCi1zeXNjb25m
X0NGTEFHUzo9LWZvbWl0LWZyYW1lLXBvaW50ZXIKLXVpbmZvX0NGTEFHUzo9
LWZvbWl0LWZyYW1lLXBvaW50ZXIKK2lmZXEgKCQodGFyZ2V0X2NwdSksaTY4
NikKKyMgb24geDg2LCBleGNlcHRpb25zLmNjIG11c3QgYmUgY29tcGlsZWQg
d2l0aCBhIGZyYW1lLXBvaW50ZXIgYXMgaXQgdXNlcyBSdGxDYXB0dXJlQ29u
dGV4dCgpCitleGNlcHRpb25zX0NGTEFHUzo9LWZuby1vbWl0LWZyYW1lLXBv
aW50ZXIKK2VuZGlmCiBlbmRpZgogCiBmaGFuZGxlcl9wcm9jX0NGTEFHUys9
LURVU0VSTkFNRT0iXCIkKFVTRVIpXCIiIC1ESE9TVE5BTUU9IlwiJChIT1NU
TkFNRSlcIiIKLS0gCjIuMS40Cgo=

--------------030406010704090609070504--
