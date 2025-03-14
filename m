Return-Path: <SRS0=LZhN=WB=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 0CC523857C7A
	for <cygwin-patches@cygwin.com>; Fri, 14 Mar 2025 03:56:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0CC523857C7A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0CC523857C7A
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1741924585; cv=none;
	b=Injsxs7XvFLs5EKZWIEt41fPxWPV1rnm0TXXRzRN8cKyrOf8y7lRfKcwXOkoZ6KjvgxdM1s8/GPOm6AoEldNrhAmHdNqlJKWjVTnJMdFLd+n/MLtnNpkZpyeDsz06uz9bNZq+6zDETpAsg54KqUDglfQ0otQ4upDvCIFircGwsk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1741924585; c=relaxed/simple;
	bh=iUmFmnyQXWb5j3JIurUI45iWM15kWGuZp5kxKRRFJ2w=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=JyFr4MOJvaKtxYIU0vUbEvV759mVGI2qLDFmo4aDpvSIZ79F4hASENmJwaYZVvOHwKH5X0Iqzp/BgypY5IDcMEYGJEDCQ+wqkxLyihFzfq2Kf+wWQEhncKZphPY+9uXUqMYooT6IEYFKWUVslLbyqYTRibgcFOatr902X4YjIf0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0CC523857C7A
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Pi1+g9PQ
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20250314035620188.DLBS.17135.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 14 Mar 2025 12:56:20 +0900
Date: Fri, 14 Mar 2025 12:56:18 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 1/6] Cygwin: signal: Redesign signal queue handling
Message-Id: <20250314125618.275feb1cd1fe1469a80a396b@nifty.ne.jp>
In-Reply-To: <Z9GqRY2Z4wjsxi3F@calimero.vinschen.de>
References: <20250312032748.233077-1-takashi.yano@nifty.ne.jp>
	<20250312032748.233077-2-takashi.yano@nifty.ne.jp>
	<Z9Fs_Dyagj26Jszv@calimero.vinschen.de>
	<20250313000837.26b0c5a4ba4185647544dc4e@nifty.ne.jp>
	<Z9GqRY2Z4wjsxi3F@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Fri__14_Mar_2025_12_56_18_+0900_AKbZPykmXMp=TW4d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1741924580;
 bh=8ZJPxy+h5Bo0J1mSo78NmRoT6YxA66+H93Egim40TlM=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=Pi1+g9PQFtCtkVvP4BoMUjFirDohI00tF4lcAHRJC3H82UmDEezXM1KFc0A8BjwWlbK5qUFE
 vrV5ovqQe0iwtcHdBKZEAQ2iOqWgSVPgMW1i85UGlaOD4M9gFHfOmgG+mfJm3KtB1ko4/RI8nY
 fGI75g5z1kXQdWVrb7276nbyqxM3LsPyKS0hnNqjPrjRB+kVx87/TtvZnms9edJM/JKlRiIpSA
 VI1CrJE4ohYBebbbKoW6xC9CfkRXPyBhKA8DYPg13iaeY+B/Wo7cGXYSALvMO+YVQeeWWKLcxR
 IPLV0BoX6JdJ0GLnpTbHH1rPMadIEYqdDGb6LfVidrGd3q7w==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SCC_5_SHORT_WORD_LINES,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.

--Multipart=_Fri__14_Mar_2025_12_56_18_+0900_AKbZPykmXMp=TW4d
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Corinna,

