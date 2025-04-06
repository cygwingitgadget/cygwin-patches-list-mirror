Return-Path: <SRS0=YIpw=WY=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [106.153.227.113])
	by sourceware.org (Postfix) with ESMTPS id D10BE3857354
	for <cygwin-patches@cygwin.com>; Sun,  6 Apr 2025 10:57:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D10BE3857354
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D10BE3857354
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.113
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743937079; cv=none;
	b=jCPKpdnk69B+mfCuI762esCcZrxkKN74E0qBgVCKbr47mELeXJQ1pYfMfCEGbDABjkgCTofUq8f0wf5ZNiGLSFX4RFSQN6VpNnvCaQHMO7rDzdOPS6gFA/6TVnotTx2OVFCtPwwMFjkFqQD0FZ/obfo/W0Nbo4N4njJYpYmjY6I=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743937079; c=relaxed/simple;
	bh=9Oex3CVnnseHP2Zh4ZA+jgwDuX3JYYh/znjz1i4tQZY=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=qjKuNGeP7QxRQUQLOTyxUOnVoAyUBykG7knV65pRzqklhu9RrgcXtffF/0lg4HC3863ogWgXpmi2RQWT6cMI9KhoC+/0HbeuhjTz3cwVO8z3q6UuuyZjCF2hTvcBKpt6MwFmxtkCnBOHBKvZJfZYszv3VIdvJxtVtmNx4bgD4fY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D10BE3857354
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=UvVwptDj
Received: from HP-Z230 by mta-snd-e01.mail.nifty.com with ESMTP
          id <20250406105755259.GXOV.62593.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 6 Apr 2025 19:57:55 +0900
Date: Sun, 6 Apr 2025 19:57:54 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: thread: Allow fast_mutex to be acquired
 multiple times.
Message-Id: <20250406195754.86176712205af9b956301697@nifty.ne.jp>
In-Reply-To: <20250404214943.5215476f96d46cf15587dd1b@nifty.ne.jp>
References: <20250324055340.975-1-takashi.yano@nifty.ne.jp>
	<Z-E6groYVnQAh-kj@calimero.vinschen.de>
	<20250324220522.fc26bee8c8cc50bae0ad742b@nifty.ne.jp>
	<Z-F7rKIQfY2aYHSD@calimero.vinschen.de>
	<20250326181404.847ecfadcad8977024580575@nifty.ne.jp>
	<Z-PJ_IvVeekUwYAA@calimero.vinschen.de>
	<20250404214943.5215476f96d46cf15587dd1b@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sun__6_Apr_2025_19_57_54_+0900_8TaGrpt/CW./d/aV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1743937075;
 bh=tvxO21nVHWEjmUdQxWF6ZmHFeXdt4c/vxJmVGxbxU2Y=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=UvVwptDjFOk5n6P5Wkpordq3lpod4Zz2XOcKmS4oytSvyc0YJGrdeFr9yYVsZKJLfVU93eBr
 K5sUSV27Ki0HixJ56967TW9BPEoJbkuqvG2sR0p+ekInCNwBEynWR8JcaMv5LU7kCYxRbwfmrv
 +l/HGYzBwIY9qLnRSXHzEaXeTannG4DVbRQlR7yZBWTroevwW+pGO6pNvlQUf+J9rkZDzUMRhq
 lhUsz10lnyfEe+mzSk9Q2I/tzJ80UfT8UpQZ88+Ks6qwY8GMNIoOPmyrei6lzzo4tpJEH9Fhx2
 jaGa93+wet3IFhwJq6Bf1bhJqgWlVD3KfpsraA+t7WlQekLA==
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.

