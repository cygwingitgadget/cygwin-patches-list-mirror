Return-Path: <SRS0=UdKb=V6=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e10.mail.nifty.com (mta-snd-e10.mail.nifty.com [106.153.226.42])
	by sourceware.org (Postfix) with ESMTPS id 10FA73858C5F
	for <cygwin-patches@cygwin.com>; Tue, 11 Mar 2025 11:50:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 10FA73858C5F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 10FA73858C5F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1741693809; cv=none;
	b=Rz3X8YxE1V0Sr4kudSsosV7HvzIKdutnw8zH4WUVPfz+GccdjMi+YEPlY3yJhh/BIhHaEB0isGAW968qKRkkWAjG/eAdlaoWGgN6IMWOkTJ/7d5vaIiHjp2U+csO0wiRPvi4/QXLMEbvEon/n6JRbZ0pzPZR+Y9Z0f5EBnKHv4s=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1741693809; c=relaxed/simple;
	bh=e/VinZx4rkYfAI8M07RMZpEpzK8s27AFoMY3oSKQ5xc=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=Ccdn8bqoY9yABAT16QqXBrzyoW1Hkv+1Zt3FqXtikVfwiUNX1pnIn3gCW2yhUTA904c/IhqcgqEO6aIYqp0nbd8ON4g3K3k1Vi8t1nRnlxPiS2DLgCFLZtcP2IKeFTCtITd+bRbLtWowvjmZebLD+whfOxLJAwNYtJNvl6k+/2g=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 10FA73858C5F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=daTWgbwH
Received: from HP-Z230 by mta-snd-e10.mail.nifty.com with ESMTP
          id <20250311115006778.UIKI.34837.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 11 Mar 2025 20:50:06 +0900
Date: Tue, 11 Mar 2025 20:50:05 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: signa: Redesign signal queue handling
Message-Id: <20250311205005.1e4aa4da870526b45ce97728@nifty.ne.jp>
In-Reply-To: <Z9AQaVQxMemHm4SH@calimero.vinschen.de>
References: <20250307121626.1365055-1-takashi.yano@nifty.ne.jp>
	<21db86b5-d9db-734b-7fea-922b18dab292@t-online.de>
	<Z89SULIpjgwSeQST@calimero.vinschen.de>
	<20250311175642.965ccd440c67ad956e1206b9@nifty.ne.jp>
	<Z9AQaVQxMemHm4SH@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__11_Mar_2025_20_50_05_+0900_j9+BK+2QBsHJYMZg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1741693806;
 bh=TpW3jGarnp0TSS9kRsSH5UaV5wWLKBIkq/AFEHBlQR0=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=daTWgbwHow4ykYlK51WHg2epeb+eMjJR3/m+P1H95E3QHSiR9IUPworrTFWGUMfuYMQ8OgXu
 6wOgqMqnDn7b3JhZ+BmIe1QoaPi2oz50pTgYkmoKPB0xmocW8c/O799kI/1+JpKBvQq5onIJW/
 gmEFht2kcYlUGgckUp6TDZSgBJmu1X2hc8k02X79OGBl4RaP0VcZvzwNMqyOf/Ocj/5s/k9E9+
 59/bozZpkyoGzIE8fb8VPv9PlxPr9yct4v21qpTtaZ3bzaPatPLHnGiqRqpmBBDXuxFAkNjXQt
 qK6JzrK4o0F81WPxccuh+Kpa4Awb3qFG+Skolt+kqJxXL+TA==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.

