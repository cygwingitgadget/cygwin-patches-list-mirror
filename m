Return-Path: <SRS0=uN41=S3=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout08.t-online.de (mailout08.t-online.de [194.25.134.20])
	by sourceware.org (Postfix) with ESMTPS id 78DA93858C54
	for <cygwin-patches@cygwin.com>; Mon,  2 Dec 2024 16:15:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 78DA93858C54
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 78DA93858C54
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733156103; cv=none;
	b=C5t0Uyz/OTWyJWcMSIvMcjUH0NNF1m/lAhKTxR3Qzf7myBpRX4t6jHivgXzPqURtFGSpjCdQU+2h6OHtH6JlVv7UsL0WsCQPBi9Vd3iTtR67gAaM4GOiMjNqhbnDKrUDYjQ9ryK/ENdXjJjPZK4av89OkkJP1FlwccbBQgaTNY4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733156103; c=relaxed/simple;
	bh=wUu7jaVLDO3aXsAw84AvXcGeRVPo5xqcQ2kRlaQ6wO8=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=JYquaV8mh0RoxruCSOiIOmF4kWrgMcxhQSvsXwdvN8eB/V/I/F3p0fYcPwrwc6njgTBtf7P2upt1ItVxxssROaVt2JHY6n0FyEKG5w/5uSv3meLeFgEeI/vjgmtKiklVL+IUKQ4zFiG1UvFKCf7dFatbXxN4mz66zeYlMhuMrTk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 78DA93858C54
Received: from fwd82.aul.t-online.de (fwd82.aul.t-online.de [10.223.144.108])
	by mailout08.t-online.de (Postfix) with SMTP id C9C32E00
	for <cygwin-patches@cygwin.com>; Mon,  2 Dec 2024 17:15:01 +0100 (CET)
Received: from [192.168.2.103] ([91.57.250.70]) by fwd82.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1tI94e-0sTsmG0; Mon, 2 Dec 2024 17:15:00 +0100
Subject: Re: [PATCH] Cygwin: setpriority, sched_setparam: add missing process
 access right
To: cygwin-patches@cygwin.com
References: <0f9951bf-ddfd-4545-a678-d697d2c974bb@t-online.de>
 <Z03TzKxAV5DZD6_T@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <2500b726-4b0e-6610-020a-f4a799d6949f@t-online.de>
Date: Mon, 2 Dec 2024 17:14:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.19
MIME-Version: 1.0
In-Reply-To: <Z03TzKxAV5DZD6_T@calimero.vinschen.de>
Content-Type: multipart/mixed;
 boundary="------------01130BAD04A65A2897831541"
