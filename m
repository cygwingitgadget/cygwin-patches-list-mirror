Return-Path: <SRS0=HM4H=5R=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e04.mail.nifty.com (mta-snd-e04.mail.nifty.com [106.153.226.36])
	by sourceware.org (Postfix) with ESMTPS id 5F61D3858D33
	for <cygwin-patches@cygwin.com>; Sun,  9 Nov 2025 20:23:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5F61D3858D33
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5F61D3858D33
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1762719792; cv=none;
	b=FRyC+bJxeyq8QogwxXTL71iQsTWzUazFQcr1GxlBZhLQgzg4Dhl+bsWU/WmeFcmF9eWZsLe+afTESApAIuDRYaLaOuRGNqF28Ea20HGJ2IZH7mm/I3P/5vTysuu/JAXkXdTbsWcX3N5wc97Ts+IF3He+hIvG0N2oE4woSJNVzjY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1762719792; c=relaxed/simple;
	bh=iWnsLODTcn3Az3WPC15zHSrR3dgGJTx/rm4zJIVLLHg=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=ofIeo/ayJKBQ5H1A28uNTV1GWyJIib+y2Gcb9phUVzDKkmb21IHKnGjqlJd6RqWQDjb9Al98NJLEZhatN1hnbV34cs3HFNk/PdJbBvA+09LfK4clHVtSMFzy0UBzQLqAf1I47OKnU/e4GJW5Z3+9c7Deliuz41YQVBGj1Rs5OwQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5F61D3858D33
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Zi6q0gIs
Received: from HP-Z230 by mta-snd-e04.mail.nifty.com with ESMTP
          id <20251109202309189.JLKB.90539.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 10 Nov 2025 05:23:09 +0900
Date: Mon, 10 Nov 2025 05:23:07 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Fixes for dll_init.cc
Message-Id: <20251110052307.dd75d05fc7422845cdd2941b@nifty.ne.jp>
In-Reply-To: <5187ab5f-3d7b-451e-ab73-b2d0d1c0dffd@dronecode.org.uk>
References: <20251028114853.11052-1-takashi.yano@nifty.ne.jp>
	<20251105135842.e9c501e7cce6ec6603acc124@nifty.ne.jp>
	<1034b8d0-4de7-407c-a9f1-6c2ba7744380@maxrnd.com>
	<20251109180214.06d195f84ddb678ca1a0ca27@nifty.ne.jp>
	<5187ab5f-3d7b-451e-ab73-b2d0d1c0dffd@dronecode.org.uk>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Mon__10_Nov_2025_05_23_07_+0900_jT/mlHP.4edA_I.8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1762719789;
 bh=ODjW44qpIcTga3P7iZC5WILhdT7z8SfX3dghSI2k1ks=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=Zi6q0gIsebVyCGV0/pq+jARaRrxdXrqBhiVgGEJAqYZjE5DHuv6/bzPwy6OXoCAtmz2sWKPa
 b+rsFdNpzMSX+yoeqK5hyUDnNX7/OY8zEJZdTYj8FHnH5RD4SctTOSOEasTHjMSyZ9KFygybpu
 AdQ7+QGl6Jr4LpW3OpfmXATVSk+cVkqe4503+katOJ8q9KdLDuTnjm6aFJp8n96XlfkJK2sWLY
 4JJcgH+l2JasB+/b4y9UPo+ovFrI+8XoXmzsFTL77GAvFFYQdtT6csyVNHF3TiSMojFQ4YPpq8
 n4P9mRzbKLKifRz3+46RB7JH4tWLZLjh10bWVfhDYtG0nGeQ==
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.

--Multipart=_Mon__10_Nov_2025_05_23_07_+0900_jT/mlHP.4edA_I.8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jon,

