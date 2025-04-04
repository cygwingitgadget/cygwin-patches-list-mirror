Return-Path: <SRS0=Ctoq=WW=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 11F76384AB77
	for <cygwin-patches@cygwin.com>; Fri,  4 Apr 2025 12:49:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 11F76384AB77
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 11F76384AB77
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743770986; cv=none;
	b=JqdYXgJTEtaxLVfoHiusTsM9dPn8TosEYrrOuGIHUiJwZH+MEIcALHCgJUrjFpelzW/X1X34bq//t5NU0UWUw3JksUcaVCd+t6pMbxJZqa8hMSdeeV8SXOzE9epje5XVo5k/ZOoyYNX82y4aNRCxsqpuwd5z4Usk77j1N+VcOM0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743770986; c=relaxed/simple;
	bh=6/3h/AjbwJfNsq53Vg9dr7pYRZcf87PKFPYhd1pRwz8=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=rwF3qc7nzVnoMVl+SrHqVYF20cAd6+MXHPlodT+2XdG5JJdIqgJxv/n7DWB+2dX0ozwDyDgtKJSiI9KCsfzh0beoGBOXfRm/YkPdL0zlUJJwOn3iT3cM5veb9ZAjaXy7cSEmMMPtSQaKhoXSKzUxocHbaxA7WXltO4c13Q8v2ec=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 11F76384AB77
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Q+mB995e
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20250404124944012.LRQP.17135.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 4 Apr 2025 21:49:44 +0900
Date: Fri, 4 Apr 2025 21:49:43 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: thread: Allow fast_mutex to be acquired
 multiple times.
Message-Id: <20250404214943.5215476f96d46cf15587dd1b@nifty.ne.jp>
In-Reply-To: <Z-PJ_IvVeekUwYAA@calimero.vinschen.de>
References: <20250324055340.975-1-takashi.yano@nifty.ne.jp>
	<Z-E6groYVnQAh-kj@calimero.vinschen.de>
	<20250324220522.fc26bee8c8cc50bae0ad742b@nifty.ne.jp>
	<Z-F7rKIQfY2aYHSD@calimero.vinschen.de>
	<20250326181404.847ecfadcad8977024580575@nifty.ne.jp>
	<Z-PJ_IvVeekUwYAA@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Fri__4_Apr_2025_21_49_43_+0900_x1Fn9E4QFrjsooKB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1743770984;
 bh=oBZ8xWfsR/yI3qA7M6e5QYJhUcj2Nt84asmhU7QxIOw=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=Q+mB995eEIJcWIuQ8OEmwWGo2OxH9RYX3mC+zjK0p9FZrVNp5g2DjJZEr+GmEuKkAQeT+M8G
 NHJqvYh/jlZKgBJR22gtgoyrkD1oPHJdLf5y6Tg3DUsbEhQM3xEUl1ds3NZA4skbSm6KuB31lB
 n7ogUd4sypqytNjeI4vWL7yL2aXsf7VT/eaEMm6aE9YaBlkx+9LZW5ipi2TxN9ALmF+CHDBArr
 HtiZCTmFseokmLI6GmaaGs8ZWvGy03hGNHwG1cdsQllF30VSZLuAF48+sltR99oLwYqH3zgvr8
 5ZYYyB5dluBA0KqLvCvYrr9JbVH0zaCqXsXqv+nWLxpZqN2A==
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.

--Multipart=_Fri__4_Apr_2025_21_49_43_+0900_x1Fn9E4QFrjsooKB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Corinna,

