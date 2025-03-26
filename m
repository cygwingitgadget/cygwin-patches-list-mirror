Return-Path: <SRS0=N7Gl=WN=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w01.mail.nifty.com (mta-snd-w01.mail.nifty.com [106.153.227.33])
	by sourceware.org (Postfix) with ESMTPS id 54C0B3858280
	for <cygwin-patches@cygwin.com>; Wed, 26 Mar 2025 09:14:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 54C0B3858280
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 54C0B3858280
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1742980449; cv=none;
	b=BwHRWI5QvspudIvQTo7TqP4B8mIEVlweJlJrsL3HRRcheUiEDa6IrrVVIlH/uFKJZV5Pa7bTlmKE3vGqCORCCRCIMaro9/1JACzFrlgmfG+ozHfVknyHLB8zVNk0U5omeLXdU9uAGinruTnVXKRV26jkPqLNtTexKKmoBK9jhfQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1742980449; c=relaxed/simple;
	bh=P0Ej6Ncq9ppOn0cie00+8aeOMQVfAlPWKpIi/l/DhQA=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=WC542DbdNJ3QkcRzhkkRemsxl7Vy7CCLOX8RM+rXWq7zeGNUW+wxEmMOxXtvIWi5UjYIEd4oI7ndIAfwsh3X0nlxnybl+omHrnMXknI0CUWcri53GoWWbUh0HrB7DTxqS6ZW1+gOlEtVWWvxQiRn/D17doWMRKcpE/R7AFauicA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 54C0B3858280
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=tsdZ0bXA
Received: from HP-Z230 by mta-snd-w01.mail.nifty.com with ESMTP
          id <20250326091404943.LKAA.69071.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 26 Mar 2025 18:14:04 +0900
Date: Wed, 26 Mar 2025 18:14:04 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: thread: Allow fast_mutex to be acquired
 multiple times.
Message-Id: <20250326181404.847ecfadcad8977024580575@nifty.ne.jp>
In-Reply-To: <Z-F7rKIQfY2aYHSD@calimero.vinschen.de>
References: <20250324055340.975-1-takashi.yano@nifty.ne.jp>
	<Z-E6groYVnQAh-kj@calimero.vinschen.de>
	<20250324220522.fc26bee8c8cc50bae0ad742b@nifty.ne.jp>
	<Z-F7rKIQfY2aYHSD@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__26_Mar_2025_18_14_04_+0900_Hx1z5Sb_eimDIGfZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1742980445;
 bh=aHZENP0+PbqrvUK6KYZheazD5/jjv97j4AILVdi4Z/I=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=tsdZ0bXAd2l3lXnIOAuMx8OTCvzy2xb3+hd482V2ApC5JqG31XpxN+LWR4unkpBoWPYt981k
 1vB7SsLTeJoY6SBvzr6lwN++ENtChtIDZAbBaYGuiq65N+1vJ7YgDxaEo/1ngMtA9IF+eM/Sn6
 8AVZg2lFM1Fc4MnPtwS1ePFRO1pKs+0f+W2hNmJZXon4C7Z/gSyzaxPwjefSXRLaTkYdiAMo4Z
 L6QsriEcF8gehq5sWUmZ+Uz6CwYkNJY0eGGvCjzvLcuVkYHJv2G3AClugDm+EhP1MlPLOlQWcx
 XbOwgBR1zXoItJ8a7/GuS0p2arGB5zE73X/TjsNeEtXQmLYA==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.

--Multipart=_Wed__26_Mar_2025_18_14_04_+0900_Hx1z5Sb_eimDIGfZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Corinna,