On Sun, 9 Nov 2025 16:30:18 +0000
Jon Turney wrote:
> On 09/11/2025 09:02, Takashi Yano wrote:
> > Hi Mark,
> > 
> > On Sun, 9 Nov 2025 00:09:07 -0800
> > Mark Geisert wrote:
> >> Hi Takashi,
> >>
> >> On 11/4/2025 8:58 PM, Takashi Yano wrote:
> >>> On Tue, 28 Oct 2025 20:48:40 +0900
> >>> Takashi Yano wrote:
> >>>> Takashi Yano (2):
> >>>>     Cygwin: dll_init: Call __cxa_finalize() for DLL_LOAD even in
> >>>>       exit_state
> >>>>     Cygwin: dll_init: Don't call dll::init() twice for DLL_LOAD.
> >>>>
> >>>>    winsup/cygwin/dll_init.cc | 8 +++++---
> >>>>    1 file changed, 5 insertions(+), 3 deletions(-)
> >>>>
> >>>> -- 
> >>>> 2.51.0
> >>>>
> >>>
> >>> Could anyone please review if these patches make sense?
> >>
> >> The patches look fine to me.  Do you happen to have an STC that
> >> demonstrates to you the issue is fixed with your patch?
> > 
> > Thanks for reviewing. The STC is the attachment files in
> > https://cygwin.com/pipermail/cygwin/2025-October/258919.html
> 
> I'm finding it pretty hard to reason about what the possible 
> combinations that should be considered are.
> 
> Like, what is the spanning set? I guess we have:
> 
> 1. A single DLL X, directly linked with by executable
> 2. A single DLL X, dlopened and dlclosed (subcases where it does this 
> during constructor/destructors and otherwise?)
> 3. As above, but X is directly linked with Y
> 4. As above, but X is dlopens/dlcloses Y
> 5. more???
> 
> If I understood all that, then maybe I'd have some suggestions about how 
> the comments can be written to explain why what it's doing is the right 
> thing in the various situations.
> 
> I guess it's possible to extend that STC to cover all those?

Thanks for the advice.

I have extended the STC to cover all the cases:
main-dll2 { direct | dlopen | dlopen-wo-dlclose }
dll2-dll3 { direct | dlopen | dlopen-in-ctor | dlopen-wo-dlclose | dlopen-in-ctor-wo-dlclose }
, that is, 15 test cases in total.

I confirmed that all the test cases work as expected.

Please try new STC attached. (Just run 'make test')

As for comments in the source code and commit message, please
let me consider a bit.

Thanks.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Mon__10_Nov_2025_05_23_07_+0900_jT/mlHP.4edA_I.8
Content-Type: text/x-csrc;
 name="dll2.c"
Content-Disposition: attachment;
 filename="dll2.c"
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <dlfcn.h>
static void *dll3;
static void dllinit(void) __attribute__((constructor));
static void dllinit(void)
{
	printf("+++++++++++++++++++++++++++++\n");
#if DLLB == 2
	dll3 = dlopen("dll3.dll", RTLD_LOCAL|RTLD_NOW);
#endif
}
static void dllquit(void) __attribute__((destructor));
static void dllquit(void)
{
	printf("-----------------------------\n");
#if DLLB == 2 && !defined(NO_DLCLOSE)
	dlclose(dll3);
#endif
}
void func2()
{
	void (*func)(void);
#if DLLB == 0
	extern void func3(void);
	func = func3;
#endif
#if DLLB == 1
	dll3 = dlopen("dll3.dll", RTLD_LOCAL|RTLD_NOW);
#endif
#if DLLB != 0
	func = dlsym(dll3, "func3");
#endif
	func();
#if DLLB == 1 && !defined(NO_DLCLOSE)
	dlclose(dll3);
#endif
}

--Multipart=_Mon__10_Nov_2025_05_23_07_+0900_jT/mlHP.4edA_I.8
Content-Type: text/x-csrc;
 name="dll3.c"
Content-Disposition: attachment;
 filename="dll3.c"
Content-Transfer-Encoding: 7bit