--Multipart=_Tue__11_Mar_2025_20_50_05_+0900_j9+BK+2QBsHJYMZg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Mar 2025 11:28:57 +0100
Corinna Vinschen wrote:
> On Mar 11 17:56, Takashi Yano wrote:
> > On Mon, 10 Mar 2025 21:57:52 +0100
> > Corinna Vinschen wrote:
> > > On Mar  9 13:28, Christian Franke wrote:
> > > > Takashi Yano wrote:
> > > > > ...
> > > > > With this patch prevents all signals from that issues by redesigning
> > > > > the signal queue, Only the exception is the case that the process is
> > > > > in the PID_STOPPED state. In this case, SIGCONT/SIGKILL should be
> > > > > processed prior to the other signals in the queue.
> > > > > 
> > > > > Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257582.html
> > > > > Fixes: 7ac6173643b1 ("(pending_signals): New class.")
> > > > > Reported by: Christian Franke <Christian.Franke@t-online.de>
> > > > > Reviewed-by:
> > > > > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > > > > ...
> > > > >   void
> > > > >   pending_signals::add (sigpacket& pack)
> > > > >   {
> > > > > ...
> > > > > +  if (q->si.si_signo == pack.si.si_signo)
> > > > > +    q->usecount++;
> > > > > ...
> > > > > 
> > > > 
> > > > This should possibly also compare the si.si_sigval fields. Otherwise values
> > > > would be lost if the same real-time signal is issued multiple times with
> > > > different value parameters.
> > > 
> > > Looks like this doesn't only affect RT signals.  I just read POSIX.1-2024
> > > on sigaction,
> > > https://pubs.opengroup.org/onlinepubs/9799919799/functions/sigaction.html
> > > and this is what it has to say in terms of queuing:
> > > 
> > >   If SA_SIGINFO is not set in sa_flags, then the disposition of
> > >   subsequent occurrences of sig when it is already pending is
> > >   implementation-defined; the signal-catching function shall be invoked
> > >   with a single argument. If SA_SIGINFO is set in sa_flags, then
> > >   subsequent occurrences of sig generated by sigqueue() or as a result
> > >   of any signal-generating function that supports the specification of
> > >   an application-defined value (when sig is already pending) shall be
> > >   queued in FIFO order until delivered or accepted;
> > > 
> > > This isn't quite what the Linux man pages describe.  Signal(7) says:
> > > 
> > >   Standard signals do not queue.  If multiple instances of a standard
> > >   signal are generated while that signal is blocked, then only one
> > >   instance of the signal is marked as pending (and the signal will be
> > >   delivered just once when it is unblocked).  In the case where a
> > >   standard signal is already pending, the siginfo_t structure (see
> > >   sigaction(2)) associated with that signal is not overwritten on
> > >   arrival of subsequent instances of the same signal.  Thus, the process
> > >   will receive the information associated with the first instance of the
> > >   signal.
> > > 
> > > Am I just confused or do these two description not match?
> > 
> > Yeah, I think Linux is not fully compliant with POSIX.
> > My v2 patch intends signal queue behaves like Linux when SA_SIGINFO
> > is not set. On the contrary, it behaves as POSIX states if SA_SIGINFO
> > is set.
> > 
> > Does this make sense?
> 
> Absolutely.
> 
> The word "implementation-defined" in the POSIX docs give you allowance
> to queue signales all the time, though.  Just something to keep in mind
> if that simplifies things.

OK.

BTW, I found another bug in signal handling.

The following testcase (that is the modified version of Christian's one)
hangs with my v2 signal queue patch. It seems that the signal handler
is called from inside of the signal handler, _cygtls::context seems
to be destroyed. To confirm this, I tested the patch attached.
The patch is not good enough yet, however, the test case works with
this patch.

Any idea?

#include <sched.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

static volatile sig_atomic_t sigcnt, term;

static void sighandler1(int sig, siginfo_t *si, void *p)
{
  (void)sig;
  ++sigcnt;
  write(1, "[ALRM]\n", 7);
}

static void sighandler2(int sig, siginfo_t *si, void *p)
{
  (void)sig;
  term = 1;
  write(1, "[TERM]\n", 7);
}

int main()
{
  pid_t pid = fork();
  if (pid == (pid_t)-1) {
    perror("fork"); return 1;
  }

  if (!pid) {
	struct sigaction sa1 = {0,};
	struct sigaction sa2 = {0,};
	sa1.sa_sigaction = sighandler1;
	sa2.sa_sigaction = sighandler2;
	sa1.sa_flags = SA_SIGINFO;
	sa2.sa_flags = SA_SIGINFO;
	sigaction(SIGALRM, &sa1, NULL);
	sigaction(SIGTERM, &sa2, NULL);

    while (!term)
      sched_yield();

    printf("%d: %d SIGALRM received, exit(42)\n", (int)getpid(), sigcnt);
    fflush(stdout);
    _exit(42);
  }

  printf("%d: fork()=%d\n", (int)getpid(), (int)pid);
  sleep(1);

  const int n = 10;
  printf("SIGALRM x %d\n", n); fflush(stdout);
  for (int i = 0; i < n; i++) {
    sched_yield();
    if (kill(pid, SIGALRM))
      perror("SIGALRM");
  }

  printf("SIGTERM\n"); fflush(stdout);
  if (kill(pid, SIGTERM))
      perror("SIGTERM");

  printf("waitpid()...\n"); fflush(stdout);
  int status = -1;
  int wp = waitpid(pid, &status, 0);
  printf("waidpid()=%d, status=0x%04x\n", wp, status);
  return 0;
}

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Tue__11_Mar_2025_20_50_05_+0900_j9+BK+2QBsHJYMZg
Content-Type: text/plain;
 name="context.patch"
Content-Disposition: attachment;
 filename="context.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vZXhjZXB0aW9ucy5jYyBiL3dpbnN1cC9jeWd3aW4v
ZXhjZXB0aW9ucy5jYw0KaW5kZXggMThhNTY2YzQ1Li5iZDQ0MjIyYjUgMTAwNjQ0DQotLS0gYS93
aW5zdXAvY3lnd2luL2V4Y2VwdGlvbnMuY2MNCisrKyBiL3dpbnN1cC9jeWd3aW4vZXhjZXB0aW9u
cy5jYw0KQEAgLTE2NzAsNiArMTY3MCw4IEBAIF9jeWd0bHM6OmNhbGxfc2lnbmFsX2hhbmRsZXIg
KCkNCiAJICBicmVhazsNCiAJfQ0KIA0KKyAgICAgIEludGVybG9ja2VkSW5jcmVtZW50KCZjdHhf
Y250KTsNCisNCiAgICAgICAvKiBQb3AgdGhlIHN0YWNrIGlmIHRoZSBuZXh0ICJyZXR1cm4gYWRk
cmVzcyIgaXMgc2lnZGVsYXllZCwgc2luY2UNCiAJIHRoaXMgZnVuY3Rpb24gaXMgZG9pbmcgd2hh
dCBzaWdkZWxheWVkIHdvdWxkIGhhdmUgZG9uZSBhbnl3YXkuICovDQogICAgICAgaWYgKHJldGFk
ZHIgKCkgPT0gKF9fdGxzc3RhY2tfdCkgc2lnZGVsYXllZCkNCkBAIC0xNjk3LDEwICsxNjk5LDEw
IEBAIF9jeWd0bHM6OmNhbGxfc2lnbmFsX2hhbmRsZXIgKCkNCiAgICAgICAvKiBPbmx5IG1ha2Ug
YSBjb250ZXh0IGZvciBTQV9TSUdJTkZPIGhhbmRsZXJzICovDQogICAgICAgaWYgKHRoaXNfc2Ff
ZmxhZ3MgJiBTQV9TSUdJTkZPKQ0KIAl7DQotCSAgY29udGV4dC51Y19saW5rID0gMDsNCi0JICBj
b250ZXh0LnVjX2ZsYWdzID0gMDsNCisJICBjb250ZXh0W2N0eF9jbnQgLSAxXS51Y19saW5rID0g
MDsNCisJICBjb250ZXh0W2N0eF9jbnQgLSAxXS51Y19mbGFncyA9IDA7DQogCSAgaWYgKHRoaXNz
aS5zaV9jeWcpDQotCSAgICBtZW1jcHkgKCZjb250ZXh0LnVjX21jb250ZXh0LA0KKwkgICAgbWVt
Y3B5ICgmY29udGV4dFtjdHhfY250IC0gMV0udWNfbWNvbnRleHQsDQogCQkgICAgKChjeWd3aW5f
ZXhjZXB0aW9uICopIHRoaXNzaS5zaV9jeWcpLT5jb250ZXh0ICgpLA0KIAkJICAgIHNpemVvZiAo
Q09OVEVYVCkpOw0KIAkgIGVsc2UNCkBAIC0xNzEwLDEzICsxNzEyLDEzIEBAIF9jeWd0bHM6OmNh
bGxfc2lnbmFsX2hhbmRsZXIgKCkNCiAJCSBmcm9tIHNpZ2RlbGF5ZWQsIGZpeCB0aGUgaW5zdHJ1
Y3Rpb24gcG9pbnRlciBhY2NvcmRpbmdseS4gKi8NCiAjcHJhZ21hIEdDQyBkaWFnbm9zdGljIHB1
c2gNCiAjcHJhZ21hIEdDQyBkaWFnbm9zdGljIGlnbm9yZWQgIi1XbWF5YmUtdW5pbml0aWFsaXpl
ZCINCi0JICAgICAgUnRsQ2FwdHVyZUNvbnRleHQgKChQQ09OVEVYVCkgJmNvbnRleHQudWNfbWNv
bnRleHQpOw0KKwkgICAgICBSdGxDYXB0dXJlQ29udGV4dCAoKFBDT05URVhUKSAmY29udGV4dFtj
dHhfY250IC0gMV0udWNfbWNvbnRleHQpOw0KICNwcmFnbWEgR0NDIGRpYWdub3N0aWMgcG9wDQot
CSAgICAgIF9fdW53aW5kX3NpbmdsZV9mcmFtZSAoKFBDT05URVhUKSAmY29udGV4dC51Y19tY29u
dGV4dCk7DQorCSAgICAgIF9fdW53aW5kX3NpbmdsZV9mcmFtZSAoKFBDT05URVhUKSAmY29udGV4
dFtjdHhfY250IC0gMV0udWNfbWNvbnRleHQpOw0KIAkgICAgICBpZiAoc3RhY2twdHIgPiBzdGFj
aykNCiAJCXsNCiAjaWZkZWYgX194ODZfNjRfXw0KLQkJICBjb250ZXh0LnVjX21jb250ZXh0LnJp
cCA9IHJldGFkZHIgKCk7DQorCQkgIGNvbnRleHRbY3R4X2NudCAtIDFdLnVjX21jb250ZXh0LnJp
cCA9IHJldGFkZHIgKCk7DQogI2Vsc2UNCiAjZXJyb3IgdW5pbXBsZW1lbnRlZCBmb3IgdGhpcyB0
YXJnZXQNCiAjZW5kaWYNCkBAIC0xNzI3LDMwICsxNzI5LDMwIEBAIF9jeWd0bHM6OmNhbGxfc2ln
bmFsX2hhbmRsZXIgKCkNCiAJICAgICAgJiYgIV9teV90bHMuYWx0c3RhY2suc3NfZmxhZ3MNCiAJ
ICAgICAgJiYgX215X3Rscy5hbHRzdGFjay5zc19zcCkNCiAJICAgIHsNCi0JICAgICAgY29udGV4
dC51Y19zdGFjayA9IF9teV90bHMuYWx0c3RhY2s7DQotCSAgICAgIGNvbnRleHQudWNfc3RhY2su
c3NfZmxhZ3MgPSBTU19PTlNUQUNLOw0KKwkgICAgICBjb250ZXh0W2N0eF9jbnQgLSAxXS51Y19z
dGFjayA9IF9teV90bHMuYWx0c3RhY2s7DQorCSAgICAgIGNvbnRleHRbY3R4X2NudCAtIDFdLnVj
X3N0YWNrLnNzX2ZsYWdzID0gU1NfT05TVEFDSzsNCiAJICAgIH0NCiAJICBlbHNlDQogCSAgICB7
DQotCSAgICAgIGNvbnRleHQudWNfc3RhY2suc3Nfc3AgPSBOdEN1cnJlbnRUZWIgKCktPlRpYi5T
dGFja0Jhc2U7DQotCSAgICAgIGNvbnRleHQudWNfc3RhY2suc3NfZmxhZ3MgPSAwOw0KKwkgICAg
ICBjb250ZXh0W2N0eF9jbnQgLSAxXS51Y19zdGFjay5zc19zcCA9IE50Q3VycmVudFRlYiAoKS0+
VGliLlN0YWNrQmFzZTsNCisJICAgICAgY29udGV4dFtjdHhfY250IC0gMV0udWNfc3RhY2suc3Nf
ZmxhZ3MgPSAwOw0KIAkgICAgICBpZiAoIU50Q3VycmVudFRlYiAoKS0+RGVhbGxvY2F0aW9uU3Rh
Y2spDQotCQljb250ZXh0LnVjX3N0YWNrLnNzX3NpemUNCisJCWNvbnRleHRbY3R4X2NudCAtIDFd
LnVjX3N0YWNrLnNzX3NpemUNCiAJCSAgPSAodWludHB0cl90KSBOdEN1cnJlbnRUZWIgKCktPlRp
Yi5TdGFja0xpbWl0DQogCQkgICAgLSAodWludHB0cl90KSBOdEN1cnJlbnRUZWIgKCktPlRpYi5T
dGFja0Jhc2U7DQogCSAgICAgIGVsc2UNCi0JCWNvbnRleHQudWNfc3RhY2suc3Nfc2l6ZQ0KKwkJ
Y29udGV4dFtjdHhfY250IC0gMV0udWNfc3RhY2suc3Nfc2l6ZQ0KIAkJICA9ICh1aW50cHRyX3Qp
IE50Q3VycmVudFRlYiAoKS0+RGVhbGxvY2F0aW9uU3RhY2sNCiAJCSAgICAtICh1aW50cHRyX3Qp
IE50Q3VycmVudFRlYiAoKS0+VGliLlN0YWNrQmFzZTsNCiAJICAgIH0NCi0JICBjb250ZXh0LnVj
X3NpZ21hc2sgPSBjb250ZXh0LnVjX21jb250ZXh0Lm9sZG1hc2sgPSB0aGlzX29sZG1hc2s7DQor
CSAgY29udGV4dFtjdHhfY250IC0gMV0udWNfc2lnbWFzayA9IGNvbnRleHRbY3R4X2NudCAtIDFd
LnVjX21jb250ZXh0Lm9sZG1hc2sgPSB0aGlzX29sZG1hc2s7DQogDQotCSAgY29udGV4dC51Y19t
Y29udGV4dC5jcjIgPSAodGhpc3NpLnNpX3NpZ25vID09IFNJR1NFR1YNCisJICBjb250ZXh0W2N0
eF9jbnQgLSAxXS51Y19tY29udGV4dC5jcjIgPSAodGhpc3NpLnNpX3NpZ25vID09IFNJR1NFR1YN
CiAJCQkJICAgICB8fCB0aGlzc2kuc2lfc2lnbm8gPT0gU0lHQlVTKQ0KIAkJCQkgICAgPyAodWlu
dHB0cl90KSB0aGlzc2kuc2lfYWRkciA6IDA7DQogDQotCSAgdGhpc2NvbnRleHQgPSAmY29udGV4
dDsNCi0JICBjb250ZXh0X2NvcHkgPSBjb250ZXh0Ow0KKwkgIHRoaXNjb250ZXh0ID0gJmNvbnRl
eHRbY3R4X2NudCAtIDFdOw0KKwkgIGNvbnRleHRfY29weSA9IGNvbnRleHRbY3R4X2NudCAtIDFd
Ow0KIAl9DQogDQogICAgICAgaW50IHRoaXNfZXJybm8gPSBzYXZlZF9lcnJubzsNCkBAIC0xODM2
LDkgKzE4MzgsMTEgQEAgX2N5Z3Rsczo6Y2FsbF9zaWduYWxfaGFuZGxlciAoKQ0KICAgICAgIGlu
Y3lnID0gdHJ1ZTsNCiANCiAgICAgICBzZXRfc2lnbmFsX21hc2sgKF9teV90bHMuc2lnbWFzaywg
KHRoaXNfc2FfZmxhZ3MgJiBTQV9TSUdJTkZPKQ0KLQkJCQkJPyBjb250ZXh0LnVjX3NpZ21hc2sg
OiB0aGlzX29sZG1hc2spOw0KKwkJCQkJPyBjb250ZXh0W2N0eF9jbnQgLSAxXS51Y19zaWdtYXNr
IDogdGhpc19vbGRtYXNrKTsNCiAgICAgICBpZiAodGhpc19lcnJubyA+PSAwKQ0KIAlzZXRfZXJy
bm8gKHRoaXNfZXJybm8pOw0KKw0KKyAgICAgIEludGVybG9ja2VkRGVjcmVtZW50KCZjdHhfY250
KTsNCiAgICAgfQ0KIA0KICAgLyogRklYTUU6IFNpbmNlIDIwMTEgdGhpcyByZXR1cm4gc3RhdGVt
ZW50IGFsd2F5cyByZXR1cm5lZCAxIChtZWFuaW5nDQpAQCAtMTg2MywxMiArMTg2NywxMiBAQCBf
Y3lndGxzOjpzaWduYWxfZGVidWdnZXIgKHNpZ2luZm9fdCYgc2kpDQogCXsNCiAJICBpZiAoaW5j
eWcpDQogCSAgICBjLl9DWF9pbnN0UHRyID0gcmV0YWRkciAoKTsNCi0JICBtZW1jcHkgKCZjb250
ZXh0LnVjX21jb250ZXh0LCAmYywgc2l6ZW9mIChDT05URVhUKSk7DQorCSAgbWVtY3B5ICgmY29u
dGV4dFtjdHhfY250XS51Y19tY29udGV4dCwgJmMsIHNpemVvZiAoQ09OVEVYVCkpOw0KIAkgIC8q
IEVub3VnaCBzcGFjZSBmb3IgNjQgYml0IGFkZHJlc3NlcyAqLw0KIAkgIGNoYXIgc2lnbXNnWzIg
KiBzaXplb2YgKF9DWUdXSU5fU0lHTkFMX1NUUklORw0KIAkJCQkgICIgZmZmZmZmZmYgZmZmZmZm
ZmZmZmZmZmZmZiIpXTsNCiAJICBfX3NtYWxsX3NwcmludGYgKHNpZ21zZywgX0NZR1dJTl9TSUdO
QUxfU1RSSU5HICIgJWQgJXkgJXAiLA0KLQkJCSAgIHNpLnNpX3NpZ25vLCB0aHJlYWRfaWQsICZj
b250ZXh0LnVjX21jb250ZXh0KTsNCisJCQkgICBzaS5zaV9zaWdubywgdGhyZWFkX2lkLCAmY29u
dGV4dFtjdHhfY250XS51Y19tY29udGV4dCk7DQogCSAgT3V0cHV0RGVidWdTdHJpbmcgKHNpZ21z
Zyk7DQogCX0NCiAgICAgICBSZXN1bWVUaHJlYWQgKHRoKTsNCmRpZmYgLS1naXQgYS93aW5zdXAv
Y3lnd2luL2xvY2FsX2luY2x1ZGVzL2N5Z3Rscy5oIGIvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNs
dWRlcy9jeWd0bHMuaA0KaW5kZXggZGZkMzE5ODQzLi40ZTI1MWZjYzkgMTAwNjQ0DQotLS0gYS93
aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL2N5Z3Rscy5oDQorKysgYi93aW5zdXAvY3lnd2lu
L2xvY2FsX2luY2x1ZGVzL2N5Z3Rscy5oDQpAQCAtMTg4LDcgKzE4OCw4IEBAIHB1YmxpYzogLyog
RG8gTk9UIHJlbW92ZSB0aGlzIHB1YmxpYzogbGluZSwgaXQncyBhIG1hcmtlciBmb3IgZ2VudGxz
X29mZnNldHMuICovDQogICAgICBJZiB5b3UgcHJlcGVuZCBjeWd0bHMgbWVtYmVycyBoZXJlLCBt
YWtlIHN1cmUgY29udGV4dCBzdGF5cyAxNiBieXRlDQogICAgICBhbGlnbmVkLiBUaGUgZ2VudGxz
X29mZnNldHMgc2NyaXB0IGNoZWNrcyBmb3IgdGhhdCBub3cgYW5kIGZhaWxzDQogICAgICBpZiB0
aGUgYWxpZ25tZW50IGlzIHdyb25nLiAqLw0KLSAgdWNvbnRleHRfdCBjb250ZXh0Ow0KKyAgdWNv
bnRleHRfdCBjb250ZXh0WzRdOw0KKyAgTE9ORyBjdHhfY250Ow0KICAgRFdPUkQgdGhyZWFkX2lk
Ow0KICAgc2lnaW5mb190IGluZm9kYXRhOw0KICAgc3RydWN0IHB0aHJlYWQgKnRpZDsNCg==

--Multipart=_Tue__11_Mar_2025_20_50_05_+0900_j9+BK+2QBsHJYMZg--
