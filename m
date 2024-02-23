Return-Path: <SRS0=x8HM=KA=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout04.t-online.de (mailout04.t-online.de [194.25.134.18])
	by sourceware.org (Postfix) with ESMTPS id C3BEF385842D
	for <cygwin-patches@cygwin.com>; Fri, 23 Feb 2024 18:14:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C3BEF385842D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C3BEF385842D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1708712049; cv=none;
	b=PNbHzWs9KQ+WBlK2uD1KGrWcQt42aPVOk8rywgtR92H7hPRbGeinMli1Nja6dA+00YHofr6p6nKdY2lUhkT440ekGBBFs9QCWptacmbTaHh9kqjC5JaClwddI3HxzOX6WYK+rcfY1JZl4OgqQiUM4yL7WboqrEpKQPKbMCVm4/g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1708712049; c=relaxed/simple;
	bh=hfGYEaossLwmykECBQ+64vreabTJdet6NT3TJNtBYDA=;
	h=To:From:Subject:Message-ID:Date:MIME-Version; b=kCSOteNfg3ZUKqV9yZC1l99YP5XSfXztj7s1/6Whqa/uA/tGhZMMQ/j2DDnArxs55uXCx+H+dFTDcp0UlsJpQKoTPWEaACtn6BHdF9nm3r1gC6tSbHyID8OiIAUJMKnsrxlyAzl6jc2qkQKS7r+jXaO+xC4/5tFxlOlvtkeyC5U=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from fwd85.aul.t-online.de (fwd85.aul.t-online.de [10.223.144.111])
	by mailout04.t-online.de (Postfix) with SMTP id B5537239D9
	for <cygwin-patches@cygwin.com>; Fri, 23 Feb 2024 19:14:06 +0100 (CET)
Received: from [192.168.2.102] ([87.187.47.57]) by fwd85.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1rda3f-0JY7aC0; Fri, 23 Feb 2024 19:14:03 +0100
To: cygwin-patches@cygwin.com
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH] Cygwin: Map ERROR_NO_SUCH_DEVICE and ERROR_MEDIA_CHANGED to
 ENODEV
Message-ID: <04f337bf-7197-b4af-3519-832ad2be5b14@t-online.de>
Date: Fri, 23 Feb 2024 19:14:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.16
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------DCE7EB46F3B8276968DF350B"
X-TOI-EXPURGATEID: 150726::1708712043-85FF9383-D36E560F/0/0 CLEAN NORMAL
X-TOI-MSGID: 6b5470cd-6bdf-4374-93ae-c4a51d90b130
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------DCE7EB46F3B8276968DF350B
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Experiments with damaged USB flash drives and ddrescue revealed that the 
current mapping of these Win32 errors to the fallback EACCES could be 
improved.

BTW: I wonder why EACCES was selected as the fallback. Source code 
control forensics suggest that this was decided in the last millennium. 
A related comment from CGF added August 2000 persists until today :-)
/* FIXME: what's so special about EACCESS? */

-- 
Regards,
Christian


--------------DCE7EB46F3B8276968DF350B
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-Map-ERROR_NO_SUCH_DEVICE-and-ERROR_MEDIA_CHAN.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Cygwin-Map-ERROR_NO_SUCH_DEVICE-and-ERROR_MEDIA_CHAN.pa";
 filename*1="tch"

RnJvbSA4YWExOWM3ZmQxM2RjMzc5MGRjMjcxZGVkZTg5NTQ1MzliZmZjZDRkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBGcmksIDIzIEZlYiAyMDI0IDE5OjAxOjA5ICswMTAw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBNYXAgRVJST1JfTk9fU1VDSF9ERVZJQ0UgYW5k
IEVSUk9SX01FRElBX0NIQU5HRUQgdG8KIEVOT0RFVgoKSWYgYSByZW1vdmFibGUgKFVTQikg
ZGV2aWNlIGlzIGRpc2Nvbm5lY3RlZCBhZnRlciBvcGVuaW5nIGl0cyByYXcKZGV2aWNlLCBS
L1cgYXR0ZW1wdHMgZmFpbCB3aXRoIEVSUk9SX05PX1NVQ0hfREVWSUNFKDQzMykuICBJZiB0
aGUKcmF3IGRldmljZSBvZiBhIHBhcnRpdGlvbiBpcyB1c2VkLCBFUlJPUl9NRURJQV9DSEFO
R0VEKDExMTApIGlzCnJldHVybmVkIGluc3RlYWQuICBCb3RoIGFyZSBtYXBwZWQgdG8gRU5P
REVWKDE5KSBiZWNhdXNlIDxlcnJuby5oPgpkb2VzIG5vdCBvZmZlciBhIHZhbHVlIHdoaWNo
IGJldHRlciBtYXRjaGVzIEVSUk9SX01FRElBX0NIQU5HRUQuCgpTaWduZWQtb2ZmLWJ5OiBD
aHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJhbmtlQHQtb25saW5lLmRlPgotLS0KIHdp
bnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMvZXJybWFwLmggfCA0ICsrLS0KIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
d2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9lcnJtYXAuaCBiL3dpbnN1cC9jeWd3aW4v
bG9jYWxfaW5jbHVkZXMvZXJybWFwLmgKaW5kZXggMzI2YjM1YjZjLi5hMGIzZmY0MDAgMTAw
NjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMvZXJybWFwLmgKKysrIGIv
d2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9lcnJtYXAuaApAQCAtNDM4LDcgKzQzOCw3
IEBAIHN0YXRpYyBjb25zdCBpbnQgZXJybWFwW10gPQogICAwLAkJCS8qIDQzMCAqLwogICAw
LAkJCS8qIDQzMSAqLwogICAwLAkJCS8qIDQzMiAqLwotICAwLAkJCS8qIDQzMyAqLworICBF
Tk9ERVYsCQkvKiBFUlJPUl9OT19TVUNIX0RFVklDRSAqLwogICAwLAkJCS8qIDQzNCAqLwog
ICAwLAkJCS8qIDQzNSAqLwogICAwLAkJCS8qIDQzNiAqLwpAQCAtMTExNSw3ICsxMTE1LDcg
QEAgc3RhdGljIGNvbnN0IGludCBlcnJtYXBbXSA9CiAgIDAsCQkJLyogRVJST1JfREVWSUNF
X05PVF9QQVJUSVRJT05FRCAqLwogICAwLAkJCS8qIEVSUk9SX1VOQUJMRV9UT19MT0NLX01F
RElBICovCiAgIDAsCQkJLyogRVJST1JfVU5BQkxFX1RPX1VOTE9BRF9NRURJQSAqLwotICAw
LAkJCS8qIEVSUk9SX01FRElBX0NIQU5HRUQgKi8KKyAgRU5PREVWLAkJLyogRVJST1JfTUVE
SUFfQ0hBTkdFRCAqLwogICBFSU8sCQkJLyogRVJST1JfQlVTX1JFU0VUICovCiAgIEVOT01F
RElVTSwJCS8qIEVSUk9SX05PX01FRElBX0lOX0RSSVZFICovCiAgIDAsCQkJLyogRVJST1Jf
Tk9fVU5JQ09ERV9UUkFOU0xBVElPTiAqLwotLSAKMi40My4wCgo=
--------------DCE7EB46F3B8276968DF350B--
