Return-Path: <SRS0=tMiW=KR=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id C53023858D34
	for <cygwin-patches@cygwin.com>; Mon, 11 Mar 2024 23:03:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C53023858D34
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C53023858D34
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1710198204; cv=none;
	b=fIW/ccA+m5JF0/GNVV0WU+0u8GRYWL97YTkjP6x3vGYO+/tsvOq4sVG5ZlYGIlNHryu3Ymma9ScaAI3EzaNvt6qg2DpRGzEZI8822j5fBEH3T3hKHtu9TMx7WShpLC8oZHdjcGOfQpRAWOKBRmJYCp9C7BxUAHEoZZNf0w5ABRA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1710198204; c=relaxed/simple;
	bh=w9KGigwvrwzJJs/VJeS7itABasN7Hgw9NgWMMdw68D0=;
	h=Date:From:To:Subject:Message-Id:Mime-Version; b=nCw2iAmBKINmlWpHI7fr9eSWq57OvJGVIIgcIZihio+bCokesql3X2OeoYfFLLqx2js6VPt+YARMmLgPwGCmfrcVjCXKgTHLTy25SdQ/qTkb0Vf5uleC5VuWuwvIWHKzOrtVoEDoxS5B8hSoGclAYnC+anX7ArCxDLEUyJf9K+M=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by dmta0015.nifty.com with ESMTP
          id <20240311230317363.PQON.14278.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 12 Mar 2024 08:03:17 +0900
Date: Tue, 12 Mar 2024 08:03:16 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Restore non-blocking mode which was reset
 for non-cygwin app.
Message-Id: <20240312080316.51a75358db94bcfe5c8c2c13@nifty.ne.jp>
In-Reply-To: <Ze9qgPIptT3EasMm@calimero.vinschen.de>
References: <20240310103202.3753-1-takashi.yano@nifty.ne.jp>
	<Ze7hRBVYCClZg-Kq@calimero.vinschen.de>
	<20240311204237.bb2ffef477328542a63b148d@nifty.ne.jp>
	<20240311221857.7b5175cc76b5c4be7d81896b@nifty.ne.jp>
	<Ze9qgPIptT3EasMm@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__12_Mar_2024_08_03_16_+0900_iN/Few+OyLu+6var"
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.

--Multipart=_Tue__12_Mar_2024_08_03_16_+0900_iN/Few+OyLu+6var
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Mar 2024 21:33:04 +0100
Corinna Vinschen wrote:
> this looks much better.  Just one question and a few comment
> changes...
> 
> On Mar 11 22:18, Takashi Yano wrote:
> > Subject: [PATCH v2] Cygwin: pipe: Make sure to set read pipe non-blocking for
> >  cygwin apps.
> > 
> > If pipe reader is a non-cygwin app first, and cygwin process reads
> > the same pipe after that, the pipe has been set to bclocking mode
> > for the cygwin app. However, the commit 9e4d308cd592 assumes the
> > pipe for cygwin process always is non-blocking mode. With this patch,
> > the pipe mode is reset to non-blocking when cygwin app is started.
> > 
> > Addresses: https://cygwin.com/pipermail/cygwin/2024-March/255644.html
> > Fixes: 9e4d308cd592 ("Cygwin: pipe: Adopt FILE_SYNCHRONOUS_IO_NONALERT flag for read pipe.")
> > Reported-by: wh <wh9692@protonmail.com>
> > Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >  winsup/cygwin/fhandler/pipe.cc          | 54 +++++++++++++++++++++++++
> >  winsup/cygwin/local_includes/fhandler.h |  2 +
> >  winsup/cygwin/spawn.cc                  | 35 +---------------
> >  3 files changed, 58 insertions(+), 33 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
> > index 29d3b41d9..b29726dcb 100644
> > --- a/winsup/cygwin/fhandler/pipe.cc
> > +++ b/winsup/cygwin/fhandler/pipe.cc
> > @@ -18,6 +18,7 @@ details. */
> >  #include "pinfo.h"
> >  #include "shared_info.h"
> >  #include "tls_pbuf.h"
> > +#include "sigproc.h"
> >  #include <assert.h>
> >  
> >  /* This is only to be used for writing.  When reading,
> > @@ -1288,3 +1289,56 @@ close_proc:
> >      }
> >    return NULL;
> >  }
> > +
> > +void
> > +fhandler_pipe::spawn_worker (bool iscygwin, int fileno_stdin,
> > +			     int fileno_stdout, int fileno_stderr)
> > +{
> > +  bool need_send_noncygchld_sig = false;
> > +
> > +  /* Set read pipe itself always non-blocking for cygwin process. blocking/
> > +     non-blocking is simulated in the raw_read(). As for write pipe, follow
> > +     the is_nonblocking(). */
> 
> You can drop the articles here, i.e.
> 
>         ...non-blocking is simulated in raw_read().  For write pipe follow
> 	is_nonblocking().

