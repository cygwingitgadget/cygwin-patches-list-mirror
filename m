Return-Path: <SRS0=tMiW=KR=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w01.mail.nifty.com (mta-snd-w01.mail.nifty.com [106.153.227.33])
	by sourceware.org (Postfix) with ESMTPS id 853493858D20
	for <cygwin-patches@cygwin.com>; Mon, 11 Mar 2024 13:19:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 853493858D20
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 853493858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1710163144; cv=none;
	b=bFZezezgW5C7o+KwjE52dOb4l2vZYvFzXUhwxa6oxImgCdnRbTJnrF5UVR0IPyqegJ99Ql8Jv7UEvzDD+jXGw9KTJ3Ye7oD201zibjTJg0zTLywTpGLU1Y/t8o8RYnA3TBe+l6IJujtcvxVUFcuHwhIbSxDScikmAkWIQxZfi5c=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1710163144; c=relaxed/simple;
	bh=NYccITY2wqJP5EnhWHRNMpONT1P4y8gr3zkD1qh6InQ=;
	h=Date:From:To:Subject:Message-Id:Mime-Version; b=aijC5AziCQp2nptuCdT8/vCJ3JonJGx3lhXOIil9Se+ljv59cLwuKrDAPb5IkZFcQenXHV7ZW2A/pFiHKDZLaJUi5hIs47VeZehi6Uj/w5xrEe/gbvfe/DHMcmo42A8NczquzsyCIuPc1Ww/OVErVRcsU6I9u8QoAnR4v/CB9wg=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by dmta1001.nifty.com with ESMTP
          id <20240311131858082.TGJW.124194.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 11 Mar 2024 22:18:58 +0900
Date: Mon, 11 Mar 2024 22:18:57 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Restore non-blocking mode which was reset
 for non-cygwin app.
Message-Id: <20240311221857.7b5175cc76b5c4be7d81896b@nifty.ne.jp>
In-Reply-To: <20240311204237.bb2ffef477328542a63b148d@nifty.ne.jp>
References: <20240310103202.3753-1-takashi.yano@nifty.ne.jp>
	<Ze7hRBVYCClZg-Kq@calimero.vinschen.de>
	<20240311204237.bb2ffef477328542a63b148d@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Mon__11_Mar_2024_22_18_57_+0900__/UU9V=BR_isw9lo"
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.

--Multipart=_Mon__11_Mar_2024_22_18_57_+0900__/UU9V=BR_isw9lo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Mar 2024 20:42:37 +0900
Takashi Yano wrote:
> On Mon, 11 Mar 2024 11:47:32 +0100
> Corinna Vinschen wrote:
> > Hi Takashi,
> > 
> > On Mar 10 19:31, Takashi Yano wrote:
> > > @@ -590,6 +591,10 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
> > >  	      {
> > >  		fhandler_pipe *pipe = (fhandler_pipe *)(fhandler_base *) cfd;
> > >  		pipe->set_pipe_non_blocking (false);
> > > +		pipew_duped = (fhandler_pipe *)
> > > +			ccalloc (HEAP_FHANDLER, 1, sizeof (fhandler_pipe));
> > > +		pipew_duped = new (pipew_duped) fhandler_pipe;
> > > +		pipe->dup (pipew_duped, 0);
> > >  		if (pipe->request_close_query_hdl ())
> > >  		  need_send_sig = true;
> > >  	      }
> > 
> > The code setting up pipes and the dummy_tty is sufficiently complex,
> > so that I wonder if it shouldn't have
> > 
> > - its own methods and
> > - comments to describe why this stuff is necessary.
> > 
> > What about adding two methods, kind of like (the names are only
> > suggestion, albeit bad ones):
> > 
> >   child_info_spawn::noncygwin_child_pre_fork()
> > 
> > to keep the above stuff together (plus comments) and
> > 
> >   child_info_spawn::noncygwin_child_post_fork()
> > 
> > for the below code?
> > 
> > > @@ -597,6 +602,10 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
> > >  	      {
> > >  		fhandler_pipe *pipe = (fhandler_pipe *)(fhandler_base *) cfd;
> > >  		pipe->set_pipe_non_blocking (false);
> > > +		piper_duped = (fhandler_pipe *)
> > > +			ccalloc (HEAP_FHANDLER, 1, sizeof (fhandler_pipe));
> > > +		piper_duped = new (piper_duped) fhandler_pipe;
> > > +		pipe->dup (piper_duped, 0);
> > >  	      }
> > >  
> > >  	  if (need_send_sig)
> > > @@ -905,6 +914,19 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
> > >  	      term_spawn_worker.cleanup ();
> > >  	      term_spawn_worker.close_handle_set ();
> > >  	    }
> > > +	  if (pipew_duped)
> > > +	    {
> > > +	      bool is_nonblocking = pipew_duped->is_nonblocking ();
> > > +	      pipew_duped->set_pipe_non_blocking (is_nonblocking);
> > 
> > Is that really right?  You're asking pipew_duped for its
> > nonblocking flag and then set pipew_duped to the same value...?
> > 
> > > +	      pipew_duped->close ();
> > > +	      cfree (pipew_duped);
> > > +	    }
> 
> Thanks for the reviewing and advice. I'll work for v2 patch. Please wait a while.