On Wed, 26 Mar 2025 10:33:48 +0100
Corinna Vinschen wrote:
> On Mar 26 18:14, Takashi Yano wrote:
> > Hi Corinna,
> > 
> > On Mon, 24 Mar 2025 16:35:08 +0100
> > Corinna Vinschen wrote:
> > > On Mar 24 22:05, Takashi Yano wrote:
> > > > Hi Corinna,
> > > > 
> > > > On Mon, 24 Mar 2025 11:57:06 +0100
> > > > Corinna Vinschen wrote:
> > > > > I wonder if we shouldn't drop the keys list structure entirely, and
> > > > > convert "keys" to a simple sequence number + destructor array, as in
> > > > > GLibc.  This allows lockless key operations and drop the entire list and
> > > > > mutex overhead.  The code would become dirt-easy, see
> > > > > https://sourceware.org/cgit/glibc/tree/nptl/pthread_key_create.c
> > > > > https://sourceware.org/cgit/glibc/tree/nptl/pthread_key_delete.c
> > > > > 
> > > > > What do you think?
> > > > 
> > > > It looks very simple and reasonable to me.
> > > > 
> > > > > However, for 3.6.1, the below patch should be ok.
> > > > 
> > > > What about reimplementing pthread_key_create/pthread_key_delete
> > > > based on glibc for master branch, and appling this patch to
> > > > cygwin-3_6-branch?
> > > > 
> > > > Shall I try to reimplement them?
> > > 
> > > That would be great!
> > 
> > What about the patch attached?
> > Is this as you intended?
> 
> Yes!
> 
> >  private:
> > -  static List<pthread_key> keys;
> > +  int key_idx;
> > +  static class keys_list {
> > +    ULONG seq;
> 
> GLibc uses uintptr_t for the sequence number to avoid overflow.
> So we could use ULONG64 and InterlockedCompareExchange64 here, too.
> 
> Looks good to me, thanks!

New version of the patch attached. This realizes quasi-lock-free
access to the pthread_keys array. Please review.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Fri__4_Apr_2025_21_49_43_+0900_x1Fn9E4QFrjsooKB
Content-Type: text/plain;
 name="0001-Cygwin-thread-Use-simple-array-instead-of-List-pthre.patch"
Content-Disposition: attachment;
 filename="0001-Cygwin-thread-Use-simple-array-instead-of-List-pthre.patch"
Content-Transfer-Encoding: base64

RnJvbSBhNWVlOTk3NTlmYWViMzNmOGQ5MjBkMjYzZjcwZTNhNTMyZTg0YjNlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogVGFrYXNoaSBZYW5vIDx0YWthc2hpLnlhbm9AbmlmdHkubmUu
anA+DQpEYXRlOiBGcmksIDQgQXByIDIwMjUgMjE6MjI6MjcgKzA5MDANClN1YmplY3Q6IFtQQVRD
SF0gQ3lnd2luOiB0aHJlYWQ6IFVzZSBzaW1wbGUgYXJyYXkgaW5zdGVhZCBvZiBMaXN0PHB0aHJl
YWRfa2V5Pg0KDQpQcmV2aW91c2x5LCBMaXN0PHB0aHJlYWRfa2V5Piwgd2hpY2ggdXNlZCBmYXN0
X211dGV4LCB3YXMgdXNlZCBmb3INCmFjY2Vzc2luZyBhbGwgdGhlIHZhbGlkIHB0aHJlYWRfa2V5
LiBUaGlzIGNhdXNlZCBhIGRlYWRsb2NrIHdoZW4NCmFub3RoZXIgcHRocmVhZF9rZXlfY3JlYXRl
KCkgaXMgY2FsbGVkIGluIHRoZSBkZXN0cnVjdG9yIHJlZ2lzdGVyZWQNCmJ5IHRoZSBwcmV2aW91
cyBwdGhyZWFkX2tleV9jcmVhdGUoKS4gVGhpcyBpcyBiZWNhdXNlIHRoZQ0KcnVuX2FsbF9kZXN0
cnVjdG9ycygpIGNhbGxzIHRoZSBkZXNydWN0b3IgdmlhIGtleXMuZm9yX2VhY2goKSB3aGVyZQ0K
Ym90aCBmb3JfZWFjaCgpIGFuZCBwdGhyZWFkX2tleV9jcmVhdGUoKSAodGhhdCBjYWxscyBMaXN0
X2luc2VydCgpKQ0KYXR0ZW1wdCB0byBhY3F1aXJlIHRoZSBsb2NrLg0KV2l0aCB0aGlzIHBhdGNo
LCB1c2Ugc2ltcGxlIGFycmF5IG9mIHB0aHJlYWRfa2V5IGluc3RlYWQgYW5kIHJlYWxpemUNCnF1
YXNpLWxvY2stZnJlZSBhY2Nlc3MgdG8gdGhhdCBhcnJheSByZWZlcmluZyB0byB0aGUgZ2xpYmMg
Y29kZS4NCg0KQWRkcmVzc2VzOiBodHRwczovL2N5Z3dpbi5jb20vcGlwZXJtYWlsL2N5Z3dpbi8y
MDI1LU1hcmNoLzI1NzcwNS5odG1sDQpGaXhlczogMWE4MjEzOTBkMTFkICgiZml4IHJhY2UgY29u
ZGl0aW9uIGluIExpc3RfaW5zZXJ0IikNClJlcG9ydGVkLWJ5OiBZdXlpIFdhbmcgPFN0cmF3YmVy
cnlfU3RyQGhvdG1haWwuY29tPg0KUmV2aWV3ZWQtYnk6IENvcmlubmEgVmluc2NoZW4gPGNvcmlu
bmFAdmluc2NoZW4uZGU+DQpTaWduZWQtb2ZmLWJ5OiBUYWthc2hpIFlhbm8gPHRha2FzaGkueWFu
b0BuaWZ0eS5uZS5qcD4NCi0tLQ0KIHdpbnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMvdGhyZWFk
LmggfCA0MiArKysrKysrKysrKysrKysrKysrKysrLS0tLS0NCiB3aW5zdXAvY3lnd2luL3RocmVh
ZC5jYyAgICAgICAgICAgICAgIHwgMzEgKysrKysrKysrKysrKysrKystLS0NCiAyIGZpbGVzIGNo
YW5nZWQsIDYyIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEv
d2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy90aHJlYWQuaCBiL3dpbnN1cC9jeWd3aW4vbG9j
YWxfaW5jbHVkZXMvdGhyZWFkLmgNCmluZGV4IGIzNDk2MjgxZS4uMzA1M2RlMGEyIDEwMDY0NA0K
LS0tIGEvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy90aHJlYWQuaA0KKysrIGIvd2luc3Vw
L2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy90aHJlYWQuaA0KQEAgLTIyMSwxMyArMjIxLDI2IEBAIHB1
YmxpYzoNCiAgIH5wdGhyZWFkX2tleSAoKTsNCiAgIHN0YXRpYyB2b2lkIGZpeHVwX2JlZm9yZV9m
b3JrICgpDQogICB7DQotICAgIGtleXMuZm9yX2VhY2ggKCZwdGhyZWFkX2tleTo6X2ZpeHVwX2Jl
Zm9yZV9mb3JrKTsNCisgICAgZm9yIChzaXplX3QgY250ID0gMDsgY250IDwgUFRIUkVBRF9LRVlT
X01BWDsgY250KyspDQorICAgICAgew0KKwlpZiAoIXB0aHJlYWRfa2V5OjprZXlzX2xpc3Q6OnJl
YWR5IChrZXlzW2NudF0uc2VxKSkNCisJICBjb250aW51ZTsNCisJaWYgKEludGVybG9ja2VkSW5j
cmVtZW50NjQgKCZrZXlzW2NudF0uYnVzeV9jbnQpID4gMCkNCisJICBrZXlzW2NudF0ua2V5LT5f
Zml4dXBfYmVmb3JlX2ZvcmsgKCk7DQorCUludGVybG9ja2VkRGVjcmVtZW50NjQgKCZrZXlzW2Nu
dF0uYnVzeV9jbnQpOw0KKyAgICAgIH0NCiAgIH0NCiANCiAgIHN0YXRpYyB2b2lkIGZpeHVwX2Fm
dGVyX2ZvcmsgKCkNCiAgIHsNCi0gICAga2V5cy5maXh1cF9hZnRlcl9mb3JrICgpOw0KLSAgICBr
ZXlzLmZvcl9lYWNoICgmcHRocmVhZF9rZXk6Ol9maXh1cF9hZnRlcl9mb3JrKTsNCisgICAgZm9y
IChzaXplX3QgY250ID0gMDsgY250IDwgUFRIUkVBRF9LRVlTX01BWDsgY250KyspDQorICAgICAg
ew0KKwlpZiAoIXB0aHJlYWRfa2V5OjprZXlzX2xpc3Q6OnJlYWR5IChrZXlzW2NudF0uc2VxKSkN
CisJICBjb250aW51ZTsNCisJaWYgKEludGVybG9ja2VkSW5jcmVtZW50NjQgKCZrZXlzW2NudF0u
YnVzeV9jbnQpID4gMCkNCisJICBrZXlzW2NudF0ua2V5LT5fZml4dXBfYWZ0ZXJfZm9yayAoKTsN
CisJSW50ZXJsb2NrZWREZWNyZW1lbnQ2NCAoJmtleXNbY250XS5idXN5X2NudCk7DQorICAgICAg
fQ0KICAgfQ0KIA0KICAgc3RhdGljIHZvaWQgcnVuX2FsbF9kZXN0cnVjdG9ycyAoKQ0KQEAgLTI0
NiwxNiArMjU5LDMxIEBAIHB1YmxpYzoNCiAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBQVEhSRUFE
X0RFU1RSVUNUT1JfSVRFUkFUSU9OUzsgKytpKQ0KICAgICAgIHsNCiAJaXRlcmF0ZV9kdG9yc19v
bmNlX21vcmUgPSBmYWxzZTsNCi0Ja2V5cy5mb3JfZWFjaCAoJnB0aHJlYWRfa2V5OjpydW5fZGVz
dHJ1Y3Rvcik7DQorCWZvciAoc2l6ZV90IGNudCA9IDA7IGNudCA8IFBUSFJFQURfS0VZU19NQVg7
IGNudCsrKQ0KKwkgIHsNCisJICAgIGlmICghcHRocmVhZF9rZXk6OmtleXNfbGlzdDo6cmVhZHkg
KGtleXNbY250XS5zZXEpKQ0KKwkgICAgICBjb250aW51ZTsNCisJICAgIGlmIChJbnRlcmxvY2tl
ZEluY3JlbWVudDY0ICgma2V5c1tjbnRdLmJ1c3lfY250KSA+IDApDQorCSAgICAgIGtleXNbY250
XS5rZXktPnJ1bl9kZXN0cnVjdG9yICgpOw0KKwkgICAgSW50ZXJsb2NrZWREZWNyZW1lbnQ2NCAo
JmtleXNbY250XS5idXN5X2NudCk7DQorCSAgfQ0KIAlpZiAoIWl0ZXJhdGVfZHRvcnNfb25jZV9t
b3JlKQ0KIAkgIGJyZWFrOw0KICAgICAgIH0NCiAgIH0NCiANCi0gIC8qIExpc3Qgc3VwcG9ydCBj
YWxscyAqLw0KLSAgY2xhc3MgcHRocmVhZF9rZXkgKm5leHQ7DQogcHJpdmF0ZToNCi0gIHN0YXRp
YyBMaXN0PHB0aHJlYWRfa2V5PiBrZXlzOw0KKyAgaW50IGtleV9pZHg7DQorICBzdGF0aWMgY2xh
c3Mga2V5c19saXN0IHsNCisgICAgTE9ORzY0IHNlcTsNCisgICAgTE9ORzY0IGJ1c3lfY250Ow0K
KyAgICBwdGhyZWFkX2tleSAqa2V5Ow0KKyAgICBzdGF0aWMgYm9vbCB1c2VkIChMT05HNjQgc2Vx
MSkgeyByZXR1cm4gKHNlcTEgJiAzKSAhPSAwOyB9DQorICAgIHN0YXRpYyBib29sIHJlYWR5IChM
T05HNjQgc2VxMSkgeyByZXR1cm4gKHNlcTEgJiAzKSA9PSAyOyB9DQorICBwdWJsaWM6DQorICAg
IGtleXNfbGlzdCAoKSA6IHNlcSAoMCksIGJ1c3lfY250ICgwKSwga2V5IChOVUxMKSB7fQ0KKyAg
ICBmcmllbmQgY2xhc3MgcHRocmVhZF9rZXk7DQorICB9IGtleXNbUFRIUkVBRF9LRVlTX01BWF07
DQogICB2b2lkIF9maXh1cF9iZWZvcmVfZm9yayAoKTsNCiAgIHZvaWQgX2ZpeHVwX2FmdGVyX2Zv
cmsgKCk7DQogICB2b2lkICgqZGVzdHJ1Y3RvcikgKHZvaWQgKik7DQpkaWZmIC0tZ2l0IGEvd2lu
c3VwL2N5Z3dpbi90aHJlYWQuY2MgYi93aW5zdXAvY3lnd2luL3RocmVhZC5jYw0KaW5kZXggOWVl
OTY1MDRiLi4xNzYwMGJlNzUgMTAwNjQ0DQotLS0gYS93aW5zdXAvY3lnd2luL3RocmVhZC5jYw0K
KysrIGIvd2luc3VwL2N5Z3dpbi90aHJlYWQuY2MNCkBAIC0zMiw2ICszMiw3IEBAIGRldGFpbHMu
ICovDQogI2luY2x1ZGUgIm50ZGxsLmgiDQogI2luY2x1ZGUgImN5Z3dhaXQuaCINCiAjaW5jbHVk
ZSAiZXhjZXB0aW9uLmgiDQorI2luY2x1ZGUgPGFzc2VydC5oPg0KIA0KIC8qIEZvciBMaW51eCBj
b21wYXRpYmlsaXR5LCB0aGUgbGVuZ3RoIG9mIGEgdGhyZWFkIG5hbWUgaXMgMTYgY2hhcmFjdGVy
cy4gKi8NCiAjZGVmaW5lIFRIUk5BTUVMRU4gMTYNCkBAIC0xNjY2LDE3ICsxNjY3LDMxIEBAIHB0
aHJlYWRfcndsb2NrOjpfZml4dXBfYWZ0ZXJfZm9yayAoKQ0KIC8qIHB0aHJlYWRfa2V5ICovDQog
Lyogc3RhdGljIG1lbWJlcnMgKi8NCiAvKiBUaGlzIHN0b3JlcyBwdGhyZWFkX2tleSBpbmZvcm1h
dGlvbiBhY3Jvc3MgZm9yaygpIGJvdW5kYXJpZXMgKi8NCi1MaXN0PHB0aHJlYWRfa2V5PiBwdGhy
ZWFkX2tleTo6a2V5czsNCitwdGhyZWFkX2tleTo6a2V5c19saXN0IHB0aHJlYWRfa2V5OjprZXlz
W1BUSFJFQURfS0VZU19NQVhdOw0KIA0KIC8qIG5vbi1zdGF0aWMgbWVtYmVycyAqLw0KIA0KLXB0
aHJlYWRfa2V5OjpwdGhyZWFkX2tleSAodm9pZCAoKmFEZXN0cnVjdG9yKSAodm9pZCAqKSk6dmVy
aWZ5YWJsZV9vYmplY3QgKFBUSFJFQURfS0VZX01BR0lDKSwgZGVzdHJ1Y3RvciAoYURlc3RydWN0
b3IpDQorcHRocmVhZF9rZXk6OnB0aHJlYWRfa2V5ICh2b2lkICgqYURlc3RydWN0b3IpICh2b2lk
ICopKSA6DQorICB2ZXJpZnlhYmxlX29iamVjdCAoUFRIUkVBRF9LRVlfTUFHSUMpLCBkZXN0cnVj
dG9yIChhRGVzdHJ1Y3RvcikNCiB7DQogICB0bHNfaW5kZXggPSBUbHNBbGxvYyAoKTsNCiAgIGlm
ICh0bHNfaW5kZXggPT0gVExTX09VVF9PRl9JTkRFWEVTKQ0KICAgICBtYWdpYyA9IDA7DQogICBl
bHNlDQotICAgIGtleXMuaW5zZXJ0ICh0aGlzKTsNCisgICAgZm9yIChzaXplX3QgY250ID0gMDsg
Y250IDwgUFRIUkVBRF9LRVlTX01BWDsgY250KyspDQorICAgICAgew0KKwlMT05HNjQgc2VxID0g
a2V5c1tjbnRdLnNlcTsNCisJaWYgKCFwdGhyZWFkX2tleTo6a2V5c19saXN0Ojp1c2VkIChzZXEp
DQorCSAgICAmJiBJbnRlcmxvY2tlZENvbXBhcmVFeGNoYW5nZTY0ICgma2V5c1tjbnRdLnNlcSwN
CisJCQkJCSAgICAgc2VxICsgMSwgc2VxKSA9PSBzZXEpDQorCSAgew0KKwkgICAga2V5c1tjbnRd
LmtleSA9IHRoaXM7DQorCSAgICBrZXlzW2NudF0uYnVzeV9jbnQgPSAwOw0KKwkgICAga2V5X2lk
eCA9IGNudDsNCisJICAgIEludGVybG9ja2VkSW5jcmVtZW50NjQgKCZrZXlzW2tleV9pZHhdLnNl
cSk7DQorCSAgICBicmVhazsNCisJICB9DQorICAgICAgfQ0KIH0NCiANCiBwdGhyZWFkX2tleTo6
fnB0aHJlYWRfa2V5ICgpDQpAQCAtMTY4NSw3ICsxNzAwLDE1IEBAIHB0aHJlYWRfa2V5Ojp+cHRo
cmVhZF9rZXkgKCkNCiAgICAqLw0KICAgaWYgKG1hZ2ljICE9IDApDQogICAgIHsNCi0gICAgICBr
ZXlzLnJlbW92ZSAodGhpcyk7DQorICAgICAgTE9ORzY0IHNlcSA9IGtleXNba2V5X2lkeF0uc2Vx
Ow0KKyAgICAgIGFzc2VydCAocHRocmVhZF9rZXk6OmtleXNfbGlzdDo6cmVhZHkgKHNlcSkNCisJ
ICAgICAgJiYgSW50ZXJsb2NrZWRDb21wYXJlRXhjaGFuZ2U2NCAoJmtleXNba2V5X2lkeF0uc2Vx
LA0KKwkJCQkJICAgICAgIHNlcSArIDEsIHNlcSkgPT0gc2VxKTsNCisgICAgICB3aGlsZSAoSW50
ZXJsb2NrZWRDb21wYXJlRXhjaGFuZ2U2NCAoJmtleXNba2V5X2lkeF0uYnVzeV9jbnQsDQorCQkJ
CQkgICBJTlQ2NF9NSU4sIDApID4gMCkNCisJeWllbGQgKCk7DQorICAgICAga2V5c1trZXlfaWR4
XS5rZXkgPSBOVUxMOw0KKyAgICAgIEludGVybG9ja2VkSW5jcmVtZW50NjQgKCZrZXlzW2tleV9p
ZHhdLnNlcSk7DQogICAgICAgVGxzRnJlZSAodGxzX2luZGV4KTsNCiAgICAgfQ0KIH0NCi0tIA0K
Mi40NS4xDQoNCg==

--Multipart=_Fri__4_Apr_2025_21_49_43_+0900_x1Fn9E4QFrjsooKB--