On Wed, 12 Mar 2025 16:37:41 +0100
Corinna Vinschen wrote:
> On Mar 13 00:08, Takashi Yano wrote:
> > On Wed, 12 Mar 2025 12:16:12 +0100
> > Corinna Vinschen wrote:
> > > Hi Takashi,
> > > 
> > > On Mar 12 12:27, Takashi Yano wrote:
> > > > The previous implementation of the signal queue behaves as:
> > > > 1) Signals in the queue are processed in a disordered manner.
> > > > 2) If the same signal is already in the queue, new signal is discarded.
> > > > 
> > > > Strictly speaking, these behaviours do not violate POSIX. However,
> > > > these could be a cause of unexpected behaviour in some software. In
> > > > Linux, some important signals such as SIGSTOP/SIGCONT do not seem to
> > > > behave like that.
> > > > This patch prevents SIGKILL, SIGSTOP, SIGCONT, and SIGRT* from that
> > > > issue. Moreover, if SA_SIGINFO is set in sa_flags, the signal is
> > > > treated almost as the same.
> > > > 
> > > > Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257582.html
> > > > Fixes: 7ac6173643b1 ("(pending_signals): New class.")
> > > > Reported by: Christian Franke <Christian.Franke@t-online.de>
> > > > Reviewed-by: Corinna Vinschen <corinna@vinschen.de>, Christian Franke <Christian.Franke@t-online.de>
> > > > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > > > ---
> > > >  winsup/cygwin/sigproc.cc | 128 ++++++++++++++++++++++++++++++++-------
> > > >  1 file changed, 106 insertions(+), 22 deletions(-)
> > > > 
> > > > diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> > > > index 8739f18f5..ab3acfd24 100644
> > > > --- a/winsup/cygwin/sigproc.cc
> > > > +++ b/winsup/cygwin/sigproc.cc
> > > > @@ -21,6 +21,7 @@ details. */
> > > >  #include "cygtls.h"
> > > >  #include "ntdll.h"
> > > >  #include "exception.h"
> > > > +#include <assert.h>
> > > >  
> > > >  /*
> > > >   * Convenience defines
> > > > @@ -28,6 +29,10 @@ details. */
> > > >  #define WSSC		  60000	// Wait for signal completion
> > > >  #define WPSP		  40000	// Wait for proc_subproc mutex
> > > >  
> > > > +#define PIPE_DEPTH _NSIG /* Historically, the pipe size is _NSIG packet */
> > > > +#define SIGQ_ROOM 4
> > > > +#define SIGQ_DEPTH (PIPE_DEPTH + SIGQ_ROOM)
> > > 
> > > I'm missing a comment here.  Why adding SIGQ_ROOM?
> > 
> > First, I thought signal queue length must be larger than pipe size
> > to send __SIGFLUSHFAST safely. However, on second thought, it is
> > not enough for some cases while it is not necessary for other cases.
> > [PATCH v3 4/6] Cygwin: signal: Do not send __SIGFLUSHFAST if the pipe/queue is full
> > ensure the safety for sending __SIGFLUSHFAST.
> > 
> > > Other than that, LGTM.
> > 
> > Thanks for reviewing.
> > I would be happy if you could review also [PATCH v3 2/6]-[PATCH v3 6/6].
> 
> I did, sorry.  They all LGTM, too.  I'm a bit put off by having to add
> two events and one mutex to accomplish a safe __SIGFLUSHFAST (rather
> hoping a single semaphore would do the trick), but I see how you use the
> objects and it makes sense to me.
> 
> > > In terms of the queue size, I wonder if we really have to restrict the
> > > queue to a small number of queued signals, 69 right now.  The pipe used
> > > for communication will take 64K, one allocation granularity slot, anyway.
> > > Linux, for instance, queues more than 60K signals.
> > > 
> > > So, wouldn't it make sense to raise the queu depth to some higher
> > > value and the pipe size so that it it's <= 64K?
> > > 
> > > While looking into your patch, it occured to me that we have a
> > > long-standing bug: We never changed __SIGQUEUE_MAX/SIGQUEUE_MAX in
> > > include/cygwin/limits.h when we started to support 64 signals (we only
> > > did that for 64 bit Cygwin).
> > > 
> > > We can't change that for existing binaries actually referring the
> > > SIGQUEUE_MAX macro, but we should change this, so that
> > > sysconf( _SC_SIGQUEUE_MAX) returns the right value, isn't it?
> > 
> > I don't understand what you are concious of. If we change the value
> > of SIGQUEUE_MAX, what happens in terms of the binary compatibility?
> 
> I don't think we get a problem in terms of binary compat.  Old apps
> get a too small value, but I'm not really sure this is a problem at
> all.  I was just stumbling over this and found that this should have
> been changed to 64 (or 65) already ages ago.

If the patch attached (v4 1/6), modified regarding SIGQUEUE_MAX,
is as you intend, I'll push the patch seriese. May I?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Fri__14_Mar_2025_12_56_18_+0900_AKbZPykmXMp=TW4d
Content-Type: text/plain;
 name="v4-0001-Cygwin-signal-Redesign-signal-queue-handling.patch"
Content-Disposition: attachment;
 filename="v4-0001-Cygwin-signal-Redesign-signal-queue-handling.patch"
Content-Transfer-Encoding: base64