#include <stdio.h>
static void dllinit(void) __attribute__((constructor));
static void dllinit(void)
{
	printf("++++++++++++++\n");
}
static void dllquit(void) __attribute__((destructor));
static void dllquit(void)
{
	printf("--------------\n");
}
void func3()
{
	printf("oooooooooooooo\n");
}

--Multipart=_Mon__10_Nov_2025_05_23_07_+0900_jT/mlHP.4edA_I.8
Content-Type: text/x-csrc;
 name="main.c"
Content-Disposition: attachment;
 filename="main.c"
Content-Transfer-Encoding: 7bit

#include <dlfcn.h>
int main()
{
	void (*func)(void);
#if DLLA == 0
	extern void func2();
	func = func2;
#endif
#if DLLA != 0
	void *dll2 = dlopen("dll2_1.dll", RTLD_LOCAL|RTLD_NOW);
	func = dlsym(dll2, "func2");
#endif
	func();
#if DLLA == 1 && !defined(NO_DLCLOSE)
	dlclose(dll2);
#endif
	return 0;
}

--Multipart=_Mon__10_Nov_2025_05_23_07_+0900_jT/mlHP.4edA_I.8
Content-Type: text/plain;
 name="Makefile"
Content-Disposition: attachment;
 filename="Makefile"
Content-Transfer-Encoding: base64