Fixed.

> > +  int fd;
> > +  cygheap_fdenum cfd (false);
> > +  while ((fd = cfd.next ()) >= 0)
> > +    if (cfd->get_dev () == FH_PIPEW
> > +	&& (fd == fileno_stdout || fd == fileno_stderr))
> > +      {
> > +	fhandler_pipe *pipe = (fhandler_pipe *)(fhandler_base *) cfd;
> > +	bool mode = iscygwin ? pipe->is_nonblocking () : false;
> > +	pipe->set_pipe_non_blocking (mode);
> 
> What bugs me here is that we now run the loop for cygwin children
> as well.  The old code only did that for non-cygwin children.
> This looks like quite a performance hit, potentially. Especially
> if the process has many open descriptors.  Let's say, a recursive
> make or so.  Did you find this is necessary?  No way to avoid that?

Yeah, you are right. It is not too late to set non-blocking mode
in fixup_after_exec(). Thanks.

> > +
> > +	/* Setup for query_ndl stuff. Read the comment below. */
> > +	if (!iscygwin && pipe->request_close_query_hdl ())
> > +	  need_send_noncygchld_sig = true;
> > +      }
> > +    else if (cfd->get_dev () == FH_PIPER && fd == fileno_stdin)
> > +      {
> > +	fhandler_pipe *pipe = (fhandler_pipe *)(fhandler_base *) cfd;
> > +	pipe->set_pipe_non_blocking (iscygwin);
> > +      }
> > +
> > +  /* If multiple writers including non-cygwin app exist, the non-cygwin
> > +     app cannot detect pipe closure on the read side when the pipe is
> > +     created by system account or the the pipe creator is running as
>                                      ^^^^^^^

Fixed.

Please check v3 patch attached.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Tue__12_Mar_2024_08_03_16_+0900_iN/Few+OyLu+6var
Content-Type: text/plain;
 name="v3-0001-Cygwin-pipe-Make-sure-to-set-read-pipe-non-blocki.patch"
Content-Disposition: attachment;
 filename="v3-0001-Cygwin-pipe-Make-sure-to-set-read-pipe-non-blocki.patch"
Content-Transfer-Encoding: base64

RnJvbSAyNzc4ZjUxMWY3ZjNiMzdjNmJlZGNhZmY2MjBkNTA4NmEyOGZmN2Q4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogVGFrYXNoaSBZYW5vIDx0YWthc2hpLnlhbm9AbmlmdHkubmUu
anA+DQpEYXRlOiBNb24sIDExIE1hciAyMDI0IDIyOjA4OjAwICswOTAwDQpTdWJqZWN0OiBbUEFU
Q0ggdjNdIEN5Z3dpbjogcGlwZTogTWFrZSBzdXJlIHRvIHNldCByZWFkIHBpcGUgbm9uLWJsb2Nr
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
LS0NCiB3aW5zdXAvY3lnd2luL2ZoYW5kbGVyL3BpcGUuY2MgICAgICAgICAgfCA2MSArKysrKysr
KysrKysrKysrKysrKysrKysrDQogd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9maGFuZGxl
ci5oIHwgIDMgKysNCiB3aW5zdXAvY3lnd2luL3NwYXduLmNjICAgICAgICAgICAgICAgICAgfCAz
NCArLS0tLS0tLS0tLS0tLQ0KIDMgZmlsZXMgY2hhbmdlZCwgNjYgaW5zZXJ0aW9ucygrKSwgMzIg
ZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2ZoYW5kbGVyL3BpcGUu
Y2MgYi93aW5zdXAvY3lnd2luL2ZoYW5kbGVyL3BpcGUuY2MNCmluZGV4IDI5ZDNiNDFkOS4uNTUz
YmFlOGMzIDEwMDY0NA0KLS0tIGEvd2luc3VwL2N5Z3dpbi9maGFuZGxlci9waXBlLmNjDQorKysg
Yi93aW5zdXAvY3lnd2luL2ZoYW5kbGVyL3BpcGUuY2MNCkBAIC0xOCw2ICsxOCw3IEBAIGRldGFp
bHMuICovDQogI2luY2x1ZGUgInBpbmZvLmgiDQogI2luY2x1ZGUgInNoYXJlZF9pbmZvLmgiDQog
I2luY2x1ZGUgInRsc19wYnVmLmgiDQorI2luY2x1ZGUgInNpZ3Byb2MuaCINCiAjaW5jbHVkZSA8
YXNzZXJ0Lmg+DQogDQogLyogVGhpcyBpcyBvbmx5IHRvIGJlIHVzZWQgZm9yIHdyaXRpbmcuICBX
aGVuIHJlYWRpbmcsDQpAQCAtNjAyLDYgKzYwMywxNCBAQCBmaGFuZGxlcl9waXBlOjpmaXh1cF9h
ZnRlcl9mb3JrIChIQU5ETEUgcGFyZW50KQ0KICAgUmVsZWFzZU11dGV4IChoZGxfY250X210eCk7
DQogfQ0KIA0KK3ZvaWQNCitmaGFuZGxlcl9waXBlOjpmaXh1cF9hZnRlcl9leGVjICgpDQorew0K
KyAgYm9vbCBtb2RlID0gZ2V0X2RldmljZSAoKSA9PSBGSF9QSVBFVyA/IGlzX25vbmJsb2NraW5n
ICgpIDogdHJ1ZTsNCisgIHNldF9waXBlX25vbl9ibG9ja2luZyAobW9kZSk7DQorICBmaGFuZGxl
cl9iYXNlOjpmaXh1cF9hZnRlcl9leGVjICgpOw0KK30NCisNCiBpbnQNCiBmaGFuZGxlcl9waXBl
OjpkdXAgKGZoYW5kbGVyX2Jhc2UgKmNoaWxkLCBpbnQgZmxhZ3MpDQogew0KQEAgLTEyODgsMyAr
MTI5Nyw1NSBAQCBjbG9zZV9wcm9jOg0KICAgICB9DQogICByZXR1cm4gTlVMTDsNCiB9DQorDQor
dm9pZA0KK2ZoYW5kbGVyX3BpcGU6OnNwYXduX3dvcmtlciAoaW50IGZpbGVub19zdGRpbiwgaW50
IGZpbGVub19zdGRvdXQsDQorCQkJICAgICBpbnQgZmlsZW5vX3N0ZGVycikNCit7DQorICBib29s
IG5lZWRfc2VuZF9ub25jeWdjaGxkX3NpZyA9IGZhbHNlOw0KKw0KKyAgLyogU2V0IHJlYWQgcGlw
ZSBpdHNlbGYgYWx3YXlzIG5vbi1ibG9ja2luZyBmb3IgY3lnd2luIHByb2Nlc3MuDQorICAgICBC
bG9ja2luZy9ub24tYmxvY2tpbmcgaXMgc2ltdWxhdGVkIGluIHJhd19yZWFkKCkuIEZvciB3cml0
ZQ0KKyAgICAgcGlwZSwgZm9sbG93IGlzX25vbmJsb2NraW5nKCkuICovDQorICBpbnQgZmQ7DQor
ICBjeWdoZWFwX2ZkZW51bSBjZmQgKGZhbHNlKTsNCisgIHdoaWxlICgoZmQgPSBjZmQubmV4dCAo
KSkgPj0gMCkNCisgICAgaWYgKGNmZC0+Z2V0X2RldiAoKSA9PSBGSF9QSVBFVw0KKwkmJiAoZmQg
PT0gZmlsZW5vX3N0ZG91dCB8fCBmZCA9PSBmaWxlbm9fc3RkZXJyKSkNCisgICAgICB7DQorCWZo
YW5kbGVyX3BpcGUgKnBpcGUgPSAoZmhhbmRsZXJfcGlwZSAqKShmaGFuZGxlcl9iYXNlICopIGNm
ZDsNCisJcGlwZS0+c2V0X3BpcGVfbm9uX2Jsb2NraW5nIChmYWxzZSk7DQorDQorCS8qIFNldHVw
IGZvciBxdWVyeV9uZGwgc3R1ZmYuIFJlYWQgdGhlIGNvbW1lbnQgYmVsb3cuICovDQorCWlmIChw
aXBlLT5yZXF1ZXN0X2Nsb3NlX3F1ZXJ5X2hkbCAoKSkNCisJICBuZWVkX3NlbmRfbm9uY3lnY2hs
ZF9zaWcgPSB0cnVlOw0KKyAgICAgIH0NCisgICAgZWxzZSBpZiAoY2ZkLT5nZXRfZGV2ICgpID09
IEZIX1BJUEVSICYmIGZkID09IGZpbGVub19zdGRpbikNCisgICAgICB7DQorCWZoYW5kbGVyX3Bp
cGUgKnBpcGUgPSAoZmhhbmRsZXJfcGlwZSAqKShmaGFuZGxlcl9iYXNlICopIGNmZDsNCisJcGlw
ZS0+c2V0X3BpcGVfbm9uX2Jsb2NraW5nIChmYWxzZSk7DQorICAgICAgfQ0KKw0KKyAgLyogSWYg
bXVsdGlwbGUgd3JpdGVycyBpbmNsdWRpbmcgbm9uLWN5Z3dpbiBhcHAgZXhpc3QsIHRoZSBub24t
Y3lnd2luDQorICAgICBhcHAgY2Fubm90IGRldGVjdCBwaXBlIGNsb3N1cmUgb24gdGhlIHJlYWQg
c2lkZSB3aGVuIHRoZSBwaXBlIGlzDQorICAgICBjcmVhdGVkIGJ5IHN5c3RlbSBhY2NvdW50IG9y
IHRoZSBwaXBlIGNyZWF0b3IgaXMgcnVubmluZyBhcyBzZXJ2aWNlLg0KKyAgICAgVGhpcyBpcyBi
ZWNhdXNlIHF1ZXJ5X2hkbCB3aGljaCBpcyBoZWxkIGluIHdyaXRlIHNpZGUgYWxzbyBpcyBhIHJl
YWQNCisgICAgIGVuZCBvZiB0aGUgcGlwZSwgc28gdGhlIHBpcGUgaXMgc3RpbGwgYWxpdmUgZm9y
IHRoZSBub24tY3lnd2luIGFwcA0KKyAgICAgZXZlbiBhZnRlciB0aGUgcmVhZGVyIGlzIGNsb3Nl
ZC4NCisNCisgICAgIFRvIGF2b2lkIHRoaXMgcHJvYmxlbSwgbGV0IGFsbCBwcm9jZXNzZXMgaW4g
dGhlIHNhbWUgcHJvY2Vzcw0KKyAgICAgZ3JvdXAgY2xvc2UgcXVlcnlfaGRsIHVzaW5nIGludGVy
bmFsIHNpZ25hbCBfX1NJR05PTkNZR0NITEQgd2hlbg0KKyAgICAgbm9uLWN5Z3dpbiBhcHAgaXMg
c3RhcnRlZC4gICovDQorICBpZiAobmVlZF9zZW5kX25vbmN5Z2NobGRfc2lnKQ0KKyAgICB7DQor
ICAgICAgdHR5X21pbiBkdW1teV90dHk7DQorICAgICAgZHVtbXlfdHR5Lm50dHkgPSAoZmhfZGV2
aWNlcykgbXlzZWxmLT5jdHR5Ow0KKyAgICAgIGR1bW15X3R0eS5wZ2lkID0gbXlzZWxmLT5wZ2lk
Ow0KKyAgICAgIHR0eV9taW4gKnQgPSBjeWd3aW5fc2hhcmVkLT50dHkuZ2V0X2N0dHlwICgpOw0K
KyAgICAgIGlmICghdCkgLyogSWYgdHR5IGlzIG5vdCBhbGxvY2F0ZWQsIHVzZSBkdW1teV90dHkg
aW5zdGVhZC4gKi8NCisJdCA9ICZkdW1teV90dHk7DQorICAgICAgLyogRW1pdCBfX1NJR05PTkNZ
R0NITEQgdG8gbGV0IGFsbCBwcm9jZXNzZXMgaW4gdGhlDQorCSBwcm9jZXNzIGdyb3VwIGNsb3Nl
IHF1ZXJ5X2hkbC4gKi8NCisgICAgICB0LT5raWxsX3BncnAgKF9fU0lHTk9OQ1lHQ0hMRCk7DQor
ICAgIH0NCit9DQpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9maGFu
ZGxlci5oIGIvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9maGFuZGxlci5oDQppbmRleCA4
NzI5ZWIyNzYuLmQ5ZTBhMDExYiAxMDA2NDQNCi0tLSBhL3dpbnN1cC9jeWd3aW4vbG9jYWxfaW5j
bHVkZXMvZmhhbmRsZXIuaA0KKysrIGIvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9maGFu
ZGxlci5oDQpAQCAtMTIzNCw2ICsxMjM0LDcgQEAgcHVibGljOg0KICAgaW50IG9wZW4gKGludCBm
bGFncywgbW9kZV90IG1vZGUgPSAwKTsNCiAgIGJvb2wgb3Blbl9zZXR1cCAoaW50IGZsYWdzKTsN
CiAgIHZvaWQgZml4dXBfYWZ0ZXJfZm9yayAoSEFORExFKTsNCisgIHZvaWQgZml4dXBfYWZ0ZXJf
ZXhlYyAoKTsNCiAgIGludCBkdXAgKGZoYW5kbGVyX2Jhc2UgKmNoaWxkLCBpbnQpOw0KICAgdm9p
ZCBzZXRfY2xvc2Vfb25fZXhlYyAoYm9vbCB2YWwpOw0KICAgaW50IGNsb3NlICgpOw0KQEAgLTEy
OTUsNiArMTI5Niw4IEBAIHB1YmxpYzoNCiAJfQ0KICAgICAgIHJldHVybiBmYWxzZTsNCiAgICAg
fQ0KKyAgc3RhdGljIHZvaWQgc3Bhd25fd29ya2VyIChpbnQgZmlsZW5vX3N0ZGluLCBpbnQgZmls
ZW5vX3N0ZG91dCwNCisJCQkgICAgaW50IGZpbGVub19zdGRlcnIpOw0KIH07DQogDQogI2RlZmlu
ZSBDWUdXSU5fRklGT19QSVBFX05BTUVfTEVOICAgICA0Nw0KZGlmZiAtLWdpdCBhL3dpbnN1cC9j
eWd3aW4vc3Bhd24uY2MgYi93aW5zdXAvY3lnd2luL3NwYXduLmNjDQppbmRleCA3MWQ3NWJiZjQu
LjNkYTc3MDg4ZCAxMDA2NDQNCi0tLSBhL3dpbnN1cC9jeWd3aW4vc3Bhd24uY2MNCisrKyBiL3dp
bnN1cC9jeWd3aW4vc3Bhd24uY2MNCkBAIC01ODAsMzggKzU4MCw4IEBAIGNoaWxkX2luZm9fc3Bh
d246OndvcmtlciAoY29uc3QgY2hhciAqcHJvZ19hcmcsIGNvbnN0IGNoYXIgKmNvbnN0ICphcmd2
LA0KICAgICAgIGludCBmaWxlbm9fc3RkZXJyID0gMjsNCiANCiAgICAgICBpZiAoIWlzY3lnd2lu
ICgpKQ0KLQl7DQotCSAgYm9vbCBuZWVkX3NlbmRfc2lnID0gZmFsc2U7DQotCSAgaW50IGZkOw0K
LQkgIGN5Z2hlYXBfZmRlbnVtIGNmZCAoZmFsc2UpOw0KLQkgIHdoaWxlICgoZmQgPSBjZmQubmV4
dCAoKSkgPj0gMCkNCi0JICAgIGlmIChjZmQtPmdldF9kZXYgKCkgPT0gRkhfUElQRVcNCi0JCSAg
ICAgJiYgKGZkID09IGZpbGVub19zdGRvdXQgfHwgZmQgPT0gZmlsZW5vX3N0ZGVycikpDQotCSAg
ICAgIHsNCi0JCWZoYW5kbGVyX3BpcGUgKnBpcGUgPSAoZmhhbmRsZXJfcGlwZSAqKShmaGFuZGxl
cl9iYXNlICopIGNmZDsNCi0JCXBpcGUtPnNldF9waXBlX25vbl9ibG9ja2luZyAoZmFsc2UpOw0K
LQkJaWYgKHBpcGUtPnJlcXVlc3RfY2xvc2VfcXVlcnlfaGRsICgpKQ0KLQkJICBuZWVkX3NlbmRf
c2lnID0gdHJ1ZTsNCi0JICAgICAgfQ0KLQkgICAgZWxzZSBpZiAoY2ZkLT5nZXRfZGV2ICgpID09
IEZIX1BJUEVSICYmIGZkID09IGZpbGVub19zdGRpbikNCi0JICAgICAgew0KLQkJZmhhbmRsZXJf
cGlwZSAqcGlwZSA9IChmaGFuZGxlcl9waXBlICopKGZoYW5kbGVyX2Jhc2UgKikgY2ZkOw0KLQkJ
cGlwZS0+c2V0X3BpcGVfbm9uX2Jsb2NraW5nIChmYWxzZSk7DQotCSAgICAgIH0NCi0NCi0JICBp
ZiAobmVlZF9zZW5kX3NpZykNCi0JICAgIHsNCi0JICAgICAgdHR5X21pbiBkdW1teV90dHk7DQot
CSAgICAgIGR1bW15X3R0eS5udHR5ID0gKGZoX2RldmljZXMpIG15c2VsZi0+Y3R0eTsNCi0JICAg
ICAgZHVtbXlfdHR5LnBnaWQgPSBteXNlbGYtPnBnaWQ7DQotCSAgICAgIHR0eV9taW4gKnQgPSBj
eWd3aW5fc2hhcmVkLT50dHkuZ2V0X2N0dHlwICgpOw0KLQkgICAgICBpZiAoIXQpIC8qIElmIHR0
eSBpcyBub3QgYWxsb2NhdGVkLCB1c2UgZHVtbXlfdHR5IGluc3RlYWQuICovDQotCQl0ID0gJmR1
bW15X3R0eTsNCi0JICAgICAgLyogRW1pdCBfX1NJR05PTkNZR0NITEQgdG8gbGV0IGFsbCBwcm9j
ZXNzZXMgaW4gdGhlDQotCQkgcHJvY2VzcyBncm91cCBjbG9zZSBxdWVyeV9oZGwuICovDQotCSAg
ICAgIHQtPmtpbGxfcGdycCAoX19TSUdOT05DWUdDSExEKTsNCi0JICAgIH0NCi0JfQ0KKwlmaGFu
ZGxlcl9waXBlOjpzcGF3bl93b3JrZXIgKGZpbGVub19zdGRpbiwgZmlsZW5vX3N0ZG91dCwNCisJ
CQkJICAgICBmaWxlbm9fc3RkZXJyKTsNCiANCiAgICAgICBib29sIG5vX3Bjb24gPSBtb2RlICE9
IF9QX09WRVJMQVkgJiYgbW9kZSAhPSBfUF9XQUlUOw0KICAgICAgIHRlcm1fc3Bhd25fd29ya2Vy
LnNldHVwIChpc2N5Z3dpbiAoKSwgaGFuZGxlIChmaWxlbm9fc3RkaW4sIGZhbHNlKSwNCi0tIA0K
Mi40My4wDQoNCg==

--Multipart=_Tue__12_Mar_2024_08_03_16_+0900_iN/Few+OyLu+6var--