I have reconsider what is essential. Then, just setting read pipe to non-blocking
mode for cygwin apps is enough when it starts.

Please review v2 patch attached.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Mon__11_Mar_2024_22_18_57_+0900__/UU9V=BR_isw9lo
Content-Type: text/plain;
 name="v2-0001-Cygwin-pipe-Make-sure-to-set-read-pipe-non-blocki.patch"
Content-Disposition: attachment;
 filename="v2-0001-Cygwin-pipe-Make-sure-to-set-read-pipe-non-blocki.patch"
Content-Transfer-Encoding: base64

RnJvbSA0M2FiMmQ0NTZmM2VmOTFhMWNmODcxOGVlMTc4YWM5MWU0YjQxNjc5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogVGFrYXNoaSBZYW5vIDx0YWthc2hpLnlhbm9AbmlmdHkubmUu
anA+DQpEYXRlOiBNb24sIDExIE1hciAyMDI0IDIyOjA4OjAwICswOTAwDQpTdWJqZWN0OiBbUEFU
Q0ggdjJdIEN5Z3dpbjogcGlwZTogTWFrZSBzdXJlIHRvIHNldCByZWFkIHBpcGUgbm9uLWJsb2Nr
aW5nIGZvcg0KIGN5Z3dpbiBhcHBzLg0KDQpJZiBwaXBlIHJlYWRlciBpcyBhIG5vbi1jeWd3aW4g
YXBwIGZpcnN0LCBhbmQgY3lnd2luIHByb2Nlc3MgcmVhZHMNCnRoZSBzYW1lIHBpcGUgYWZ0ZXIg
dGhhdCwgdGhlIHBpcGUgaGFzIGJlZW4gc2V0IHRvIGJjbG9ja2luZyBtb2RlDQpmb3IgdGhlIGN5
Z3dpbiBhcHAuIEhvd2V2ZXIsIHRoZSBjb21taXQgOWU0ZDMwOGNkNTkyIGFzc3VtZXMgdGhlDQpw
aXBlIGZvciBjeWd3aW4gcHJvY2VzcyBhbHdheXMgaXMgbm9uLWJsb2NraW5nIG1vZGUuIFdpdGgg
dGhpcyBwYXRjaCwNCnRoZSBwaXBlIG1vZGUgaXMgcmVzZXQgdG8gbm9uLWJsb2NraW5nIHdoZW4g
Y3lnd2luIGFwcCBpcyBzdGFydGVkLg0KDQpBZGRyZXNzZXM6IGh0dHBzOi8vY3lnd2luLmNvbS9w
aXBlcm1haWwvY3lnd2luLzIwMjQtTWFyY2gvMjU1NjQ0Lmh0bWwNCkZpeGVzOiA5ZTRkMzA4Y2Q1
OTIgKCJDeWd3aW46IHBpcGU6IEFkb3B0IEZJTEVfU1lOQ0hST05PVVNfSU9fTk9OQUxFUlQgZmxh
ZyBmb3IgcmVhZCBwaXBlLiIpDQpSZXBvcnRlZC1ieTogd2ggPHdoOTY5MkBwcm90b25tYWlsLmNv
bT4NClJldmlld2VkLWJ5OiBDb3Jpbm5hIFZpbnNjaGVuIDxjb3Jpbm5hQHZpbnNjaGVuLmRlPg0K
U2lnbmVkLW9mZi1ieTogVGFrYXNoaSBZYW5vIDx0YWthc2hpLnlhbm9AbmlmdHkubmUuanA+DQot
LS0NCiB3aW5zdXAvY3lnd2luL2ZoYW5kbGVyL3BpcGUuY2MgICAgICAgICAgfCA1NCArKysrKysr
KysrKysrKysrKysrKysrKysrDQogd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9maGFuZGxl
ci5oIHwgIDIgKw0KIHdpbnN1cC9jeWd3aW4vc3Bhd24uY2MgICAgICAgICAgICAgICAgICB8IDM1
ICstLS0tLS0tLS0tLS0tLS0NCiAzIGZpbGVzIGNoYW5nZWQsIDU4IGluc2VydGlvbnMoKyksIDMz
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9maGFuZGxlci9waXBl
LmNjIGIvd2luc3VwL2N5Z3dpbi9maGFuZGxlci9waXBlLmNjDQppbmRleCAyOWQzYjQxZDkuLmIy
OTcyNmRjYiAxMDA2NDQNCi0tLSBhL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXIvcGlwZS5jYw0KKysr
IGIvd2luc3VwL2N5Z3dpbi9maGFuZGxlci9waXBlLmNjDQpAQCAtMTgsNiArMTgsNyBAQCBkZXRh
aWxzLiAqLw0KICNpbmNsdWRlICJwaW5mby5oIg0KICNpbmNsdWRlICJzaGFyZWRfaW5mby5oIg0K
ICNpbmNsdWRlICJ0bHNfcGJ1Zi5oIg0KKyNpbmNsdWRlICJzaWdwcm9jLmgiDQogI2luY2x1ZGUg
PGFzc2VydC5oPg0KIA0KIC8qIFRoaXMgaXMgb25seSB0byBiZSB1c2VkIGZvciB3cml0aW5nLiAg
V2hlbiByZWFkaW5nLA0KQEAgLTEyODgsMyArMTI4OSw1NiBAQCBjbG9zZV9wcm9jOg0KICAgICB9
DQogICByZXR1cm4gTlVMTDsNCiB9DQorDQordm9pZA0KK2ZoYW5kbGVyX3BpcGU6OnNwYXduX3dv
cmtlciAoYm9vbCBpc2N5Z3dpbiwgaW50IGZpbGVub19zdGRpbiwNCisJCQkgICAgIGludCBmaWxl
bm9fc3Rkb3V0LCBpbnQgZmlsZW5vX3N0ZGVycikNCit7DQorICBib29sIG5lZWRfc2VuZF9ub25j
eWdjaGxkX3NpZyA9IGZhbHNlOw0KKw0KKyAgLyogU2V0IHJlYWQgcGlwZSBpdHNlbGYgYWx3YXlz
IG5vbi1ibG9ja2luZyBmb3IgY3lnd2luIHByb2Nlc3MuIGJsb2NraW5nLw0KKyAgICAgbm9uLWJs
b2NraW5nIGlzIHNpbXVsYXRlZCBpbiB0aGUgcmF3X3JlYWQoKS4gQXMgZm9yIHdyaXRlIHBpcGUs
IGZvbGxvdw0KKyAgICAgdGhlIGlzX25vbmJsb2NraW5nKCkuICovDQorICBpbnQgZmQ7DQorICBj
eWdoZWFwX2ZkZW51bSBjZmQgKGZhbHNlKTsNCisgIHdoaWxlICgoZmQgPSBjZmQubmV4dCAoKSkg
Pj0gMCkNCisgICAgaWYgKGNmZC0+Z2V0X2RldiAoKSA9PSBGSF9QSVBFVw0KKwkmJiAoZmQgPT0g
ZmlsZW5vX3N0ZG91dCB8fCBmZCA9PSBmaWxlbm9fc3RkZXJyKSkNCisgICAgICB7DQorCWZoYW5k
bGVyX3BpcGUgKnBpcGUgPSAoZmhhbmRsZXJfcGlwZSAqKShmaGFuZGxlcl9iYXNlICopIGNmZDsN
CisJYm9vbCBtb2RlID0gaXNjeWd3aW4gPyBwaXBlLT5pc19ub25ibG9ja2luZyAoKSA6IGZhbHNl
Ow0KKwlwaXBlLT5zZXRfcGlwZV9ub25fYmxvY2tpbmcgKG1vZGUpOw0KKw0KKwkvKiBTZXR1cCBm
b3IgcXVlcnlfbmRsIHN0dWZmLiBSZWFkIHRoZSBjb21tZW50IGJlbG93LiAqLw0KKwlpZiAoIWlz
Y3lnd2luICYmIHBpcGUtPnJlcXVlc3RfY2xvc2VfcXVlcnlfaGRsICgpKQ0KKwkgIG5lZWRfc2Vu
ZF9ub25jeWdjaGxkX3NpZyA9IHRydWU7DQorICAgICAgfQ0KKyAgICBlbHNlIGlmIChjZmQtPmdl
dF9kZXYgKCkgPT0gRkhfUElQRVIgJiYgZmQgPT0gZmlsZW5vX3N0ZGluKQ0KKyAgICAgIHsNCisJ
ZmhhbmRsZXJfcGlwZSAqcGlwZSA9IChmaGFuZGxlcl9waXBlICopKGZoYW5kbGVyX2Jhc2UgKikg
Y2ZkOw0KKwlwaXBlLT5zZXRfcGlwZV9ub25fYmxvY2tpbmcgKGlzY3lnd2luKTsNCisgICAgICB9
DQorDQorICAvKiBJZiBtdWx0aXBsZSB3cml0ZXJzIGluY2x1ZGluZyBub24tY3lnd2luIGFwcCBl
eGlzdCwgdGhlIG5vbi1jeWd3aW4NCisgICAgIGFwcCBjYW5ub3QgZGV0ZWN0IHBpcGUgY2xvc3Vy
ZSBvbiB0aGUgcmVhZCBzaWRlIHdoZW4gdGhlIHBpcGUgaXMNCisgICAgIGNyZWF0ZWQgYnkgc3lz
dGVtIGFjY291bnQgb3IgdGhlIHRoZSBwaXBlIGNyZWF0b3IgaXMgcnVubmluZyBhcw0KKyAgICAg
c2VydmljZS4gIFRoaXMgaXMgYmVjYXVzZSBxdWVyeV9oZGwgd2hpY2ggaXMgaGVsZCBpbiB3cml0
ZSBzaWRlDQorICAgICBhbHNvIGlzIGEgcmVhZCBlbmQgb2YgdGhlIHBpcGUsIHNvIHRoZSBwaXBl
IGlzIHN0aWxsIGFsaXZlIGZvcg0KKyAgICAgdGhlIG5vbi1jeWd3aW4gYXBwIGV2ZW4gYWZ0ZXIg
dGhlIHJlYWRlciBpcyBjbG9zZWQuDQorDQorICAgICBUbyBhdm9pZCB0aGlzIHByb2JsZW0sIGxl
dCBhbGwgcHJvY2Vzc2VzIGluIHRoZSBzYW1lIHByb2Nlc3MNCisgICAgIGdyb3VwIGNsb3NlIHF1
ZXJ5X2hkbCB1c2luZyBpbnRlcm5hbCBzaWduYWwgX19TSUdOT05DWUdDSExEIHdoZW4NCisgICAg
IG5vbi1jeWd3aW4gYXBwIGlzIHN0YXJ0ZWQuICAqLw0KKyAgaWYgKG5lZWRfc2VuZF9ub25jeWdj
aGxkX3NpZykNCisgICAgew0KKyAgICAgIHR0eV9taW4gZHVtbXlfdHR5Ow0KKyAgICAgIGR1bW15
X3R0eS5udHR5ID0gKGZoX2RldmljZXMpIG15c2VsZi0+Y3R0eTsNCisgICAgICBkdW1teV90dHku
cGdpZCA9IG15c2VsZi0+cGdpZDsNCisgICAgICB0dHlfbWluICp0ID0gY3lnd2luX3NoYXJlZC0+
dHR5LmdldF9jdHR5cCAoKTsNCisgICAgICBpZiAoIXQpIC8qIElmIHR0eSBpcyBub3QgYWxsb2Nh
dGVkLCB1c2UgZHVtbXlfdHR5IGluc3RlYWQuICovDQorCXQgPSAmZHVtbXlfdHR5Ow0KKyAgICAg
IC8qIEVtaXQgX19TSUdOT05DWUdDSExEIHRvIGxldCBhbGwgcHJvY2Vzc2VzIGluIHRoZQ0KKwkg
cHJvY2VzcyBncm91cCBjbG9zZSBxdWVyeV9oZGwuICovDQorICAgICAgdC0+a2lsbF9wZ3JwIChf
X1NJR05PTkNZR0NITEQpOw0KKyAgICB9DQorfQ0KZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4v
bG9jYWxfaW5jbHVkZXMvZmhhbmRsZXIuaCBiL3dpbnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMv
ZmhhbmRsZXIuaA0KaW5kZXggODcyOWViMjc2Li5kY2E0NzNlZmIgMTAwNjQ0DQotLS0gYS93aW5z
dXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL2ZoYW5kbGVyLmgNCisrKyBiL3dpbnN1cC9jeWd3aW4v
bG9jYWxfaW5jbHVkZXMvZmhhbmRsZXIuaA0KQEAgLTEyOTUsNiArMTI5NSw4IEBAIHB1YmxpYzoN
CiAJfQ0KICAgICAgIHJldHVybiBmYWxzZTsNCiAgICAgfQ0KKyAgc3RhdGljIHZvaWQgc3Bhd25f
d29ya2VyIChib29sIGlzY3lnd2luLCBpbnQgZmlsZW5vX3N0ZGluLA0KKwkJCSAgICBpbnQgZmls
ZW5vX3N0ZG91dCwgaW50IGZpbGVub19zdGRlcnIpOw0KIH07DQogDQogI2RlZmluZSBDWUdXSU5f
RklGT19QSVBFX05BTUVfTEVOICAgICA0Nw0KZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vc3Bh
d24uY2MgYi93aW5zdXAvY3lnd2luL3NwYXduLmNjDQppbmRleCA3MWQ3NWJiZjQuLjY0NzQ5YjU3
MiAxMDA2NDQNCi0tLSBhL3dpbnN1cC9jeWd3aW4vc3Bhd24uY2MNCisrKyBiL3dpbnN1cC9jeWd3
aW4vc3Bhd24uY2MNCkBAIC01NzksMzkgKzU3OSw4IEBAIGNoaWxkX2luZm9fc3Bhd246Ondvcmtl
ciAoY29uc3QgY2hhciAqcHJvZ19hcmcsIGNvbnN0IGNoYXIgKmNvbnN0ICphcmd2LA0KICAgICAg
IGludCBmaWxlbm9fc3Rkb3V0ID0gaW5fX3N0ZG91dCA8IDAgPyAxIDogaW5fX3N0ZG91dDsNCiAg
ICAgICBpbnQgZmlsZW5vX3N0ZGVyciA9IDI7DQogDQotICAgICAgaWYgKCFpc2N5Z3dpbiAoKSkN
Ci0Jew0KLQkgIGJvb2wgbmVlZF9zZW5kX3NpZyA9IGZhbHNlOw0KLQkgIGludCBmZDsNCi0JICBj
eWdoZWFwX2ZkZW51bSBjZmQgKGZhbHNlKTsNCi0JICB3aGlsZSAoKGZkID0gY2ZkLm5leHQgKCkp
ID49IDApDQotCSAgICBpZiAoY2ZkLT5nZXRfZGV2ICgpID09IEZIX1BJUEVXDQotCQkgICAgICYm
IChmZCA9PSBmaWxlbm9fc3Rkb3V0IHx8IGZkID09IGZpbGVub19zdGRlcnIpKQ0KLQkgICAgICB7
DQotCQlmaGFuZGxlcl9waXBlICpwaXBlID0gKGZoYW5kbGVyX3BpcGUgKikoZmhhbmRsZXJfYmFz
ZSAqKSBjZmQ7DQotCQlwaXBlLT5zZXRfcGlwZV9ub25fYmxvY2tpbmcgKGZhbHNlKTsNCi0JCWlm
IChwaXBlLT5yZXF1ZXN0X2Nsb3NlX3F1ZXJ5X2hkbCAoKSkNCi0JCSAgbmVlZF9zZW5kX3NpZyA9
IHRydWU7DQotCSAgICAgIH0NCi0JICAgIGVsc2UgaWYgKGNmZC0+Z2V0X2RldiAoKSA9PSBGSF9Q
SVBFUiAmJiBmZCA9PSBmaWxlbm9fc3RkaW4pDQotCSAgICAgIHsNCi0JCWZoYW5kbGVyX3BpcGUg
KnBpcGUgPSAoZmhhbmRsZXJfcGlwZSAqKShmaGFuZGxlcl9iYXNlICopIGNmZDsNCi0JCXBpcGUt
PnNldF9waXBlX25vbl9ibG9ja2luZyAoZmFsc2UpOw0KLQkgICAgICB9DQotDQotCSAgaWYgKG5l
ZWRfc2VuZF9zaWcpDQotCSAgICB7DQotCSAgICAgIHR0eV9taW4gZHVtbXlfdHR5Ow0KLQkgICAg
ICBkdW1teV90dHkubnR0eSA9IChmaF9kZXZpY2VzKSBteXNlbGYtPmN0dHk7DQotCSAgICAgIGR1
bW15X3R0eS5wZ2lkID0gbXlzZWxmLT5wZ2lkOw0KLQkgICAgICB0dHlfbWluICp0ID0gY3lnd2lu
X3NoYXJlZC0+dHR5LmdldF9jdHR5cCAoKTsNCi0JICAgICAgaWYgKCF0KSAvKiBJZiB0dHkgaXMg
bm90IGFsbG9jYXRlZCwgdXNlIGR1bW15X3R0eSBpbnN0ZWFkLiAqLw0KLQkJdCA9ICZkdW1teV90
dHk7DQotCSAgICAgIC8qIEVtaXQgX19TSUdOT05DWUdDSExEIHRvIGxldCBhbGwgcHJvY2Vzc2Vz
IGluIHRoZQ0KLQkJIHByb2Nlc3MgZ3JvdXAgY2xvc2UgcXVlcnlfaGRsLiAqLw0KLQkgICAgICB0
LT5raWxsX3BncnAgKF9fU0lHTk9OQ1lHQ0hMRCk7DQotCSAgICB9DQotCX0NCisgICAgICBmaGFu
ZGxlcl9waXBlOjpzcGF3bl93b3JrZXIgKGlzY3lnd2luICgpLCBmaWxlbm9fc3RkaW4sDQorCQkJ
CSAgIGZpbGVub19zdGRvdXQsIGZpbGVub19zdGRlcnIpOw0KIA0KICAgICAgIGJvb2wgbm9fcGNv
biA9IG1vZGUgIT0gX1BfT1ZFUkxBWSAmJiBtb2RlICE9IF9QX1dBSVQ7DQogICAgICAgdGVybV9z
cGF3bl93b3JrZXIuc2V0dXAgKGlzY3lnd2luICgpLCBoYW5kbGUgKGZpbGVub19zdGRpbiwgZmFs
c2UpLA0KLS0gDQoyLjQzLjANCg0K

--Multipart=_Mon__11_Mar_2024_22_18_57_+0900__/UU9V=BR_isw9lo--
