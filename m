Return-Path: <SRS0=arxq=IZ=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout12.t-online.de (mailout12.t-online.de [194.25.134.22])
	by sourceware.org (Postfix) with ESMTPS id 33B9438582AA
	for <cygwin-patches@cygwin.com>; Mon, 15 Jan 2024 11:19:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 33B9438582AA
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 33B9438582AA
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.22
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1705317599; cv=none;
	b=sYgIQPaCGVTbyCITSEO27nydeoU6X5Ke9DJKI8CWpphXNF36INzrUo08O7p62s0gvHc8F4pzOutxoRALmI2d0465KiGEPVaikhxGUQ+hSniNQ6WoajEGa6iaRGMaAZHC+ZM0gZxZLhJkmrazBtqID5xuMOuS6MbXSY/pzd0/ruk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1705317599; c=relaxed/simple;
	bh=aL5zXaqHbQQ+ObHpUaOxoVO60XUlSddPuDel8jTI92I=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=klL3wJaPCCTTjcJ6HG+HvzE1uCeNyKDoQxMQ2gqLaXmmoYuTkir5elnAWaixVgrg0C4DGk1dOqW9X6JryuMGtrwDMyt5dS6GMQHy//1I3v/JAIY9O4Wng+ZiSO5h5BpMYst/Rbe5yd7V/LwdtZvFHPKNlocZKZF5t/DK4i9X4wM=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from fwd82.aul.t-online.de (fwd82.aul.t-online.de [10.223.144.108])
	by mailout12.t-online.de (Postfix) with SMTP id 6E7C1121B6
	for <cygwin-patches@cygwin.com>; Mon, 15 Jan 2024 12:19:55 +0100 (CET)
Received: from [192.168.2.104] ([79.230.174.55]) by fwd82.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1rPL0U-0F478a0; Mon, 15 Jan 2024 12:19:54 +0100
Subject: Re: [PATCH] Cygwin: introduce close_range
To: cygwin-patches@cygwin.com
References: <83cfd6b3-6824-fd9f-794b-7fc428f8c80d@t-online.de>
 <3ab13e94-fd3a-41c8-8392-fcd72042d0e9@dronecode.org.uk>
 <6b1723b1-12b1-a240-ff22-1f0f5ba73214@t-online.de>
 <2443ab23-4c2f-bf99-c38e-8410e642fe1f@t-online.de>
 <ZaUMpz2oUXpokdAk@calimero.vinschen.de>
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <7e7efac7-95fe-6d2c-db78-6dd892f93030@t-online.de>
Date: Mon, 15 Jan 2024 12:19:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.16
MIME-Version: 1.0
In-Reply-To: <ZaUMpz2oUXpokdAk@calimero.vinschen.de>
Content-Type: multipart/mixed;
 boundary="------------EC77113C78EB6002CB4F59FA"