On Mon, 24 Mar 2025 16:35:08 +0100
Corinna Vinschen wrote:
> On Mar 24 22:05, Takashi Yano wrote:
> > Hi Corinna,
> > 
> > On Mon, 24 Mar 2025 11:57:06 +0100
> > Corinna Vinschen wrote:
> > > On Mar 24 14:53, Takashi Yano wrote:
> > > > Previously, the fast_mutex defined in thread.h could not be aquired
> > > > multiple times, i.e., the thread causes deadlock if it attempted to
> > > > acquire a lock already acquired by the thread. For example, a deadlock
> > > > occurs if another pthread_key_create() is called in the destructor
> > > > specified in the previous pthread_key_create(). This is because the
> > > > run_all_destructors() calls the desructor via keys.for_each() where
> > > > both for_each() and pthread_key_create() (that calls List_insert())
> > > > attempt to acquire the lock. With this patch, the fast_mutex can be
> > > > acquired multiple times by the same thread similar to the behaviour
> > > > of a Windows mutex. In this implementation, the mutex is released
> > > > only when the number of unlock() calls matches the number of lock()
> > > > calls.
> > > 
> > > Doesn't that mean fast_mutex is now the same thing as muto?  The
> > > muto type was recursive from the beginning.  It's kind of weird
> > > to maintain two lock types which are equivalent.
> > 
> > I have just looked at muto implementation. Yeah, it looks very
> > similar to fast_mutex with this patch. However, the performance
> > is different. fast_mutex with this patch is two times faster
> > than muto when just repeatedly locking/unlocking. If two threads
> > compete for the same mutex, the performance is almost the same.
> 
> Ok, nice to know.  With fast_mutex being mostly faster and being
> recursive with your patch, maybe we could replace all mutos with
> this fast_mutex?
> 
> > > I wonder if we shouldn't drop the keys list structure entirely, and
> > > convert "keys" to a simple sequence number + destructor array, as in
> > > GLibc.  This allows lockless key operations and drop the entire list and
> > > mutex overhead.  The code would become dirt-easy, see
> > > https://sourceware.org/cgit/glibc/tree/nptl/pthread_key_create.c
> > > https://sourceware.org/cgit/glibc/tree/nptl/pthread_key_delete.c
> > > 
> > > What do you think?
> > 
> > It looks very simple and reasonable to me.
> > 
> > > However, for 3.6.1, the below patch should be ok.
> > 
> > What about reimplementing pthread_key_create/pthread_key_delete
> > based on glibc for master branch, and appling this patch to
> > cygwin-3_6-branch?
> > 
> > Shall I try to reimplement them?
> 
> That would be great!

What about the patch attached?
Is this as you intended?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Wed__26_Mar_2025_18_14_04_+0900_Hx1z5Sb_eimDIGfZ
Content-Type: text/plain;
 name="pthread_key.patch"
Content-Disposition: attachment;
 filename="pthread_key.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMvdGhyZWFkLmggYi93aW5z
dXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL3RocmVhZC5oDQppbmRleCBiMzQ5NjI4MWUuLmQxODJk
OTFjZSAxMDA2NDQNCi0tLSBhL3dpbnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMvdGhyZWFkLmgN
CisrKyBiL3dpbnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMvdGhyZWFkLmgNCkBAIC0yMjEsMTMg
KzIyMSwyOCBAQCBwdWJsaWM6DQogICB+cHRocmVhZF9rZXkgKCk7DQogICBzdGF0aWMgdm9pZCBm
aXh1cF9iZWZvcmVfZm9yayAoKQ0KICAgew0KLSAgICBrZXlzLmZvcl9lYWNoICgmcHRocmVhZF9r
ZXk6Ol9maXh1cF9iZWZvcmVfZm9yayk7DQorICAgIGZvciAoc2l6ZV90IGNudCA9IDA7IGNudCA8
IFBUSFJFQURfS0VZU19NQVg7IGNudCsrKQ0KKyAgICAgIHsNCisJaWYgKCFrZXlzW2NudF0udW51
c2VkICgpKQ0KKwkgIHsNCisJICAgIHdoaWxlIChrZXlzW2NudF0uYnVzeSAoKSkNCisJICAgICAg
U2xlZXAgKDBMKTsNCisJICAgIGtleXNbY250XS5rZXktPl9maXh1cF9iZWZvcmVfZm9yayAoKTsN
CisJICB9DQorICAgICAgfQ0KICAgfQ0KIA0KICAgc3RhdGljIHZvaWQgZml4dXBfYWZ0ZXJfZm9y
ayAoKQ0KICAgew0KLSAgICBrZXlzLmZpeHVwX2FmdGVyX2ZvcmsgKCk7DQotICAgIGtleXMuZm9y
X2VhY2ggKCZwdGhyZWFkX2tleTo6X2ZpeHVwX2FmdGVyX2ZvcmspOw0KKyAgICBmb3IgKHNpemVf
dCBjbnQgPSAwOyBjbnQgPCBQVEhSRUFEX0tFWVNfTUFYOyBjbnQrKykNCisgICAgICB7DQorCWlm
ICgha2V5c1tjbnRdLnVudXNlZCAoKSkNCisJICB7DQorCSAgICB3aGlsZSAoa2V5c1tjbnRdLmJ1
c3kgKCkpDQorCSAgICAgIFNsZWVwICgwTCk7DQorCSAgICBrZXlzW2NudF0ua2V5LT5fZml4dXBf
YWZ0ZXJfZm9yayAoKTsNCisJICB9DQorICAgICAgfQ0KICAgfQ0KIA0KICAgc3RhdGljIHZvaWQg
cnVuX2FsbF9kZXN0cnVjdG9ycyAoKQ0KQEAgLTI0NiwxNiArMjYxLDMyIEBAIHB1YmxpYzoNCiAg
ICAgZm9yIChpbnQgaSA9IDA7IGkgPCBQVEhSRUFEX0RFU1RSVUNUT1JfSVRFUkFUSU9OUzsgKytp
KQ0KICAgICAgIHsNCiAJaXRlcmF0ZV9kdG9yc19vbmNlX21vcmUgPSBmYWxzZTsNCi0Ja2V5cy5m
b3JfZWFjaCAoJnB0aHJlYWRfa2V5OjpydW5fZGVzdHJ1Y3Rvcik7DQorCWZvciAoc2l6ZV90IGNu
dCA9IDA7IGNudCA8IFBUSFJFQURfS0VZU19NQVg7IGNudCsrKQ0KKwkgIHsNCisJICAgIGlmICgh
a2V5c1tjbnRdLnVudXNlZCAoKSkNCisJICAgICAgew0KKwkJd2hpbGUgKGtleXNbY250XS5idXN5
ICgpKQ0KKwkJICBTbGVlcCAoMEwpOw0KKwkJa2V5c1tjbnRdLmtleS0+cnVuX2Rlc3RydWN0b3Ig
KCk7DQorCSAgICAgIH0NCisJICB9DQogCWlmICghaXRlcmF0ZV9kdG9yc19vbmNlX21vcmUpDQog
CSAgYnJlYWs7DQogICAgICAgfQ0KICAgfQ0KIA0KLSAgLyogTGlzdCBzdXBwb3J0IGNhbGxzICov
DQotICBjbGFzcyBwdGhyZWFkX2tleSAqbmV4dDsNCiBwcml2YXRlOg0KLSAgc3RhdGljIExpc3Q8
cHRocmVhZF9rZXk+IGtleXM7DQorICBpbnQga2V5X2lkeDsNCisgIHN0YXRpYyBjbGFzcyBrZXlz
X2xpc3Qgew0KKyAgICBVTE9ORyBzZXE7DQorICAgIHB0aHJlYWRfa2V5ICprZXk7DQorICAgIGJv
b2wgdW51c2VkICgpIHsgcmV0dXJuIChzZXEgJiAzKSA9PSAwOyB9DQorICAgIGJvb2wgdXNhYmxl
ICgpIHsgcmV0dXJuIHNlcSA8IHNlcSArIDQ7IH0NCisgICAgYm9vbCBidXN5ICgpIHsgcmV0dXJu
IChzZXEgJiAzKSA9PSAxOyB9DQorICBwdWJsaWM6DQorICAgIGtleXNfbGlzdCAoKSA6IHNlcSAo
MCksIGtleSAoTlVMTCkge30NCisgICAgZnJpZW5kIGNsYXNzIHB0aHJlYWRfa2V5Ow0KKyAgfSBr
ZXlzW1BUSFJFQURfS0VZU19NQVhdOw0KICAgdm9pZCBfZml4dXBfYmVmb3JlX2ZvcmsgKCk7DQog
ICB2b2lkIF9maXh1cF9hZnRlcl9mb3JrICgpOw0KICAgdm9pZCAoKmRlc3RydWN0b3IpICh2b2lk
ICopOw0KZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vdGhyZWFkLmNjIGIvd2luc3VwL2N5Z3dp
bi90aHJlYWQuY2MNCmluZGV4IDllZTk2NTA0Yi4uYTZhOTk2MmI0IDEwMDY0NA0KLS0tIGEvd2lu
c3VwL2N5Z3dpbi90aHJlYWQuY2MNCisrKyBiL3dpbnN1cC9jeWd3aW4vdGhyZWFkLmNjDQpAQCAt
MTY2NiwxNyArMTY2NiwzMCBAQCBwdGhyZWFkX3J3bG9jazo6X2ZpeHVwX2FmdGVyX2ZvcmsgKCkN
CiAvKiBwdGhyZWFkX2tleSAqLw0KIC8qIHN0YXRpYyBtZW1iZXJzICovDQogLyogVGhpcyBzdG9y
ZXMgcHRocmVhZF9rZXkgaW5mb3JtYXRpb24gYWNyb3NzIGZvcmsoKSBib3VuZGFyaWVzICovDQot
TGlzdDxwdGhyZWFkX2tleT4gcHRocmVhZF9rZXk6OmtleXM7DQorcHRocmVhZF9rZXk6OmtleXNf
bGlzdCBwdGhyZWFkX2tleTo6a2V5c1tQVEhSRUFEX0tFWVNfTUFYXTsNCiANCiAvKiBub24tc3Rh
dGljIG1lbWJlcnMgKi8NCiANCi1wdGhyZWFkX2tleTo6cHRocmVhZF9rZXkgKHZvaWQgKCphRGVz
dHJ1Y3RvcikgKHZvaWQgKikpOnZlcmlmeWFibGVfb2JqZWN0IChQVEhSRUFEX0tFWV9NQUdJQyks
IGRlc3RydWN0b3IgKGFEZXN0cnVjdG9yKQ0KK3B0aHJlYWRfa2V5OjpwdGhyZWFkX2tleSAodm9p
ZCAoKmFEZXN0cnVjdG9yKSAodm9pZCAqKSkgOg0KKyAgdmVyaWZ5YWJsZV9vYmplY3QgKFBUSFJF
QURfS0VZX01BR0lDKSwgZGVzdHJ1Y3RvciAoYURlc3RydWN0b3IpDQogew0KICAgdGxzX2luZGV4
ID0gVGxzQWxsb2MgKCk7DQogICBpZiAodGxzX2luZGV4ID09IFRMU19PVVRfT0ZfSU5ERVhFUykN
CiAgICAgbWFnaWMgPSAwOw0KICAgZWxzZQ0KLSAgICBrZXlzLmluc2VydCAodGhpcyk7DQorICAg
IGZvciAoc2l6ZV90IGNudCA9IDA7IGNudCA8IFBUSFJFQURfS0VZU19NQVg7IGNudCsrKQ0KKyAg
ICAgIHsNCisJVUxPTkcgc2VxID0ga2V5c1tjbnRdLnNlcTsNCisJaWYgKGtleXNbY250XS51bnVz
ZWQgKCkgJiYga2V5c1tjbnRdLnVzYWJsZSAoKQ0KKwkgICAgJiYgSW50ZXJsb2NrZWRDb21wYXJl
RXhjaGFuZ2UgKCZrZXlzW2NudF0uc2VxLA0KKwkJCQkJICAgc2VxICsgMSwgc2VxKSA9PSBzZXEp
DQorCSAgew0KKwkgICAga2V5c1tjbnRdLmtleSA9IHRoaXM7DQorCSAgICBrZXlfaWR4ID0gY250
Ow0KKwkgICAgSW50ZXJsb2NrZWRDb21wYXJlRXhjaGFuZ2UgKCZrZXlzW2NudF0uc2VxLCBzZXEg
KyAzLCBzZXEgKyAxKTsNCisJICAgIGJyZWFrOw0KKwkgIH0NCisgICAgICB9DQogfQ0KIA0KIHB0
aHJlYWRfa2V5Ojp+cHRocmVhZF9rZXkgKCkNCkBAIC0xNjg1LDcgKzE2OTgsMTQgQEAgcHRocmVh
ZF9rZXk6On5wdGhyZWFkX2tleSAoKQ0KICAgICovDQogICBpZiAobWFnaWMgIT0gMCkNCiAgICAg
ew0KLSAgICAgIGtleXMucmVtb3ZlICh0aGlzKTsNCisgICAgICBVTE9ORyBzZXEgPSBrZXlzW2tl
eV9pZHhdLnNlcTsNCisgICAgICBpZiAoIWtleXNba2V5X2lkeF0udW51c2VkICgpKQ0KKwl7DQor
CSAgd2hpbGUgKGtleXNba2V5X2lkeF0uYnVzeSAoKSkNCisJICAgIHlpZWxkICgpOw0KKwkgIGtl
eXNba2V5X2lkeF0ua2V5ID0gTlVMTDsNCisJICBJbnRlcmxvY2tlZENvbXBhcmVFeGNoYW5nZSAo
JmtleXNba2V5X2lkeF0uc2VxLCBzZXEgKyAxLCBzZXEpOw0KKwl9DQogICAgICAgVGxzRnJlZSAo
dGxzX2luZGV4KTsNCiAgICAgfQ0KIH0NCg==

--Multipart=_Wed__26_Mar_2025_18_14_04_+0900_Hx1z5Sb_eimDIGfZ--