X-TOI-EXPURGATEID: 150726::1733156100-D77F844F-12D09110/0/0 CLEAN NORMAL
X-TOI-MSGID: 58303b3d-6cf0-401e-af90-6f32ba991036
X-Spam-Status: No, score=-12.3 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------01130BAD04A65A2897831541
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Corinna Vinschen wrote:
> On Nov 29 17:12, Christian Franke wrote:
>> Regression, sorry!
> Shit happens *shrug*
>
>> Subject: [PATCH] Cygwin: setpriority, sched_setparam: add missing process
>>   access right
>>
>> set_and_check_winprio() also requires PROCESS_QUERY_LIMITED_INFORMATION.
>>
>> Fixes: 153b51ee08ef ("Cygwin: setpriority, sched_setparam: fail if Windows sets a lower priority")
>> Signed-off-by: Christian Franke <christian.franke@t-online.de>
>> ---
>>   winsup/cygwin/miscfuncs.cc | 2 ++
>>   winsup/cygwin/sched.cc     | 4 +++-
>>   winsup/cygwin/syscalls.cc  | 5 +++--
>>   3 files changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/winsup/cygwin/miscfuncs.cc b/winsup/cygwin/miscfuncs.cc
>> index e3bf35cf7..ebe401b93 100644
>> --- a/winsup/cygwin/miscfuncs.cc
>> +++ b/winsup/cygwin/miscfuncs.cc
>> @@ -190,6 +190,8 @@ bool
>>   set_and_check_winprio (HANDLE proc, DWORD prio)
>>   {
>>     DWORD prev_prio = GetPriorityClass (proc);
>> +  if (!prev_prio)
>> +    return false;
> The commit message doesn't explain this part of the patch.  What does it
> fix?

Same patch with additional message line is attached.


--------------01130BAD04A65A2897831541
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-setpriority-sched_setparam-add-missing-proces.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Cygwin-setpriority-sched_setparam-add-missing-proces.pa";
 filename*1="tch"

RnJvbSBlOGYzNGE0M2IwZjdiMTcxZTNhNzIyNWQ3ZTMyNWU2NWNmYjYxZGJjIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBNb24sIDIgRGVjIDIwMjQgMTc6MDc6MTggKzAxMDAK
U3ViamVjdDogW1BBVENIXSBDeWd3aW46IHNldHByaW9yaXR5LCBzY2hlZF9zZXRwYXJhbTog
YWRkIG1pc3NpbmcgcHJvY2VzcwogYWNjZXNzIHJpZ2h0CgpzZXRfYW5kX2NoZWNrX3dpbnBy
aW8oKSBhbHNvIHJlcXVpcmVzIFBST0NFU1NfUVVFUllfTElNSVRFRF9JTkZPUk1BVElPTi4K
QWxzbyBhZGQgYW4gZWFybHkgY2hlY2sgZm9yIHRoaXMgYWNjZXNzIHJpZ2h0IHRvIHNldF9h
bmRfY2hlY2tfd2lucHJpbygpLgoKRml4ZXM6IDE1M2I1MWVlMDhlZiAoIkN5Z3dpbjogc2V0
cHJpb3JpdHksIHNjaGVkX3NldHBhcmFtOiBmYWlsIGlmIFdpbmRvd3Mgc2V0cyBhIGxvd2Vy
IHByaW9yaXR5IikKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEZyYW5rZSA8Y2hyaXN0aWFu
LmZyYW5rZUB0LW9ubGluZS5kZT4KLS0tCiB3aW5zdXAvY3lnd2luL21pc2NmdW5jcy5jYyB8
IDIgKysKIHdpbnN1cC9jeWd3aW4vc2NoZWQuY2MgICAgIHwgNCArKystCiB3aW5zdXAvY3ln
d2luL3N5c2NhbGxzLmNjICB8IDUgKysrLS0KIDMgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vbWlz
Y2Z1bmNzLmNjIGIvd2luc3VwL2N5Z3dpbi9taXNjZnVuY3MuY2MKaW5kZXggZTNiZjM1Y2Y3
Li5lYmU0MDFiOTMgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vbWlzY2Z1bmNzLmNjCisr
KyBiL3dpbnN1cC9jeWd3aW4vbWlzY2Z1bmNzLmNjCkBAIC0xOTAsNiArMTkwLDggQEAgYm9v
bAogc2V0X2FuZF9jaGVja193aW5wcmlvIChIQU5ETEUgcHJvYywgRFdPUkQgcHJpbykKIHsK
ICAgRFdPUkQgcHJldl9wcmlvID0gR2V0UHJpb3JpdHlDbGFzcyAocHJvYyk7CisgIGlmICgh
cHJldl9wcmlvKQorICAgIHJldHVybiBmYWxzZTsKICAgaWYgKHByZXZfcHJpbyA9PSBwcmlv
KQogICAgIHJldHVybiB0cnVlOwogCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL3NjaGVk
LmNjIGIvd2luc3VwL2N5Z3dpbi9zY2hlZC5jYwppbmRleCBiODA2N2Q1NDcuLjYxZDVlN2Jl
NCAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9zY2hlZC5jYworKysgYi93aW5zdXAvY3ln
d2luL3NjaGVkLmNjCkBAIC0yNjAsNyArMjYwLDkgQEAgc2NoZWRfc2V0cGFyYW0gKHBpZF90
IHBpZCwgY29uc3Qgc3RydWN0IHNjaGVkX3BhcmFtICpwYXJhbSkKICAgICAgIHNldF9lcnJu
byAoRVNSQ0gpOwogICAgICAgcmV0dXJuIC0xOwogICAgIH0KLSAgcHJvY2VzcyA9IE9wZW5Q
cm9jZXNzIChQUk9DRVNTX1NFVF9JTkZPUk1BVElPTiwgRkFMU0UsIHAtPmR3UHJvY2Vzc0lk
KTsKKyAgcHJvY2VzcyA9IE9wZW5Qcm9jZXNzIChQUk9DRVNTX1NFVF9JTkZPUk1BVElPTiB8
CisJCQkgUFJPQ0VTU19RVUVSWV9MSU1JVEVEX0lORk9STUFUSU9OLAorCQkJIEZBTFNFLCBw
LT5kd1Byb2Nlc3NJZCk7CiAgIGlmICghcHJvY2VzcykKICAgICB7CiAgICAgICBzZXRfZXJy
bm8gKEVTUkNIKTsKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vc3lzY2FsbHMuY2MgYi93
aW5zdXAvY3lnd2luL3N5c2NhbGxzLmNjCmluZGV4IDYwMzUwYjY5MC4uZDRmYmE2MzJjIDEw
MDY0NAotLS0gYS93aW5zdXAvY3lnd2luL3N5c2NhbGxzLmNjCisrKyBiL3dpbnN1cC9jeWd3
aW4vc3lzY2FsbHMuY2MKQEAgLTM4NjksOCArMzg2OSw5IEBAIHNldHByaW9yaXR5IChpbnQg
d2hpY2gsIGlkX3Qgd2hvLCBpbnQgdmFsdWUpCiAJCWNvbnRpbnVlOwogCSAgICAgIGJyZWFr
OwogCSAgICB9Ci0JICBIQU5ETEUgcHJvY19oID0gT3BlblByb2Nlc3MgKFBST0NFU1NfU0VU
X0lORk9STUFUSU9OLCBGQUxTRSwKLQkJCQkgICAgICAgcC0+ZHdQcm9jZXNzSWQpOworCSAg
SEFORExFIHByb2NfaCA9IE9wZW5Qcm9jZXNzIChQUk9DRVNTX1NFVF9JTkZPUk1BVElPTiB8
CisJCQkJICAgICAgIFBST0NFU1NfUVVFUllfTElNSVRFRF9JTkZPUk1BVElPTiwKKwkJCQkg
ICAgICAgRkFMU0UsIHAtPmR3UHJvY2Vzc0lkKTsKIAkgIGlmICghcHJvY19oKQogCSAgICBl
cnJvciA9IEVQRVJNOwogCSAgZWxzZQotLSAKMi40NS4xCgo=
--------------01130BAD04A65A2897831541--