X-TOI-EXPURGATEID: 150726::1705317594-D1FF8954-2B80C085/0/0 CLEAN NORMAL
X-TOI-MSGID: 2720ce88-4d1d-46fc-89f0-4dfdbc5d1de1
X-Spam-Status: No, score=-13.1 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_SHORT,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------EC77113C78EB6002CB4F59FA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Corinna Vinschen wrote:
> Hi Christian,
>
> On Jan 15 09:56, Christian Franke wrote:
>> Christian Franke wrote:
>>> Jon Turney wrote:
>>>> On 14/01/2024 16:07, Christian Franke wrote:
>>>>> Recently I learned about the existence and usefulness of close_range():
>>>>> https://github.com/smartmontools/smartmontools/issues/235
>>>>>
>>>>> https://man.freebsd.org/cgi/man.cgi?query=close_range&sektion=2
>>>>> https://man7.org/linux/man-pages/man2/close_range.2.html
>>>>>
>>>>> Note that the above Linux man page is not fully correct. The
>>>>> include file "linux/close_range.h" exists, but provides only the
>>>>> defines. It is sufficient to include "unistd.h" as on FreeBSD.
>>>>>
>>>>> The attached patch adds this to Cygwin. It does not implement
>>>>> the Linux-specific CLOSE_RANGE_UNSHARE as I have no idea how to
>>>>> do this :-)
>>>> This API should also be mentioned in the
>>>> "System interfaces compatible with GNU or Linux extensions" section
>>>> of doc/posix.xml
>>>>
>>>>
>>> Thanks for the info. I used the recent "Cygwin: introduce fallocate(2)"
>>> patch as a blueprint for which other files should be changed (fallocate
>>> is also missing in the posix.xml file).
>>>
>>> I will provide a new patch soon which also fixes an unlikely but
>>> possible corner case: Pass a value larger than MAX_INT as lower limit.
>>>
>> Attached. I also decided to simply ignore CLOSE_RANGE_UNSHARE for now.
> After reading up on this issue, I think we should not ignore
> CLOSE_RANGE_UNSHARE, but quite explicitely not implement it as a valid
> flag.
>
> The whole idea behind CLOSE_RANGE_UNSHARE depends on the way the Linux
> kernel creates threads and (forked) processes and the fact that it has a
> wide range of ways to share parts of the execution context between
> parent and child process/thread.
>
> So on Linux, a process/thread can actually decide if they share or not
> share the descriptor table with the created process/thread.  That's
> what the CLONE_FILES flag to clone(2) and unshare(2) manage.
>
> However, just as in FreeBSD, there's no such thing in Cygwin.  Threads
> always share descriptors, processes never share file desriptors.
>
> The bottom line is, I think the decision of the FreeBSD developer not to
> expose the CLOSE_RANGE_UNSHARE flag at all, was the right decision.
>
> We should not claim that we even remotely have a way of doing this
> the Linux way.
>
> Does that make sense?

Yes - new patch attached.


--------------EC77113C78EB6002CB4F59FA
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-introduce-close_range-2.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Cygwin-introduce-close_range-2.patch"