RnJvbSA2YmMyMzRhNmNiNmIzNTA0MzFiYzc5Y2RmMzgyOWQwZjdhMmFjZmU1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogVGFrYXNoaSBZYW5vIDx0YWthc2hpLnlhbm9AbmlmdHkubmUu
anA+DQpEYXRlOiBGcmksIDcgTWFyIDIwMjUgMTc6MTU6MzggKzA5MDANClN1YmplY3Q6IFtQQVRD
SCB2NCAxLzZdIEN5Z3dpbjogc2lnbmFsOiBSZWRlc2lnbiBzaWduYWwgcXVldWUgaGFuZGxpbmcN
Cg0KVGhlIHByZXZpb3VzIGltcGxlbWVudGF0aW9uIG9mIHRoZSBzaWduYWwgcXVldWUgYmVoYXZl
cyBhczoNCjEpIFNpZ25hbHMgaW4gdGhlIHF1ZXVlIGFyZSBwcm9jZXNzZWQgaW4gYSBkaXNvcmRl
cmVkIG1hbm5lci4NCjIpIElmIHRoZSBzYW1lIHNpZ25hbCBpcyBhbHJlYWR5IGluIHRoZSBxdWV1
ZSwgbmV3IHNpZ25hbCBpcyBkaXNjYXJkZWQuDQoNClN0cmljdGx5IHNwZWFraW5nLCB0aGVzZSBi
ZWhhdmlvdXJzIGRvIG5vdCB2aW9sYXRlIFBPU0lYLiBIb3dldmVyLA0KdGhlc2UgY291bGQgYmUg
YSBjYXVzZSBvZiB1bmV4cGVjdGVkIGJlaGF2aW91ciBpbiBzb21lIHNvZnR3YXJlLiBJbg0KTGlu
dXgsIHNvbWUgaW1wb3J0YW50IHNpZ25hbHMgc3VjaCBhcyBTSUdTVE9QL1NJR0NPTlQgZG8gbm90
IHNlZW0gdG8NCmJlaGF2ZSBsaWtlIHRoYXQuDQpUaGlzIHBhdGNoIHByZXZlbnRzIFNJR0tJTEws
IFNJR1NUT1AsIFNJR0NPTlQsIGFuZCBTSUdSVCogZnJvbSB0aGF0DQppc3N1ZS4gTW9yZW92ZXIs
IGlmIFNBX1NJR0lORk8gaXMgc2V0IGluIHNhX2ZsYWdzLCB0aGUgc2lnbmFsIGlzDQp0cmVhdGVk
IGFsbW9zdCBhcyB0aGUgc2FtZS4NCg0KQWRkcmVzc2VzOiBodHRwczovL2N5Z3dpbi5jb20vcGlw
ZXJtYWlsL2N5Z3dpbi8yMDI1LU1hcmNoLzI1NzU4Mi5odG1sDQpGaXhlczogN2FjNjE3MzY0M2Ix
ICgiKHBlbmRpbmdfc2lnbmFscyk6IE5ldyBjbGFzcy4iKQ0KUmVwb3J0ZWQgYnk6IENocmlzdGlh
biBGcmFua2UgPENocmlzdGlhbi5GcmFua2VAdC1vbmxpbmUuZGU+DQpSZXZpZXdlZC1ieTogQ29y
aW5uYSBWaW5zY2hlbiA8Y29yaW5uYUB2aW5zY2hlbi5kZT4sIENocmlzdGlhbiBGcmFua2UgPENo
cmlzdGlhbi5GcmFua2VAdC1vbmxpbmUuZGU+DQpTaWduZWQtb2ZmLWJ5OiBUYWthc2hpIFlhbm8g
PHRha2FzaGkueWFub0BuaWZ0eS5uZS5qcD4NCi0tLQ0KIHdpbnN1cC9jeWd3aW4vaW5jbHVkZS9j
eWd3aW4vbGltaXRzLmggfCAgIDIgKy0NCiB3aW5zdXAvY3lnd2luL3NpZ3Byb2MuY2MgICAgICAg
ICAgICAgIHwgMTI2ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tDQogMiBmaWxlcyBjaGFuZ2Vk
LCAxMDUgaW5zZXJ0aW9ucygrKSwgMjMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS93aW5z
dXAvY3lnd2luL2luY2x1ZGUvY3lnd2luL2xpbWl0cy5oIGIvd2luc3VwL2N5Z3dpbi9pbmNsdWRl
L2N5Z3dpbi9saW1pdHMuaA0KaW5kZXggZWEzZTI4MzZhLi4yMDQxNTRkYTkgMTAwNjQ0DQotLS0g
YS93aW5zdXAvY3lnd2luL2luY2x1ZGUvY3lnd2luL2xpbWl0cy5oDQorKysgYi93aW5zdXAvY3ln
d2luL2luY2x1ZGUvY3lnd2luL2xpbWl0cy5oDQpAQCAtNDEsNyArNDEsNyBAQCBkZXRhaWxzLiAq
Lw0KIA0KICNkZWZpbmUgX19SVFNJR19NQVggMzMNCiAjZGVmaW5lIF9fU0VNX1ZBTFVFX01BWCAx
MTQ3NDgzNjQ4DQotI2RlZmluZSBfX1NJR1FVRVVFX01BWCAzMg0KKyNkZWZpbmUgX19TSUdRVUVV
RV9NQVggMTAyNA0KICNkZWZpbmUgX19TVFJFQU1fTUFYIDIwDQogI2RlZmluZSBfX1NZTUxPT1Bf
TUFYIDEwDQogI2RlZmluZSBfX1RJTUVSX01BWCAzMg0KZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3
aW4vc2lncHJvYy5jYyBiL3dpbnN1cC9jeWd3aW4vc2lncHJvYy5jYw0KaW5kZXggODczOWYxOGY1
Li5jZjVmY2JjYTAgMTAwNjQ0DQotLS0gYS93aW5zdXAvY3lnd2luL3NpZ3Byb2MuY2MNCisrKyBi
L3dpbnN1cC9jeWd3aW4vc2lncHJvYy5jYw0KQEAgLTIxLDYgKzIxLDcgQEAgZGV0YWlscy4gKi8N
CiAjaW5jbHVkZSAiY3lndGxzLmgiDQogI2luY2x1ZGUgIm50ZGxsLmgiDQogI2luY2x1ZGUgImV4
Y2VwdGlvbi5oIg0KKyNpbmNsdWRlIDxhc3NlcnQuaD4NCiANCiAvKg0KICAqIENvbnZlbmllbmNl
IGRlZmluZXMNCkBAIC0yOCw2ICsyOSw4IEBAIGRldGFpbHMuICovDQogI2RlZmluZSBXU1NDCQkg
IDYwMDAwCS8vIFdhaXQgZm9yIHNpZ25hbCBjb21wbGV0aW9uDQogI2RlZmluZSBXUFNQCQkgIDQw
MDAwCS8vIFdhaXQgZm9yIHByb2Nfc3VicHJvYyBtdXRleA0KIA0KKyNkZWZpbmUgUElQRV9ERVBU
SCAoKERXT1JEKSA2NTUzNiAvIHNpemVvZiAoc2lncGFja2V0KSkNCisNCiAvKg0KICAqIEdsb2Jh
bCB2YXJpYWJsZXMNCiAgKi8NCkBAIC0xMDQsMTUgKzEwNywxNiBAQCBzdGF0aWMgdm9pZCB3YWl0
X3NpZyAoVk9JRCAqYXJnKTsNCiANCiBjbGFzcyBwZW5kaW5nX3NpZ25hbHMNCiB7DQotICBzaWdw
YWNrZXQgc2lnc1tfTlNJRyArIDFdOw0KKyAgc2lncGFja2V0IHNpZ3NbU0lHUVVFVUVfTUFYXTsN
CiAgIHNpZ3BhY2tldCBzdGFydDsNCisgIGludCBxdWV1ZV9sZWZ0Ow0KICAgU1JXTE9DSyBxdWV1
ZV9sb2NrOw0KICAgYm9vbCByZXRyeTsNCiAgIHZvaWQgbG9jayAoKSB7IEFjcXVpcmVTUldMb2Nr
RXhjbHVzaXZlICgmcXVldWVfbG9jayk7IH0NCiAgIHZvaWQgdW5sb2NrICgpIHsgUmVsZWFzZVNS
V0xvY2tFeGNsdXNpdmUgKCZxdWV1ZV9sb2NrKTsgfQ0KIA0KIHB1YmxpYzoNCi0gIHBlbmRpbmdf
c2lnbmFscyAoKTogcXVldWVfbG9jayAoU1JXTE9DS19JTklUKSB7fQ0KKyAgcGVuZGluZ19zaWdu
YWxzICgpOiBxdWV1ZV9sZWZ0IChTSUdRVUVVRV9NQVgpLCBxdWV1ZV9sb2NrIChTUldMT0NLX0lO
SVQpIHt9DQogICB2b2lkIGFkZCAoc2lncGFja2V0Jik7DQogICBib29sIHBlbmRpbmcgKCkge3Jl
dHJ5ID0gISFzdGFydC5uZXh0OyByZXR1cm4gcmV0cnk7fQ0KICAgdm9pZCBjbGVhciAoaW50IHNp
ZywgYm9vbCBuZWVkX2xvY2spOw0KQEAgLTQ0MSwxNSArNDQ1LDIyIEBAIHNpZ19jbGVhciAoaW50
IHNpZywgYm9vbCBuZWVkX2xvY2spDQogdm9pZA0KIHBlbmRpbmdfc2lnbmFsczo6Y2xlYXIgKGlu
dCBzaWcsIGJvb2wgbmVlZF9sb2NrKQ0KIHsNCi0gIHNpZ3BhY2tldCAqcSA9IHNpZ3MgKyBzaWc7
DQotICBpZiAoIXNpZyB8fCAhcS0+c2kuc2lfc2lnbm8pDQorICBzaWdwYWNrZXQgKnEgPSAmc3Rh
cnQ7DQorDQorICBpZiAoIXNpZykNCiAgICAgcmV0dXJuOw0KKw0KICAgaWYgKG5lZWRfbG9jaykN
CiAgICAgbG9jayAoKTsNCi0gIHEtPnNpLnNpX3NpZ25vID0gMDsNCi0gIHEtPnByZXYtPm5leHQg
PSBxLT5uZXh0Ow0KLSAgaWYgKHEtPm5leHQpDQotICAgIHEtPm5leHQtPnByZXYgPSBxLT5wcmV2
Ow0KKyAgd2hpbGUgKChxID0gcS0+bmV4dCkpDQorICAgIGlmIChxLT5zaS5zaV9zaWdubyA9PSBz
aWcpDQorICAgICAgew0KKwlxLT5zaS5zaV9zaWdubyA9IDA7DQorCXEtPnByZXYtPm5leHQgPSBx
LT5uZXh0Ow0KKwlpZiAocS0+bmV4dCkNCisJICBxLT5uZXh0LT5wcmV2ID0gcS0+cHJldjsNCisJ
cXVldWVfbGVmdCsrOw0KKyAgICAgIH0NCiAgIGlmIChuZWVkX2xvY2spDQogICAgIHVubG9jayAo
KTsNCiB9DQpAQCAtNDY5LDYgKzQ4MCw3IEBAIHBlbmRpbmdfc2lnbmFsczo6Y2xlYXIgKF9jeWd0
bHMgKnRscykNCiAJcS0+cHJldi0+bmV4dCA9IHEtPm5leHQ7DQogCWlmIChxLT5uZXh0KQ0KIAkg
IHEtPm5leHQtPnByZXYgPSBxLT5wcmV2Ow0KKwlxdWV1ZV9sZWZ0Kys7DQogICAgICAgfQ0KICAg
dW5sb2NrICgpOw0KIH0NCkBAIC01MDksNyArNTIxLDcgQEAgc2lncHJvY19pbml0ICgpDQogICBj
aGFyIGNoYXJfc2FfYnVmWzEwMjRdOw0KICAgUFNFQ1VSSVRZX0FUVFJJQlVURVMgc2EgPSBzZWNf
dXNlcl9uaWggKChQU0VDVVJJVFlfQVRUUklCVVRFUykgY2hhcl9zYV9idWYsIGN5Z2hlYXAtPnVz
ZXIuc2lkKCkpOw0KICAgRFdPUkQgZXJyID0gZmhhbmRsZXJfcGlwZTo6Y3JlYXRlIChzYSwgJm15
X3JlYWRzaWcsICZteV9zZW5kc2lnLA0KLQkJCQkgICAgIF9OU0lHICogc2l6ZW9mIChzaWdwYWNr
ZXQpLCAic2lnd2FpdCIsDQorCQkJCSAgICAgUElQRV9ERVBUSCAqIHNpemVvZiAoc2lncGFja2V0
KSwgInNpZ3dhaXQiLA0KIAkJCQkgICAgIFBJUEVfQUREX1BJRCk7DQogICBpZiAoZXJyKQ0KICAg
ICB7DQpAQCAtMTMxMSwyMyArMTMyMyw4NSBAQCB0YWxrdG9tZSAoc2lnaW5mb190ICpzaSkNCiAg
ICAgbmV3IGN5Z3RocmVhZCAoY29tbXVuZV9wcm9jZXNzLCBzaXplLCBzaSwgImNvbW11bmUiKTsN
CiB9DQogDQotLyogQWRkIGEgcGFja2V0IHRvIHRoZSBiZWdpbm5pbmcgb2YgdGhlIHF1ZXVlLg0K
K3N0YXRpYyBpbmxpbmUgYm9vbA0KK2lzX3NpZ3N5cyAoaW50IHNpZykNCit7DQorICByZXR1cm4g
c2lnID09IFNJR0tJTEwgfHwgc2lnID09IFNJR1NUT1AgfHwgc2lnID09IFNJR0NPTlQ7DQorfQ0K
Kw0KK3N0YXRpYyBpbmxpbmUgYm9vbA0KK2lzX3NpZ3J0IChpbnQgc2lnKQ0KK3sNCisgIHJldHVy
biBzaWcgPj0gU0lHUlRNSU4gJiYgc2lnIDw9IFNJR1JUTUFYOw0KK30NCisNCitzdGF0aWMgaW5s
aW5lIGJvb2wNCitpc19zaWdzeXNydCAoaW50IHNpZykNCit7DQorICByZXR1cm4gaXNfc2lnc3lz
IChzaWcpIHx8IGlzX3NpZ3J0IChzaWcpOw0KK30NCisNCisvKiBBZGQgYSBwYWNrZXQgdG8gdGhl
IGVuZCBvZiB0aGUgcXVldWUgdG8gcHJvY2VzcyBzaWduYWxzDQorICAgaW4gdGhlIG9yZGVyIHRo
ZXkgYXJlIGlzc3VlZCBleGNlcHQgZm9yIFNJR1JUKi4NCiAgICBTaG91bGQgb25seSBiZSBjYWxs
ZWQgZnJvbSBzaWduYWwgdGhyZWFkLiAgKi8NCiB2b2lkDQogcGVuZGluZ19zaWduYWxzOjphZGQg
KHNpZ3BhY2tldCYgcGFjaykNCiB7DQotICBzaWdwYWNrZXQgKnNlOw0KKyAgc2lncGFja2V0ICpz
ZSA9IE5VTEwsICpxID0gJnN0YXJ0Ow0KKyAgYm9vbCBxdWV1ZV9vbmNlID0gIWlzX3NpZ3N5c3J0
IChwYWNrLnNpLnNpX3NpZ25vKQ0KKyAgICAmJiAhKGdsb2JhbF9zaWdzW3BhY2suc2kuc2lfc2ln
bm9dLnNhX2ZsYWdzICYgU0FfU0lHSU5GTyk7DQogDQotICBzZSA9IHNpZ3MgKyBwYWNrLnNpLnNp
X3NpZ25vOw0KLSAgaWYgKHNlLT5zaS5zaV9zaWdubykNCi0gICAgcmV0dXJuOw0KLSAgKnNlID0g
cGFjazsNCiAgIGxvY2sgKCk7DQotICBzZS0+bmV4dCA9IHN0YXJ0Lm5leHQ7DQotICBzZS0+cHJl
diA9ICZzdGFydDsNCi0gIHNlLT5wcmV2LT5uZXh0ID0gc2U7DQotICBpZiAoc2UtPm5leHQpDQot
ICAgIHNlLT5uZXh0LT5wcmV2ID0gc2U7DQorICBpZiAocGFjay5zaS5zaV9zaWdubyAhPSBTSUdL
SUxMKQ0KKyAgICB3aGlsZSAocS0+bmV4dCkNCisgICAgICB7DQorCS8qIExpbnV4IG1hbiBzaWdu
YWwoNykgc2F5czoNCisJICAgIklmIGRpZmZlcmVudCByZWFsLXRpbWUgc2lnbmFscyBhcmUgc2Vu
dCB0byBhIHByb2Nlc3MsIHRoZXkgYXJlDQorCSAgIGRlbGl2ZXJlZCBzdGFydGluZyB3aXRoIHRo
ZSBsb3dlc3QtbnVtYmVyZWQgc2lnbmFsLiIgKi8NCisJaWYgKGlzX3NpZ3J0IChxLT5uZXh0LT5z
aS5zaV9zaWdubykgJiYgaXNfc2lncnQgKHBhY2suc2kuc2lfc2lnbm8pDQorCSAgICAmJiBxLT5u
ZXh0LT5zaS5zaV9zaWdubyA+IHBhY2suc2kuc2lfc2lnbm8pDQorCSAgYnJlYWs7DQorCS8qIExp
bnV4IG1hbiBzaWduYWwoNykgc2F5czoNCisJICAgIklmIGJvdGggc3RhbmRhcmQgYW5kIHJlYWwt
dGltZSBzaWduYWxzIGFyZSBwZW5kaW5nIGZvciBhIHByb2Nlc3MsDQorCSAgIFBPU0lYIGxlYXZl
cyBpdCB1bnNwZWNpZmllZCB3aGljaCBpcyBkZWxpdmVyZWQgZmlyc3QuICBMaW51eCwgbGlrZQ0K
KwkgICBtYW55IG90aGVyIGltcGxlbWVudGF0aW9ucywgZ2l2ZXMgcHJpb3JpdHkgdG8gc3RhbmRh
cmQgc2lnbmFscyBpbg0KKwkgICB0aGlzIGNhc2UuIiAqLw0KKwlpZiAoaXNfc2lncnQgKHEtPm5l
eHQtPnNpLnNpX3NpZ25vKSAmJiAhaXNfc2lncnQgKHBhY2suc2kuc2lfc2lnbm8pKQ0KKwkgIGJy
ZWFrOw0KKwlxID0gcS0+bmV4dDsNCisJLyogTGludXggbWFuIHNpZ25hbCg3KSBzYXlzOg0KKwkg
ICAiaWYgbXVsdGlwbGUgaW5zdGFuY2VzIG9mIGEgc3RhbmRhcmQgc2lnbmFsIGFyZSBkZWxpdmVy
ZWQgd2hpbGUNCisJICAgdGhhdCBzaWduYWwgaXMgY3VycmVudGx5IGJsb2NrZWQsIHRoZW4gb25s
eSBvbmUgaW5zdGFuY2UgaXMNCisJICAgcXVldWVkLiIgKi8NCisJLyogUE9TSVguMS0yMDA0IHNh
eXMgb24gc2lnYWN0aW9uKCk6DQorCSAgICJJZiBTQV9TSUdJTkZPIGlzIHNldCBpbiBzYV9mbGFn
cywgdGhlbiBzdWJzZXF1ZW50IG9jY3VycmVuY2VzDQorCSAgIG9mIHNpZyBnZW5lcmF0ZWQgYnkg
c2lncXVldWUoKSBvciBhcyBhIHJlc3VsdCBvZiBhbnkgc2lnbmFsLQ0KKwkgICBnZW5lcmF0aW5n
IGZ1bmN0aW9uIHRoYXQgc3VwcG9ydHMgdGhlIHNwZWNpZmljYXRpb24gb2YgYW4NCisJICAgYXBw
bGljYXRpb24tZGVmaW5lZCB2YWx1ZSAod2hlbiBzaWcgaXMgYWxyZWFkeSBwZW5kaW5nKSBzaGFs
bA0KKwkgICBiZSBxdWV1ZWQgaW4gRklGTyBvcmRlciB1bnRpbCBkZWxpdmVyZWQgb3IgYWNjZXB0
ZWQ7IiAqLw0KKwlpZiAocXVldWVfb25jZSAmJiBxLT5zaS5zaV9zaWdubyA9PSBwYWNrLnNpLnNp
X3NpZ25vKQ0KKwkgIHsNCisJICAgIHVubG9jayAoKTsNCisJICAgIHJldHVybjsNCisJICB9DQor
ICAgICAgfQ0KKw0KKyAgYXNzZXJ0IChxdWV1ZV9sZWZ0ID4gMCk7DQorICBmb3IgKGludCBpID0g
MDsgaSA8IFNJR1FVRVVFX01BWDsgaSsrKQ0KKyAgICBpZiAoc2lnc1tpXS5zaS5zaV9zaWdubyA9
PSAwKQ0KKyAgICAgIHsNCisJc2UgPSBzaWdzICsgaTsNCisJKnNlID0gcGFjazsNCisJYnJlYWs7
DQorICAgICAgfQ0KKyAgYXNzZXJ0IChzZSAhPSBOVUxMKTsNCisgIHF1ZXVlX2xlZnQtLTsNCisN
CisgIGlmIChxLT5uZXh0KQ0KKyAgICBxLT5uZXh0LT5wcmV2ID0gc2U7DQorICBzZS0+bmV4dCA9
IHEtPm5leHQ7DQorICBzZS0+cHJldiA9IHE7DQorICBxLT5uZXh0ID0gc2U7DQogICB1bmxvY2sg
KCk7DQogfQ0KIA0KQEAgLTEzNTQsMTIgKzE0MjgsMTIgQEAgd2FpdF9zaWcgKFZPSUQgKikNCiAg
ICAgew0KICAgICAgIERXT1JEIG5iOw0KICAgICAgIHNpZ3BhY2tldCBwYWNrID0ge307DQotICAg
ICAgaWYgKHNpZ3EucmV0cnkpDQorICAgICAgaWYgKHNpZ3EucmV0cnkgfHwgc2lncS5xdWV1ZV9s
ZWZ0ID09IDApDQogCXBhY2suc2kuc2lfc2lnbm8gPSBfX1NJR0ZMVVNIOw0KICAgICAgIGVsc2Ug
aWYgKHNpZ3Euc3RhcnQubmV4dA0KIAkgICAgICAgJiYgUGVla05hbWVkUGlwZSAobXlfcmVhZHNp
ZywgTlVMTCwgMCwgTlVMTCwgJm5iLCBOVUxMKSAmJiAhbmIpDQogCXsNCi0JICBTbGVlcCAoR2V0
VGlja0NvdW50ICgpIC0gdDAgPiAxMCA/IDEgOiAwKTsNCisJICBTbGVlcCAoKHNpZ19oZWxkIHx8
IEdldFRpY2tDb3VudCAoKSAtIHQwID4gMTApID8gMSA6IDApOw0KIAkgIHBhY2suc2kuc2lfc2ln
bm8gPSBfX1NJR0ZMVVNIOw0KIAl9DQogICAgICAgZWxzZSBpZiAoIVJlYWRGaWxlIChteV9yZWFk
c2lnLCAmcGFjaywgc2l6ZW9mIChwYWNrKSwgJm5iLCBOVUxMKSkNCkBAIC0xNTA1LDcgKzE1Nzks
MTUgQEAgd2FpdF9zaWcgKFZPSUQgKikNCiAJCSAgICAgIHEtPnByZXYtPm5leHQgPSBxLT5uZXh0
Ow0KIAkJICAgICAgaWYgKHEtPm5leHQpDQogCQkJcS0+bmV4dC0+cHJldiA9IHEtPnByZXY7DQor
CQkgICAgICBzaWdxLnF1ZXVlX2xlZnQrKzsNCiAJCSAgICB9DQorCQkgIGVsc2UgaWYgKGlzX3Np
Z3N5c3J0IChxLT5zaS5zaV9zaWdubykNCisJCSAgICAgICB8fCAoKGdsb2JhbF9zaWdzW3EtPnNp
LnNpX3NpZ25vXS5zYV9mbGFncyAmIFNBX1NJR0lORk8pDQorCQkJICAgJiYgTk9UU1RBVEUgKG15
c2VsZiwgUElEX1NUT1BQRUQpKSkNCisJCSAgICAvKiBTdG9wIHByb2Nlc3NpbmcgZnVydGhlciB0
byBwcmV2ZW50IHRoZSBzaWduYWxzIGZyb20NCisJCSAgICAgICBiZWluZyBwcm9jZXNzZWQgaW4g
YSBkaXNvcmRlcmQgbWFubmVyIGlmIHRoZSBzaWduYWwNCisJCSAgICAgICBpcyBhIHJlYWx0aW1l
IHNpZ25hbCBvciBTQV9TSUdJTkZPIGlzIHNldC4gKi8NCisJCSAgICBicmVhazsNCiAJCX0NCiAJ
ICAgICAgc2lncS51bmxvY2sgKCk7DQogCSAgICAgIC8qIEF0IGxlYXN0IG9uZSBzaWduYWwgc3Rp
bGwgcXVldWVkPyAgVGhlIGV2ZW50IGlzIHVzZWQgaW4gc2VsZWN0DQotLSANCjIuNDUuMQ0KDQo=

--Multipart=_Fri__14_Mar_2025_12_56_18_+0900_AKbZPykmXMp=TW4d--