--Multipart=_Sun__6_Apr_2025_19_57_54_+0900_8TaGrpt/CW./d/aV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Apr 2025 21:49:43 +0900
Takashi Yano wrote:
> Hi Corinna,
> 
> On Wed, 26 Mar 2025 10:33:48 +0100
> Corinna Vinschen wrote:
> > On Mar 26 18:14, Takashi Yano wrote:
> > > Hi Corinna,
> > > 
> > > On Mon, 24 Mar 2025 16:35:08 +0100
> > > Corinna Vinschen wrote:
> > > > On Mar 24 22:05, Takashi Yano wrote:
> > > > > Hi Corinna,
> > > > > 
> > > > > On Mon, 24 Mar 2025 11:57:06 +0100
> > > > > Corinna Vinschen wrote:
> > > > > > I wonder if we shouldn't drop the keys list structure entirely, and
> > > > > > convert "keys" to a simple sequence number + destructor array, as in
> > > > > > GLibc.  This allows lockless key operations and drop the entire list and
> > > > > > mutex overhead.  The code would become dirt-easy, see
> > > > > > https://sourceware.org/cgit/glibc/tree/nptl/pthread_key_create.c
> > > > > > https://sourceware.org/cgit/glibc/tree/nptl/pthread_key_delete.c
> > > > > > 
> > > > > > What do you think?
> > > > > 
> > > > > It looks very simple and reasonable to me.
> > > > > 
> > > > > > However, for 3.6.1, the below patch should be ok.
> > > > > 
> > > > > What about reimplementing pthread_key_create/pthread_key_delete
> > > > > based on glibc for master branch, and appling this patch to
> > > > > cygwin-3_6-branch?
> > > > > 
> > > > > Shall I try to reimplement them?
> > > > 
> > > > That would be great!
> > > 
> > > What about the patch attached?
> > > Is this as you intended?
> > 
> > Yes!
> > 
> > >  private:
> > > -  static List<pthread_key> keys;
> > > +  int key_idx;
> > > +  static class keys_list {
> > > +    ULONG seq;
> > 
> > GLibc uses uintptr_t for the sequence number to avoid overflow.
> > So we could use ULONG64 and InterlockedCompareExchange64 here, too.
> > 
> > Looks good to me, thanks!
> 
> New version of the patch attached. This realizes quasi-lock-free
> access to the pthread_keys array. Please review.

Revised.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Sun__6_Apr_2025_19_57_54_+0900_8TaGrpt/CW./d/aV
Content-Type: text/plain;
 name="0001-Cygwin-thread-Use-simple-array-instead-of-List-pthre.patch"
Content-Disposition: attachment;
 filename="0001-Cygwin-thread-Use-simple-array-instead-of-List-pthre.patch"
Content-Transfer-Encoding: base64

RnJvbSBlZDJjNWVlYjFjODQwYmM2YmVhYWJiNGVkM2YxZGY0MjMyNzQwYjJiIE1vbiBTZXAgMTcg
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
LmggfCAzMSArKysrKysrKysrKysrKysrKysrKystLS0tLS0NCiB3aW5zdXAvY3lnd2luL3RocmVh
ZC5jYyAgICAgICAgICAgICAgIHwgMzEgKysrKysrKysrKysrKysrKysrKysrKystLS0tDQogMiBm
aWxlcyBjaGFuZ2VkLCA1MSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCg0KZGlmZiAt
LWdpdCBhL3dpbnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMvdGhyZWFkLmggYi93aW5zdXAvY3ln
d2luL2xvY2FsX2luY2x1ZGVzL3RocmVhZC5oDQppbmRleCBiMzQ5NjI4MWUuLjQ1NWJlMWM5MSAx
MDA2NDQNCi0tLSBhL3dpbnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMvdGhyZWFkLmgNCisrKyBi
L3dpbnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMvdGhyZWFkLmgNCkBAIC0yMjEsMTMgKzIyMSwx
MiBAQCBwdWJsaWM6DQogICB+cHRocmVhZF9rZXkgKCk7DQogICBzdGF0aWMgdm9pZCBmaXh1cF9i
ZWZvcmVfZm9yayAoKQ0KICAgew0KLSAgICBrZXlzLmZvcl9lYWNoICgmcHRocmVhZF9rZXk6Ol9m
aXh1cF9iZWZvcmVfZm9yayk7DQorICAgIGZvcl9lYWNoICgmcHRocmVhZF9rZXk6Ol9maXh1cF9i
ZWZvcmVfZm9yayk7DQogICB9DQogDQogICBzdGF0aWMgdm9pZCBmaXh1cF9hZnRlcl9mb3JrICgp
DQogICB7DQotICAgIGtleXMuZml4dXBfYWZ0ZXJfZm9yayAoKTsNCi0gICAga2V5cy5mb3JfZWFj
aCAoJnB0aHJlYWRfa2V5OjpfZml4dXBfYWZ0ZXJfZm9yayk7DQorICAgIGZvcl9lYWNoICgmcHRo
cmVhZF9rZXk6Ol9maXh1cF9hZnRlcl9mb3JrKTsNCiAgIH0NCiANCiAgIHN0YXRpYyB2b2lkIHJ1
bl9hbGxfZGVzdHJ1Y3RvcnMgKCkNCkBAIC0yNDYsMjEgKzI0NSwzOSBAQCBwdWJsaWM6DQogICAg
IGZvciAoaW50IGkgPSAwOyBpIDwgUFRIUkVBRF9ERVNUUlVDVE9SX0lURVJBVElPTlM7ICsraSkN
CiAgICAgICB7DQogCWl0ZXJhdGVfZHRvcnNfb25jZV9tb3JlID0gZmFsc2U7DQotCWtleXMuZm9y
X2VhY2ggKCZwdGhyZWFkX2tleTo6cnVuX2Rlc3RydWN0b3IpOw0KKwlmb3JfZWFjaCAoJnB0aHJl
YWRfa2V5OjpydW5fZGVzdHJ1Y3Rvcik7DQogCWlmICghaXRlcmF0ZV9kdG9yc19vbmNlX21vcmUp
DQogCSAgYnJlYWs7DQogICAgICAgfQ0KICAgfQ0KIA0KLSAgLyogTGlzdCBzdXBwb3J0IGNhbGxz
ICovDQotICBjbGFzcyBwdGhyZWFkX2tleSAqbmV4dDsNCiBwcml2YXRlOg0KLSAgc3RhdGljIExp
c3Q8cHRocmVhZF9rZXk+IGtleXM7DQorICBpbnQga2V5X2lkeDsNCisgIHN0YXRpYyBjbGFzcyBr
ZXlzX2xpc3Qgew0KKyAgICBMT05HNjQgc2VxOw0KKyAgICBMT05HNjQgYnVzeV9jbnQ7DQorICAg
IHB0aHJlYWRfa2V5ICprZXk7DQorICAgIHN0YXRpYyBib29sIHVzZWQgKExPTkc2NCBzZXExKSB7
IHJldHVybiAoc2VxMSAmIDMpICE9IDA7IH0NCisgICAgc3RhdGljIGJvb2wgcmVhZHkgKExPTkc2
NCBzZXExKSB7IHJldHVybiAoc2VxMSAmIDMpID09IDI7IH0NCisgIHB1YmxpYzoNCisgICAga2V5
c19saXN0ICgpIDogc2VxICgwKSwgYnVzeV9jbnQgKElOVDY0X01JTiksIGtleSAoTlVMTCkge30N
CisgICAgZnJpZW5kIGNsYXNzIHB0aHJlYWRfa2V5Ow0KKyAgfSBrZXlzW1BUSFJFQURfS0VZU19N
QVhdOw0KICAgdm9pZCBfZml4dXBfYmVmb3JlX2ZvcmsgKCk7DQogICB2b2lkIF9maXh1cF9hZnRl
cl9mb3JrICgpOw0KICAgdm9pZCAoKmRlc3RydWN0b3IpICh2b2lkICopOw0KICAgdm9pZCBydW5f
ZGVzdHJ1Y3RvciAoKTsNCiAgIHZvaWQgKmZvcmtfYnVmOw0KKyAgc3RhdGljIHZvaWQgZm9yX2Vh
Y2ggKHZvaWQgKHB0aHJlYWRfa2V5OjoqY2FsbGJhY2spICgpKSB7DQorICAgIGZvciAoc2l6ZV90
IGNudCA9IDA7IGNudCA8IFBUSFJFQURfS0VZU19NQVg7IGNudCsrKQ0KKyAgICAgIHsNCisJaWYg
KCFwdGhyZWFkX2tleTo6a2V5c19saXN0OjpyZWFkeSAoa2V5c1tjbnRdLnNlcSkpDQorCSAgY29u
dGludWU7DQorCWlmIChJbnRlcmxvY2tlZEluY3JlbWVudDY0ICgma2V5c1tjbnRdLmJ1c3lfY250
KSA+IDApDQorCSAgKGtleXNbY250XS5rZXktPipjYWxsYmFjaykgKCk7DQorCUludGVybG9ja2Vk
RGVjcmVtZW50NjQgKCZrZXlzW2NudF0uYnVzeV9jbnQpOw0KKyAgICAgIH0NCisgIH0NCiB9Ow0K
IA0KIGNsYXNzIHB0aHJlYWRfYXR0cjogcHVibGljIHZlcmlmeWFibGVfb2JqZWN0DQpkaWZmIC0t
Z2l0IGEvd2luc3VwL2N5Z3dpbi90aHJlYWQuY2MgYi93aW5zdXAvY3lnd2luL3RocmVhZC5jYw0K
aW5kZXggOWVlOTY1MDRiLi4xNzYwMGJlNzUgMTAwNjQ0DQotLS0gYS93aW5zdXAvY3lnd2luL3Ro
cmVhZC5jYw0KKysrIGIvd2luc3VwL2N5Z3dpbi90aHJlYWQuY2MNCkBAIC0zMiw2ICszMiw3IEBA
IGRldGFpbHMuICovDQogI2luY2x1ZGUgIm50ZGxsLmgiDQogI2luY2x1ZGUgImN5Z3dhaXQuaCIN
CiAjaW5jbHVkZSAiZXhjZXB0aW9uLmgiDQorI2luY2x1ZGUgPGFzc2VydC5oPg0KIA0KIC8qIEZv
ciBMaW51eCBjb21wYXRpYmlsaXR5LCB0aGUgbGVuZ3RoIG9mIGEgdGhyZWFkIG5hbWUgaXMgMTYg
Y2hhcmFjdGVycy4gKi8NCiAjZGVmaW5lIFRIUk5BTUVMRU4gMTYNCkBAIC0xNjY2LDE3ICsxNjY3
LDMxIEBAIHB0aHJlYWRfcndsb2NrOjpfZml4dXBfYWZ0ZXJfZm9yayAoKQ0KIC8qIHB0aHJlYWRf
a2V5ICovDQogLyogc3RhdGljIG1lbWJlcnMgKi8NCiAvKiBUaGlzIHN0b3JlcyBwdGhyZWFkX2tl
eSBpbmZvcm1hdGlvbiBhY3Jvc3MgZm9yaygpIGJvdW5kYXJpZXMgKi8NCi1MaXN0PHB0aHJlYWRf
a2V5PiBwdGhyZWFkX2tleTo6a2V5czsNCitwdGhyZWFkX2tleTo6a2V5c19saXN0IHB0aHJlYWRf
a2V5OjprZXlzW1BUSFJFQURfS0VZU19NQVhdOw0KIA0KIC8qIG5vbi1zdGF0aWMgbWVtYmVycyAq
Lw0KIA0KLXB0aHJlYWRfa2V5OjpwdGhyZWFkX2tleSAodm9pZCAoKmFEZXN0cnVjdG9yKSAodm9p
ZCAqKSk6dmVyaWZ5YWJsZV9vYmplY3QgKFBUSFJFQURfS0VZX01BR0lDKSwgZGVzdHJ1Y3RvciAo
YURlc3RydWN0b3IpDQorcHRocmVhZF9rZXk6OnB0aHJlYWRfa2V5ICh2b2lkICgqYURlc3RydWN0
b3IpICh2b2lkICopKSA6DQorICB2ZXJpZnlhYmxlX29iamVjdCAoUFRIUkVBRF9LRVlfTUFHSUMp
LCBkZXN0cnVjdG9yIChhRGVzdHJ1Y3RvcikNCiB7DQogICB0bHNfaW5kZXggPSBUbHNBbGxvYyAo
KTsNCiAgIGlmICh0bHNfaW5kZXggPT0gVExTX09VVF9PRl9JTkRFWEVTKQ0KICAgICBtYWdpYyA9
IDA7DQogICBlbHNlDQotICAgIGtleXMuaW5zZXJ0ICh0aGlzKTsNCisgICAgZm9yIChzaXplX3Qg
Y250ID0gMDsgY250IDwgUFRIUkVBRF9LRVlTX01BWDsgY250KyspDQorICAgICAgew0KKwlMT05H
NjQgc2VxID0ga2V5c1tjbnRdLnNlcTsNCisJaWYgKCFwdGhyZWFkX2tleTo6a2V5c19saXN0Ojp1
c2VkIChzZXEpDQorCSAgICAmJiBJbnRlcmxvY2tlZENvbXBhcmVFeGNoYW5nZTY0ICgma2V5c1tj
bnRdLnNlcSwNCisJCQkJCSAgICAgc2VxICsgMSwgc2VxKSA9PSBzZXEpDQorCSAgew0KKwkgICAg
a2V5c1tjbnRdLmtleSA9IHRoaXM7DQorCSAgICBrZXlzW2NudF0uYnVzeV9jbnQgPSAwOw0KKwkg
ICAga2V5X2lkeCA9IGNudDsNCisJICAgIEludGVybG9ja2VkSW5jcmVtZW50NjQgKCZrZXlzW2tl
eV9pZHhdLnNlcSk7DQorCSAgICBicmVhazsNCisJICB9DQorICAgICAgfQ0KIH0NCiANCiBwdGhy
ZWFkX2tleTo6fnB0aHJlYWRfa2V5ICgpDQpAQCAtMTY4NSw3ICsxNzAwLDE1IEBAIHB0aHJlYWRf
a2V5Ojp+cHRocmVhZF9rZXkgKCkNCiAgICAqLw0KICAgaWYgKG1hZ2ljICE9IDApDQogICAgIHsN
Ci0gICAgICBrZXlzLnJlbW92ZSAodGhpcyk7DQorICAgICAgTE9ORzY0IHNlcSA9IGtleXNba2V5
X2lkeF0uc2VxOw0KKyAgICAgIGFzc2VydCAocHRocmVhZF9rZXk6OmtleXNfbGlzdDo6cmVhZHkg
KHNlcSkNCisJICAgICAgJiYgSW50ZXJsb2NrZWRDb21wYXJlRXhjaGFuZ2U2NCAoJmtleXNba2V5
X2lkeF0uc2VxLA0KKwkJCQkJICAgICAgIHNlcSArIDEsIHNlcSkgPT0gc2VxKTsNCisgICAgICB3
aGlsZSAoSW50ZXJsb2NrZWRDb21wYXJlRXhjaGFuZ2U2NCAoJmtleXNba2V5X2lkeF0uYnVzeV9j
bnQsDQorCQkJCQkgICBJTlQ2NF9NSU4sIDApID4gMCkNCisJeWllbGQgKCk7DQorICAgICAga2V5
c1trZXlfaWR4XS5rZXkgPSBOVUxMOw0KKyAgICAgIEludGVybG9ja2VkSW5jcmVtZW50NjQgKCZr
ZXlzW2tleV9pZHhdLnNlcSk7DQogICAgICAgVGxzRnJlZSAodGxzX2luZGV4KTsNCiAgICAgfQ0K
IH0NCi0tIA0KMi40NS4xDQoNCg==

--Multipart=_Sun__6_Apr_2025_19_57_54_+0900_8TaGrpt/CW./d/aV--