YWxsOiBjYXNlMCBjYXNlMSBjYXNlMiBjYXNlMyBjYXNlNCBjYXNlNSBjYXNlNiBjYXNlNyBjYXNl
OCBjYXNlOSBjYXNlMTAgY2FzZTExIGNhc2UxMiBjYXNlMTMgY2FzZTE0DQoNCmNhc2UwOiBtYWlu
LmMgZGxsMl8wLmRsbA0KCSQoQ0MpIC1ERExMQT0wIG1haW4uYyBkbGwyXzAuZGxsIC1vIGNhc2Uw
DQoNCmNhc2UxOiBtYWluLmMgZGxsMl8xLmRsbA0KCSQoQ0MpIC1ERExMQT0wIG1haW4uYyBkbGwy
XzEuZGxsIC1vIGNhc2UxDQoNCmNhc2UyOiBtYWluLmMgZGxsMl8yLmRsbA0KCSQoQ0MpIC1ERExM
QT0wIG1haW4uYyBkbGwyXzIuZGxsIC1vIGNhc2UyDQoNCmNhc2UzOiBtYWluLmMgZGxsMl8xbi5k
bGwNCgkkKENDKSAtRERMTEE9MCBtYWluLmMgZGxsMl8xbi5kbGwgLW8gY2FzZTMNCg0KY2FzZTQ6
IG1haW4uYyBkbGwyXzJuLmRsbA0KCSQoQ0MpIC1ERExMQT0wIG1haW4uYyBkbGwyXzJuLmRsbCAt
byBjYXNlNA0KDQpjYXNlNTogbWFpbi5jIGRsbDJfMC5kbGwNCgkkKENDKSAtRERMTEE9MSBtYWlu
LmMgZGxsMl8wLmRsbCAtbyBjYXNlNQ0KDQpjYXNlNjogbWFpbi5jIGRsbDJfMS5kbGwNCgkkKEND
KSAtRERMTEE9MSBtYWluLmMgZGxsMl8xLmRsbCAtbyBjYXNlNg0KDQpjYXNlNzogbWFpbi5jIGRs
bDJfMi5kbGwNCgkkKENDKSAtRERMTEE9MSBtYWluLmMgZGxsMl8yLmRsbCAtbyBjYXNlNw0KDQpj
YXNlODogbWFpbi5jIGRsbDJfMS5kbGwNCgkkKENDKSAtRERMTEE9MSBtYWluLmMgZGxsMl8xbi5k
bGwgLW8gY2FzZTgNCg0KY2FzZTk6IG1haW4uYyBkbGwyXzIuZGxsDQoJJChDQykgLURETExBPTEg
bWFpbi5jIGRsbDJfMm4uZGxsIC1vIGNhc2U5DQoNCmNhc2UxMDogbWFpbi5jIGRsbDJfMC5kbGwN
CgkkKENDKSAtRERMTEE9MSAtRE5PX0RMQ0xPU0UgbWFpbi5jIGRsbDJfMC5kbGwgLW8gY2FzZTEw
DQoNCmNhc2UxMTogbWFpbi5jIGRsbDJfMS5kbGwNCgkkKENDKSAtRERMTEE9MSAtRE5PX0RMQ0xP
U0UgbWFpbi5jIGRsbDJfMS5kbGwgLW8gY2FzZTExDQoNCmNhc2UxMjogbWFpbi5jIGRsbDJfMi5k
bGwNCgkkKENDKSAtRERMTEE9MSAtRE5PX0RMQ0xPU0UgbWFpbi5jIGRsbDJfMi5kbGwgLW8gY2Fz
ZTEyDQoNCmNhc2UxMzogbWFpbi5jIGRsbDJfMS5kbGwNCgkkKENDKSAtRERMTEE9MSAtRE5PX0RM
Q0xPU0UgbWFpbi5jIGRsbDJfMW4uZGxsIC1vIGNhc2UxMw0KDQpjYXNlMTQ6IG1haW4uYyBkbGwy
XzIuZGxsDQoJJChDQykgLURETExBPTEgLUROT19ETENMT1NFIG1haW4uYyBkbGwyXzJuLmRsbCAt
byBjYXNlMTQNCg0KZGxsMl8wLmRsbDogZGxsMi5jIGRsbDMuZGxsDQoJJChDQykgLURETExCPTAg
ZGxsMi5jIGRsbDMuZGxsIC1zaGFyZWQgLW8gZGxsMl8wLmRsbA0KDQpkbGwyXzEuZGxsOiBkbGwy
LmMNCgkkKENDKSAtRERMTEI9MSBkbGwyLmMgLXNoYXJlZCAtbyBkbGwyXzEuZGxsDQoNCmRsbDJf
Mi5kbGw6IGRsbDIuYw0KCSQoQ0MpIC1ERExMQj0yIGRsbDIuYyAtc2hhcmVkIC1vIGRsbDJfMi5k
bGwNCg0KZGxsMl8xbi5kbGw6IGRsbDIuYw0KCSQoQ0MpIC1ERExMQj0xIC1ETk9fRExDTE9TRSBk
bGwyLmMgLXNoYXJlZCAtbyBkbGwyXzFuLmRsbA0KDQpkbGwyXzJuLmRsbDogZGxsMi5jDQoJJChD
QykgLURETExCPTIgLUROT19ETENMT1NFIGRsbDIuYyAtc2hhcmVkIC1vIGRsbDJfMm4uZGxsDQoN
CmRsbDMuZGxsOiBkbGwzLmMNCgkkKENDKSBkbGwzLmMgLXNoYXJlZCAtbyBkbGwzLmRsbA0KDQp0
ZXN0OiBhbGwNCgkuL2Nhc2UwDQoJLi9jYXNlMQ0KCS4vY2FzZTINCgkuL2Nhc2UzDQoJLi9jYXNl
NA0KCS4vY2FzZTUNCgkuL2Nhc2U2DQoJLi9jYXNlNw0KCS4vY2FzZTgNCgkuL2Nhc2U5DQoJLi9j
YXNlMTANCgkuL2Nhc2UxMQ0KCS4vY2FzZTEyDQoJLi9jYXNlMTMNCgkuL2Nhc2UxNA0KDQpjbGVh
bjoNCgkkKFJNKSAtZiAqLmV4ZSAqLmRsbA0K

--Multipart=_Mon__10_Nov_2025_05_23_07_+0900_jT/mlHP.4edA_I.8--