RnJvbSAzZDUzOGEzNTczMmIxZThjZDNkN2U3OTIxZTA2ZGZkZmZjNmQyOGRiIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBNb24sIDE1IEphbiAyMDI0IDEyOjEzOjMwICswMTAw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBpbnRyb2R1Y2UgY2xvc2VfcmFuZ2UoMikKClRo
aXMgZnVuY3Rpb24gY2xvc2VzIG9yIHNldHMgdGhlIGNsb3NlLW9uLWV4ZWMgZmxhZyBmb3Ig
YSBzcGVjaWZpZWQKcmFuZ2Ugb2YgZmlsZSBkZXNjcmlwdG9ycy4gIEl0IGlzIGF2YWlsYWJs
ZSBvbiBGcmVlQlNEIGFuZCBMaW51eC4KClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBGcmFu
a2UgPGNocmlzdGlhbi5mcmFua2VAdC1vbmxpbmUuZGU+Ci0tLQogbmV3bGliL2xpYmMvaW5j
bHVkZS9zeXMvdW5pc3RkLmggICAgICAgfCAgNiArKysrCiB3aW5zdXAvY3lnd2luL2N5Z3dp
bi5kaW4gICAgICAgICAgICAgICB8ICAxICsKIHdpbnN1cC9jeWd3aW4vaW5jbHVkZS9jeWd3
aW4vdmVyc2lvbi5oIHwgIDMgKy0KIHdpbnN1cC9jeWd3aW4vcmVsZWFzZS8zLjUuMCAgICAg
ICAgICAgIHwgIDIgKysKIHdpbnN1cC9jeWd3aW4vc3lzY2FsbHMuY2MgICAgICAgICAgICAg
IHwgNDIgKysrKysrKysrKysrKysrKysrKysrKysrKysKIHdpbnN1cC9kb2MvbmV3LWZlYXR1
cmVzLnhtbCAgICAgICAgICAgIHwgIDQgKysrCiB3aW5zdXAvZG9jL3Bvc2l4LnhtbCAgICAg
ICAgICAgICAgICAgICB8ICA1ICsrKwogNyBmaWxlcyBjaGFuZ2VkLCA2MiBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvbmV3bGliL2xpYmMvaW5jbHVkZS9z
eXMvdW5pc3RkLmggYi9uZXdsaWIvbGliYy9pbmNsdWRlL3N5cy91bmlzdGQuaAppbmRleCAy
NTUzMjI1MWMuLjAwOTAxNTQwZiAxMDA2NDQKLS0tIGEvbmV3bGliL2xpYmMvaW5jbHVkZS9z
eXMvdW5pc3RkLmgKKysrIGIvbmV3bGliL2xpYmMvaW5jbHVkZS9zeXMvdW5pc3RkLmgKQEAg
LTI2LDYgKzI2LDEyIEBAIGludCAgICAgY2hvd24gKGNvbnN0IGNoYXIgKl9fcGF0aCwgdWlk
X3QgX19vd25lciwgZ2lkX3QgX19ncm91cCk7CiBpbnQgICAgIGNocm9vdCAoY29uc3QgY2hh
ciAqX19wYXRoKTsKICNlbmRpZgogaW50ICAgICBjbG9zZSAoaW50IF9fZmlsZGVzKTsKKyNp
ZiBkZWZpbmVkKF9fQ1lHV0lOX18pICYmIChfX0JTRF9WSVNJQkxFIHx8IF9fR05VX1ZJU0lC
TEUpCisvKiBBdmFpbGFibGUgb24gRnJlZUJTRCAoX19CU0RfVklTSUJMRSkgYW5kIExpbnV4
IChfX0dOVV9WSVNJQkxFKS4gKi8KK2ludCAgICAgY2xvc2VfcmFuZ2UgKHVuc2lnbmVkIGlu
dCBfX2ZpcnN0ZmQsIHVuc2lnbmVkIGludCBfX2xhc3RmZCwgaW50IF9fZmxhZ3MpOworLyog
ICAgICBDTE9TRV9SQU5HRV9VTlNIQVJFICgxIDw8IDEpICovIC8qIExpbnV4LXNwZWNpZmlj
LCBub3Qgc3VwcG9ydGVkLiAqLworI2RlZmluZSBDTE9TRV9SQU5HRV9DTE9FWEVDICgxIDw8
IDIpCisjZW5kaWYKICNpZiBfX1BPU0lYX1ZJU0lCTEUgPj0gMTk5MjA5CiBzaXplX3QJY29u
ZnN0ciAoaW50IF9fbmFtZSwgY2hhciAqX19idWYsIHNpemVfdCBfX2xlbik7CiAjZW5kaWYK
ZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vY3lnd2luLmRpbiBiL3dpbnN1cC9jeWd3aW4v
Y3lnd2luLmRpbgppbmRleCA5Yjc2Y2U2N2EuLjllMzU0YWNjNiAxMDA2NDQKLS0tIGEvd2lu
c3VwL2N5Z3dpbi9jeWd3aW4uZGluCisrKyBiL3dpbnN1cC9jeWd3aW4vY3lnd2luLmRpbgpA
QCAtMzQ3LDYgKzM0Nyw3IEBAIGNsb2cxMGwgTk9TSUdGRQogY2xvZ2YgTk9TSUdGRQogY2xv
Z2wgTk9TSUdGRQogY2xvc2UgU0lHRkUKK2Nsb3NlX3JhbmdlIFNJR0ZFCiBjbG9zZWRpciBT
SUdGRQogY2xvc2Vsb2cgU0lHRkUKIGNuZF9icm9hZGNhc3QgU0lHRkUKZGlmZiAtLWdpdCBh
L3dpbnN1cC9jeWd3aW4vaW5jbHVkZS9jeWd3aW4vdmVyc2lvbi5oIGIvd2luc3VwL2N5Z3dp
bi9pbmNsdWRlL2N5Z3dpbi92ZXJzaW9uLmgKaW5kZXggYzgxNzdjMmIxLi4zMDM2ODc4YzQg
MTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vaW5jbHVkZS9jeWd3aW4vdmVyc2lvbi5oCisr
KyBiL3dpbnN1cC9jeWd3aW4vaW5jbHVkZS9jeWd3aW4vdmVyc2lvbi5oCkBAIC00ODQsMTIg
KzQ4NCwxMyBAQCBkZXRhaWxzLiAqLwogICAzNDc6IEFkZCBjMTZydG9tYiwgYzMycnRvbWIs
IG1icnRvYzE2LCBtYnJ0b2MzMi4KICAgMzQ4OiBBZGQgYzhydG9tYiwgbWJydG9jLgogICAz
NDk6IEFkZCBmYWxsb2NhdGUuCisgIDM1MDogQWRkIGNsb3NlX3JhbmdlLgogCiAgIE5vdGUg
dGhhdCB3ZSBmb3Jnb3QgdG8gYnVtcCB0aGUgYXBpIGZvciB1YWxhcm0sIHN0cnRvbGwsIHN0
cnRvdWxsLAogICBzaWdhbHRzdGFjaywgc2V0aG9zdG5hbWUuICovCiAKICNkZWZpbmUgQ1lH
V0lOX1ZFUlNJT05fQVBJX01BSk9SIDAKLSNkZWZpbmUgQ1lHV0lOX1ZFUlNJT05fQVBJX01J
Tk9SIDM0OQorI2RlZmluZSBDWUdXSU5fVkVSU0lPTl9BUElfTUlOT1IgMzUwCiAKIC8qIFRo
ZXJlIGlzIGFsc28gYSBjb21wYXRpYml0eSB2ZXJzaW9uIG51bWJlciBhc3NvY2lhdGVkIHdp
dGggdGhlIHNoYXJlZCBtZW1vcnkKICAgIHJlZ2lvbnMuICBJdCBpcyBpbmNyZW1lbnRlZCB3
aGVuIGluY29tcGF0aWJsZSBjaGFuZ2VzIGFyZSBtYWRlIHRvIHRoZSBzaGFyZWQKZGlmZiAt
LWdpdCBhL3dpbnN1cC9jeWd3aW4vcmVsZWFzZS8zLjUuMCBiL3dpbnN1cC9jeWd3aW4vcmVs
ZWFzZS8zLjUuMAppbmRleCBkMGE2YzJmYzguLjYyMDkwNjRhNiAxMDA2NDQKLS0tIGEvd2lu
c3VwL2N5Z3dpbi9yZWxlYXNlLzMuNS4wCisrKyBiL3dpbnN1cC9jeWd3aW4vcmVsZWFzZS8z
LjUuMApAQCAtNDMsNiArNDMsOCBAQCBXaGF0J3MgbmV3OgogCiAtIE5ldyBBUEkgY2FsbHM6
IGM4cnRvbWIsIGMxNnJ0b21iLCBjMzJydG9tYiwgbWJydG9jOCwgbWJydG9jMTYsIG1icnRv
YzMyLgogCistIE5ldyBBUEkgY2FsbDogY2xvc2VfcmFuZ2UgKGF2YWlsYWJsZSBvbiBGcmVl
QlNEIGFuZCBMaW51eCkuCisKIC0gTmV3IEFQSSBjYWxsOiBmYWxsb2NhdGUgKExpbnV4LXNw
ZWNpZmljKS4KIAogLSBJbXBsZW1lbnQgT1NTLWJhc2VkIHNvdW5kIG1peGVyIGRldmljZSAo
L2Rldi9taXhlcikuCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL3N5c2NhbGxzLmNjIGIv
d2luc3VwL2N5Z3dpbi9zeXNjYWxscy5jYwppbmRleCA0ODZkYjFkYjYuLjlkODhiNjBiMCAx
MDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9zeXNjYWxscy5jYworKysgYi93aW5zdXAvY3ln
d2luL3N5c2NhbGxzLmNjCkBAIC04NSw2ICs4NSw0OCBAQCBjbG9zZV9hbGxfZmlsZXMgKGJv
b2wgbm9yZWxlYXNlKQogICBjeWdoZWFwLT5mZHRhYi51bmxvY2sgKCk7CiB9CiAKKy8qIENs
b3NlIG9yIHNldCB0aGUgY2xvc2Utb24tZXhlYyBmbGFnIGZvciBhbGwgb3BlbiBmaWxlIGRl
c2NyaXB0b3JzCisgICBmcm9tIGZpcnN0ZmQgdG8gbGFzdGZkLiAgQ0xPU0VfUkFOR0VfVU5T
SEFSRSBpcyBub3Qgc3VwcG9ydGVkLgorICAgQXZhaWxhYmxlIG9uIEZyZWVCU0Qgc2luY2Ug
MTMgYW5kIExpbnV4IHNpbmNlIDUuOSAqLworZXh0ZXJuICJDIiBpbnQKK2Nsb3NlX3Jhbmdl
ICh1bnNpZ25lZCBpbnQgZmlyc3RmZCwgdW5zaWduZWQgaW50IGxhc3RmZCwgaW50IGZsYWdz
KQoreworICBwdGhyZWFkX3Rlc3RjYW5jZWwgKCk7CisKKyAgaWYgKCEoZmlyc3RmZCA8PSBs
YXN0ZmQgJiYgIShmbGFncyAmIH5DTE9TRV9SQU5HRV9DTE9FWEVDKSkpCisgICAgeworICAg
ICAgc2V0X2Vycm5vIChFSU5WQUwpOworICAgICAgcmV0dXJuIC0xOworICAgIH0KKworICBj
eWdoZWFwLT5mZHRhYi5sb2NrICgpOworCisgIHVuc2lnbmVkIGludCBzaXplID0gKGxhc3Rm
ZCA8IGN5Z2hlYXAtPmZkdGFiLnNpemUgPyBsYXN0ZmQgKyAxIDoKKwkJICAgICAgY3lnaGVh
cC0+ZmR0YWIuc2l6ZSk7CisKKyAgZm9yICh1bnNpZ25lZCBpbnQgaSA9IGZpcnN0ZmQ7IGkg
PCBzaXplOyBpKyspCisgICAgeworICAgICAgY3lnaGVhcF9mZGdldCBjZmQgKChpbnQpIGks
IGZhbHNlLCBmYWxzZSk7CisgICAgICBpZiAoY2ZkIDwgMCkKKwljb250aW51ZTsKKworICAg
ICAgaWYgKGZsYWdzICYgQ0xPU0VfUkFOR0VfQ0xPRVhFQykKKwl7CisJICBzeXNjYWxsX3By
aW50ZiAoInNldCBGRF9DTE9FWEVDIG9uIGZkICV1IiwgaSk7CisJICBjZmQtPmZjbnRsIChG
X1NFVEZELCBGRF9DTE9FWEVDKTsKKwl9CisgICAgICBlbHNlCisJeworCSAgc3lzY2FsbF9w
cmludGYgKCJjbG9zaW5nIGZkICV1IiwgaSk7CisJICBjZmQtPmNsb3NlX3dpdGhfYXJjaCAo
KTsKKwkgIGNmZC5yZWxlYXNlICgpOworCX0KKyAgICB9CisKKyAgY3lnaGVhcC0+ZmR0YWIu
dW5sb2NrICgpOworICByZXR1cm4gMDsKK30KKwogZXh0ZXJuICJDIiBpbnQKIGR1cCAoaW50
IGZkKQogewpkaWZmIC0tZ2l0IGEvd2luc3VwL2RvYy9uZXctZmVhdHVyZXMueG1sIGIvd2lu
c3VwL2RvYy9uZXctZmVhdHVyZXMueG1sCmluZGV4IDZhZTQyMDAzMS4uMGFiZTFjNDFjIDEw
MDY0NAotLS0gYS93aW5zdXAvZG9jL25ldy1mZWF0dXJlcy54bWwKKysrIGIvd2luc3VwL2Rv
Yy9uZXctZmVhdHVyZXMueG1sCkBAIC03NCw2ICs3NCwxMCBAQCBwb3NpeF9zcGF3bl9maWxl
X2FjdGlvbnNfYWRkZmNoZGlyX25wLgogTmV3IEFQSSBjYWxsczogYzhydG9tYiwgYzE2cnRv
bWIsIGMzMnJ0b21iLCBtYnJ0b2M4LCBtYnJ0b2MxNiwgbWJydG9jMzIuCiA8L3BhcmE+PC9s
aXN0aXRlbT4KIAorPGxpc3RpdGVtPjxwYXJhPgorTmV3IEFQSSBjYWxsOiBjbG9zZV9yYW5n
ZSAoYXZhaWxhYmxlIG9uIEZyZWVCU0QgYW5kIExpbnV4KS4KKzwvcGFyYT48L2xpc3RpdGVt
PgorCiA8bGlzdGl0ZW0+PHBhcmE+CiBOZXcgQVBJIGNhbGw6IGZhbGxvY2F0ZSAoTGludXgt
c3BlY2lmaWMpLgogPC9wYXJhPjwvbGlzdGl0ZW0+CmRpZmYgLS1naXQgYS93aW5zdXAvZG9j
L3Bvc2l4LnhtbCBiL3dpbnN1cC9kb2MvcG9zaXgueG1sCmluZGV4IDFhNGVlZTFhYi4uODkw
NTY5MTViIDEwMDY0NAotLS0gYS93aW5zdXAvZG9jL3Bvc2l4LnhtbAorKysgYi93aW5zdXAv
ZG9jL3Bvc2l4LnhtbApAQCAtMTE0Myw2ICsxMTQzLDcgQEAgYWxzbyBJRUVFIFN0ZCAxMDAz
LjEtMjAxNyAoUE9TSVguMS0yMDE3KS48L3BhcmE+CiAgICAgY2ZtYWtlcmF3CiAgICAgY2Zz
ZXRzcGVlZAogICAgIGNsZWFyZXJyX3VubG9ja2VkCisgICAgY2xvc2VfcmFuZ2UKICAgICBk
YWVtb24KICAgICBkbl9jb21wCiAgICAgZG5fZXhwYW5kCkBAIC0xMjk3LDYgKzEyOTgsNyBA
QCBhbHNvIElFRUUgU3RkIDEwMDMuMS0yMDE3IChQT1NJWC4xLTIwMTcpLjwvcGFyYT4KICAg
ICBjbG9nMTAKICAgICBjbG9nMTBmCiAgICAgY2xvZzEwbAorICAgIGNsb3NlX3JhbmdlCQkJ
KHNlZSA8eHJlZiBsaW5rZW5kPSJzdGQtbm90ZXMiPmNoYXB0ZXIgIkltcGxlbWVudGF0aW9u
IE5vdGVzIjwveHJlZj4pCiAgICAgY3J5cHRfcgkJCShhdmFpbGFibGUgaW4gZXh0ZXJuYWwg
ImNyeXB0IiBsaWJyYXJ5KQogICAgIGRsYWRkcgkJCShzZWUgPHhyZWYgbGlua2VuZD0ic3Rk
LW5vdGVzIj5jaGFwdGVyICJJbXBsZW1lbnRhdGlvbiBOb3RlcyI8L3hyZWY+KQogICAgIGRy
ZW1mCkBAIC0xNjU2LDYgKzE2NTgsOSBAQCBDTE9DS19SRUFMVElNRSBhbmQgQ0xPQ0tfTU9O
T1RPTklDLiAgPGZ1bmN0aW9uPmNsb2NrX3NldHJlczwvZnVuY3Rpb24+LAogPGZ1bmN0aW9u
PmNsb2NrX3NldHRpbWU8L2Z1bmN0aW9uPiwgYW5kIDxmdW5jdGlvbj50aW1lcl9jcmVhdGU8
L2Z1bmN0aW9uPgogY3VycmVudGx5IHN1cHBvcnQgb25seSBDTE9DS19SRUFMVElNRS48L3Bh
cmE+CiAKKzxwYXJhPjxmdW5jdGlvbj5jbG9zZV9yYW5nZTwvZnVuY3Rpb24+IGRvZXMgbm90
IHN1cHBvcnQgdGhlIExpbnV4LXNwZWNpZmljCitmbGFnIENMT1NFX1JBTkdFX1VOU0hBUkUu
PC9wYXJhPgorCiA8cGFyYT5QT1NJWCBmaWxlIGxvY2tzIHZpYSA8ZnVuY3Rpb24+ZmNudGw8
L2Z1bmN0aW9uPiBvcgogPGZ1bmN0aW9uPmxvY2tmPC9mdW5jdGlvbj4sIGFzIHdlbGwgYXMg
QlNEIDxmdW5jdGlvbj5mbG9jazwvZnVuY3Rpb24+IGxvY2tzCiBhcmUgYWR2aXNvcnkgbG9j
a3MuICBUaGV5IGRvbid0IGludGVyYWN0IHdpdGggV2luZG93cyBtYW5kYXRvcnkgbG9ja3Ms
IG5vcgotLSAKMi40Mi4xCgo=
--------------EC77113C78EB6002CB4F59FA--
