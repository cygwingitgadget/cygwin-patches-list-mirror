Return-Path: <SRS0=ZRpm=KL=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1015.nifty.com (mta-snd01004.nifty.com [106.153.227.36])
	by sourceware.org (Postfix) with ESMTPS id E0C113858C98
	for <cygwin-patches@cygwin.com>; Tue,  5 Mar 2024 18:42:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E0C113858C98
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E0C113858C98
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1709664150; cv=none;
	b=ZJRBwNK/Ny6f8Mg1fDfmt8wmrUOSrk2ufCrEZJKOIvUza2WQxECHaNNV5sf+wzPm7jA/XQLS5GpayUlNvmzR21CdSe+/9RlMXW9oTvUuJy4AChhzq6kWMJcYfF8YckuA/v7RsFPnU/xnCRWNuHbZIDxAP4vavvXHTGsk/dF+7qg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1709664150; c=relaxed/simple;
	bh=HOyk7+2qjJGj9XnEzllpGjVnyoAdGWXRN9xbzrcxKFY=;
	h=Date:From:To:Subject:Message-Id:Mime-Version; b=sF4NI3DaeBY0WkH/rMLGl92rB9ktOlkvqGIxbWuLIxOBVCECJMGbZypGJNI8wmcv4nb3nkALzZhQb5p+dvaENtNPrPhr4X10F3hs8Kjcc2NlwVv+uSDamOKhLQnvlrYLURRg7i+aIeoKOcj71kX2x8EfyfrLEe9xFDg8Q7lhviw=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by dmta1015.nifty.com with ESMTP
          id <20240305184224851.FLRD.81092.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 6 Mar 2024 03:42:24 +0900
Date: Wed, 6 Mar 2024 03:42:23 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Give up to use query_hdl for non-cygwin
 apps.
Message-Id: <20240306034223.4d02b898542324431341b2bb@nifty.ne.jp>
In-Reply-To: <ZedOO5gM1xApOb3A@calimero.vinschen.de>
References: <b0bd6b96-5bd8-7f4e-71ff-4552e5ac1cb5@gmx.de>
	<20240303192109.9fb4a3a4968bb11ca5d9636a@nifty.ne.jp>
	<87a5nfbnv7.fsf@Gerda.invalid>
	<20240303203641.09321b0a0713e8bdb90980b5@nifty.ne.jp>
	<ZeWjmEikjIUushtk@calimero.vinschen.de>
	<87edcqgfwc.fsf@>
	<ZeYG_11UfRTLzit1@calimero.vinschen.de>
	<20240305090648.6342d8f9cb8fd4ca64b47d38@nifty.ne.jp>
	<ZebwloVEzedGcBWj@calimero.vinschen.de>
	<20240305234753.b484e79322961aba9f8c9979@nifty.ne.jp>
	<ZedOO5gM1xApOb3A@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__6_Mar_2024_03_42_23_+0900_5WP3UoR1Wb7E1jNz"
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.

--Multipart=_Wed__6_Mar_2024_03_42_23_+0900_5WP3UoR1Wb7E1jNz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Mar 2024 17:54:19 +0100
Corinna Vinschen wrote:
> On Mar  5 23:47, Takashi Yano wrote:
> > On Tue, 5 Mar 2024 11:14:46 +0100
> > Corinna Vinschen wrote:
> > > This doesn't affect your patch, but while looking into this, what
> > > strikes me as weird is that fhandler_pipe::temporary_query_hdl() calls
> > > NtQueryObject() and assembles the pipe name via swscanf() every time it
> > > is called.
> > > 
> > > Wouldn't it make sense to store the name in the fhandler's
> > > path_conv::wide_path/uni_path at creation time instead?
> > > The wide_path member is not used at all in pipes, ostensibly.
> > 
> > Is the patch attached as you intended?
> 
> Yes, but it looks like it misses a few potential simplifications:
> 
> > diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
> > index c877d89d7..0611dd1c3 100644
> > --- a/winsup/cygwin/fhandler/pipe.cc
> > +++ b/winsup/cygwin/fhandler/pipe.cc
> > @@ -93,6 +93,19 @@ fhandler_pipe::init (HANDLE f, DWORD a, mode_t mode, int64_t uniq_id)
> >         even with FILE_SYNCHRONOUS_IO_NONALERT. */
> >      set_pipe_non_blocking (get_device () == FH_PIPER ?
> >  			   true : is_nonblocking ());
> > +
> > +  /* Store pipe name to path_conv pc for query_hdl check */
> > +  if (get_dev () == FH_PIPEW)
> > +    {
> > +      ULONG len;
> > +      tmp_pathbuf tp;
> > +      OBJECT_NAME_INFORMATION *ntfn = (OBJECT_NAME_INFORMATION *) tp.w_get ();
> > +      NTSTATUS status = NtQueryObject (f, ObjectNameInformation, ntfn,
> > +				       65536, &len);
> > +      if (NT_SUCCESS (status) && ntfn->Name.Buffer)
> > +	pc.set_nt_native_path (&ntfn->Name);
> 
> We don't have to call NtQueryObject.  The name is created in nt_create()
> and we know the unique id, so the name is
> 
>   "%S%S-%u-pipe-nt-%p", &ro_u_ntfs, &cygheap->installation_key,
>   			GetCurrentProcessId (), unique_id);
> 
> Do you think it's cheaper to call NtQueryObject()?  If so, no worries,
> but NtQueryObject() has to call into the kernel, while just creating
> the name by ourselves doesn't.
> 
> > @@ -1149,6 +1162,9 @@ fhandler_pipe::temporary_query_hdl ()
> >    tmp_pathbuf tp;
> >    OBJECT_NAME_INFORMATION *ntfn = (OBJECT_NAME_INFORMATION *) tp.w_get ();
> >  
> > +  UNICODE_STRING *name = pc.get_nt_native_path (NULL);
> > +  name->Buffer[name->Length / sizeof (WCHAR)] = L'\0';
> 
> The string returned by get_nt_native_path() is always NUL-terminated.
> 
> >    /* Try process handle opened and pipe handle value cached first
> >       in order to reduce overhead. */
> >    if (query_hdl_proc && query_hdl_value)
> > @@ -1161,14 +1177,7 @@ fhandler_pipe::temporary_query_hdl ()
> >        status = NtQueryObject (h, ObjectNameInformation, ntfn, 65536, &len);
> >        if (!NT_SUCCESS (status) || !ntfn->Name.Buffer)
> >  	goto hdl_err;
> > -      ntfn->Name.Buffer[ntfn->Name.Length / sizeof (WCHAR)] = L'\0';
> > -      uint64_t key;
> > -      DWORD pid;
> > -      LONG id;
> > -      if (swscanf (ntfn->Name.Buffer,
> > -		   L"\\Device\\NamedPipe\\%llx-%u-pipe-nt-0x%x",
> > -		   &key, &pid, &id) == 3 &&
> > -	  key == pipename_key && pid == pipename_pid && id == pipename_id)
> > +      if (RtlEqualUnicodeString (name, &ntfn->Name, FALSE))
> >  	return h;
> >  hdl_err:
> >        CloseHandle (h);
> > @@ -1178,19 +1187,9 @@ cache_err:
> >        query_hdl_value = NULL;
> >      }
> >  
> > -  status = NtQueryObject (get_handle (), ObjectNameInformation, ntfn,
> > -			  65536, &len);
> > -  if (!NT_SUCCESS (status) || !ntfn->Name.Buffer)
> > +  if (name->Length == 0 || name->Buffer == NULL)
> >      return NULL; /* Non cygwin pipe? */
> > -  WCHAR name[MAX_PATH];
> > -  int namelen = min (ntfn->Name.Length / sizeof (WCHAR), MAX_PATH-1);
> > -  memcpy (name, ntfn->Name.Buffer, namelen * sizeof (WCHAR));
> > -  name[namelen] = L'\0';
> > -  if (swscanf (name, L"\\Device\\NamedPipe\\%llx-%u-pipe-nt-0x%x",
> > -	       &pipename_key, &pipename_pid, &pipename_id) != 3)
> > -    return NULL; /* Non cygwin pipe? */
> > -
> > -  return get_query_hdl_per_process (name, ntfn); /* Since Win8 */
> > +  return get_query_hdl_per_process (name->Buffer, ntfn); /* Since Win8 */
> 
> Given the name is stored in the fhandler, get_query_hdl_per_process()
> doesn't need it as argument, and get_query_hdl_per_process() can just
> call RtlCompareUnicodeString() instead of adding a \0 and calling
> wcscmp().

Thanks for advice. I have revised the patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Wed__6_Mar_2024_03_42_23_+0900_5WP3UoR1Wb7E1jNz
Content-Type: text/plain;
 name="v2-0001-Cygwin-pipe-Simplify-chhecking-procedure-of-query.patch"
Content-Disposition: attachment;
 filename="v2-0001-Cygwin-pipe-Simplify-chhecking-procedure-of-query.patch"
Content-Transfer-Encoding: base64

RnJvbSBhYWM1OTE5NGFmOGJiODBhNmI5YTA4OTFhMjdmZDdkZTlkMGI2OWZjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogVGFrYXNoaSBZYW5vIDx0YWthc2hpLnlhbm9AbmlmdHkubmUu
anA+DQpEYXRlOiBUdWUsIDUgTWFyIDIwMjQgMjM6MzQ6MjEgKzA5MDANClN1YmplY3Q6IFtQQVRD
SCB2Ml0gQ3lnd2luOiBwaXBlOiBTaW1wbGlmeSBjaGhlY2tpbmcgcHJvY2VkdXJlIG9mIHF1ZXJ5
X2hkbC4NCg0KVGhpcyBwYXRjaCBlbGltaW5hdGVzIHZlcmJvc2UgTnRRdWVyeU9iamVjdCgpIGNh
bGxzIGluIHRoZSBwcm9jZWR1cmUNCnRvIGdldCBxdWVyeV9oZGwgYnkgc3RvcmluZyBwaXBlIG5h
bWUgaW50byBmaGFuZGxlcl9iYXNlOjpwYyB3aGVuDQp0aGUgcGlwZSBpcyBjcmVhdGVkLiAgZmhh
bmRsZXJfcGlwZTo6dGVtcG9yYXJ5X3F1ZXJ5X2hkbCgpIHVzZXMgdGhlDQpzdG9yZWRwaXBlIG5h
bWUgcmF0aGVyIHRoYW4gdGhlIG5hbWUgcmV0cmlldmVkIGJ5IE50UXVlcnlPYmplY3QoKS4NCg0K
U3VnZ2VzdGVkLWJ5OiBDb3Jpbm5hIFZpbnNjaGVuIDxjb3Jpbm5hQHZpbnNjaGVuLmRlPg0KU2ln
bmVkLW9mZi1ieTogVGFrYXNoaSBZYW5vIDx0YWthc2hpLnlhbm9AbmlmdHkubmUuanA+DQotLS0N
CiB3aW5zdXAvY3lnd2luL2ZoYW5kbGVyL3BpcGUuY2MgICAgICAgICAgfCA0NyArKysrKysrKysr
KystLS0tLS0tLS0tLS0tDQogd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9maGFuZGxlci5o
IHwgIDUgKy0tDQogMiBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCAyOCBkZWxldGlv
bnMoLSkNCg0KZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXIvcGlwZS5jYyBiL3dp
bnN1cC9jeWd3aW4vZmhhbmRsZXIvcGlwZS5jYw0KaW5kZXggYzg3N2Q4OWQ3Li4wZDU3ZjU1ODUg
MTAwNjQ0DQotLS0gYS93aW5zdXAvY3lnd2luL2ZoYW5kbGVyL3BpcGUuY2MNCisrKyBiL3dpbnN1
cC9jeWd3aW4vZmhhbmRsZXIvcGlwZS5jYw0KQEAgLTkzLDYgKzkzLDIxIEBAIGZoYW5kbGVyX3Bp
cGU6OmluaXQgKEhBTkRMRSBmLCBEV09SRCBhLCBtb2RlX3QgbW9kZSwgaW50NjRfdCB1bmlxX2lk
KQ0KICAgICAgICBldmVuIHdpdGggRklMRV9TWU5DSFJPTk9VU19JT19OT05BTEVSVC4gKi8NCiAg
ICAgc2V0X3BpcGVfbm9uX2Jsb2NraW5nIChnZXRfZGV2aWNlICgpID09IEZIX1BJUEVSID8NCiAJ
CQkgICB0cnVlIDogaXNfbm9uYmxvY2tpbmcgKCkpOw0KKw0KKyAgLyogU3RvcmUgcGlwZSBuYW1l
IHRvIHBhdGhfY29udiBwYyBmb3IgcXVlcnlfaGRsIGNoZWNrICovDQorICBpZiAoZ2V0X2RldiAo
KSA9PSBGSF9QSVBFVykNCisgICAgew0KKyAgICAgIFVOSUNPREVfU1RSSU5HIG5hbWU7DQorICAg
ICAgV0NIQVIgcGlwZW5hbWVfYnVmW01BWF9QQVRIXTsNCisgICAgICBfX3NtYWxsX3N3cHJpbnRm
IChwaXBlbmFtZV9idWYsIEwiJVMlUy0ldS1waXBlLW50LSVwIiwNCisJCQkmcm9fdV9ucGZzLCAm
Y3lnaGVhcC0+aW5zdGFsbGF0aW9uX2tleSwNCisJCQlHZXRDdXJyZW50UHJvY2Vzc0lkICgpLCB1
bmlxdWVfaWQgPj4gMzIpOw0KKyAgICAgIG5hbWUuTGVuZ3RoID0gd2NzbGVuIChwaXBlbmFtZV9i
dWYpICogc2l6ZW9mIChXQ0hBUik7DQorICAgICAgbmFtZS5NYXhpbXVtTGVuZ3RoID0gTUFYX1BB
VEggKiBzaXplb2YgKFdDSEFSKTsNCisgICAgICBuYW1lLkJ1ZmZlciA9IHBpcGVuYW1lX2J1ZjsN
CisgICAgICBwYy5zZXRfbnRfbmF0aXZlX3BhdGggKCZuYW1lKTsNCisgICAgfQ0KKw0KICAgcmV0
dXJuIDE7DQogfQ0KIA0KQEAgLTExNDksNiArMTE2NCw4IEBAIGZoYW5kbGVyX3BpcGU6OnRlbXBv
cmFyeV9xdWVyeV9oZGwgKCkNCiAgIHRtcF9wYXRoYnVmIHRwOw0KICAgT0JKRUNUX05BTUVfSU5G
T1JNQVRJT04gKm50Zm4gPSAoT0JKRUNUX05BTUVfSU5GT1JNQVRJT04gKikgdHAud19nZXQgKCk7
DQogDQorICBVTklDT0RFX1NUUklORyAqbmFtZSA9IHBjLmdldF9udF9uYXRpdmVfcGF0aCAoTlVM
TCk7DQorDQogICAvKiBUcnkgcHJvY2VzcyBoYW5kbGUgb3BlbmVkIGFuZCBwaXBlIGhhbmRsZSB2
YWx1ZSBjYWNoZWQgZmlyc3QNCiAgICAgIGluIG9yZGVyIHRvIHJlZHVjZSBvdmVyaGVhZC4gKi8N
CiAgIGlmIChxdWVyeV9oZGxfcHJvYyAmJiBxdWVyeV9oZGxfdmFsdWUpDQpAQCAtMTE2MSwxNCAr
MTE3OCw3IEBAIGZoYW5kbGVyX3BpcGU6OnRlbXBvcmFyeV9xdWVyeV9oZGwgKCkNCiAgICAgICBz
dGF0dXMgPSBOdFF1ZXJ5T2JqZWN0IChoLCBPYmplY3ROYW1lSW5mb3JtYXRpb24sIG50Zm4sIDY1
NTM2LCAmbGVuKTsNCiAgICAgICBpZiAoIU5UX1NVQ0NFU1MgKHN0YXR1cykgfHwgIW50Zm4tPk5h
bWUuQnVmZmVyKQ0KIAlnb3RvIGhkbF9lcnI7DQotICAgICAgbnRmbi0+TmFtZS5CdWZmZXJbbnRm
bi0+TmFtZS5MZW5ndGggLyBzaXplb2YgKFdDSEFSKV0gPSBMJ1wwJzsNCi0gICAgICB1aW50NjRf
dCBrZXk7DQotICAgICAgRFdPUkQgcGlkOw0KLSAgICAgIExPTkcgaWQ7DQotICAgICAgaWYgKHN3
c2NhbmYgKG50Zm4tPk5hbWUuQnVmZmVyLA0KLQkJICAgTCJcXERldmljZVxcTmFtZWRQaXBlXFwl
bGx4LSV1LXBpcGUtbnQtMHgleCIsDQotCQkgICAma2V5LCAmcGlkLCAmaWQpID09IDMgJiYNCi0J
ICBrZXkgPT0gcGlwZW5hbWVfa2V5ICYmIHBpZCA9PSBwaXBlbmFtZV9waWQgJiYgaWQgPT0gcGlw
ZW5hbWVfaWQpDQorICAgICAgaWYgKFJ0bEVxdWFsVW5pY29kZVN0cmluZyAobmFtZSwgJm50Zm4t
Pk5hbWUsIEZBTFNFKSkNCiAJcmV0dXJuIGg7DQogaGRsX2VycjoNCiAgICAgICBDbG9zZUhhbmRs
ZSAoaCk7DQpAQCAtMTE3OCwyNCArMTE4OCwxMyBAQCBjYWNoZV9lcnI6DQogICAgICAgcXVlcnlf
aGRsX3ZhbHVlID0gTlVMTDsNCiAgICAgfQ0KIA0KLSAgc3RhdHVzID0gTnRRdWVyeU9iamVjdCAo
Z2V0X2hhbmRsZSAoKSwgT2JqZWN0TmFtZUluZm9ybWF0aW9uLCBudGZuLA0KLQkJCSAgNjU1MzYs
ICZsZW4pOw0KLSAgaWYgKCFOVF9TVUNDRVNTIChzdGF0dXMpIHx8ICFudGZuLT5OYW1lLkJ1ZmZl
cikNCi0gICAgcmV0dXJuIE5VTEw7IC8qIE5vbiBjeWd3aW4gcGlwZT8gKi8NCi0gIFdDSEFSIG5h
bWVbTUFYX1BBVEhdOw0KLSAgaW50IG5hbWVsZW4gPSBtaW4gKG50Zm4tPk5hbWUuTGVuZ3RoIC8g
c2l6ZW9mIChXQ0hBUiksIE1BWF9QQVRILTEpOw0KLSAgbWVtY3B5IChuYW1lLCBudGZuLT5OYW1l
LkJ1ZmZlciwgbmFtZWxlbiAqIHNpemVvZiAoV0NIQVIpKTsNCi0gIG5hbWVbbmFtZWxlbl0gPSBM
J1wwJzsNCi0gIGlmIChzd3NjYW5mIChuYW1lLCBMIlxcRGV2aWNlXFxOYW1lZFBpcGVcXCVsbHgt
JXUtcGlwZS1udC0weCV4IiwNCi0JICAgICAgICZwaXBlbmFtZV9rZXksICZwaXBlbmFtZV9waWQs
ICZwaXBlbmFtZV9pZCkgIT0gMykNCisgIGlmIChuYW1lLT5MZW5ndGggPT0gMCB8fCBuYW1lLT5C
dWZmZXIgPT0gTlVMTCkNCiAgICAgcmV0dXJuIE5VTEw7IC8qIE5vbiBjeWd3aW4gcGlwZT8gKi8N
Ci0NCi0gIHJldHVybiBnZXRfcXVlcnlfaGRsX3Blcl9wcm9jZXNzIChuYW1lLCBudGZuKTsgLyog
U2luY2UgV2luOCAqLw0KKyAgcmV0dXJuIGdldF9xdWVyeV9oZGxfcGVyX3Byb2Nlc3MgKG50Zm4p
OyAvKiBTaW5jZSBXaW44ICovDQogfQ0KIA0KIEhBTkRMRQ0KLWZoYW5kbGVyX3BpcGU6OmdldF9x
dWVyeV9oZGxfcGVyX3Byb2Nlc3MgKFdDSEFSICpuYW1lLA0KLQkJCQkJICBPQkpFQ1RfTkFNRV9J
TkZPUk1BVElPTiAqbnRmbikNCitmaGFuZGxlcl9waXBlOjpnZXRfcXVlcnlfaGRsX3Blcl9wcm9j
ZXNzIChPQkpFQ1RfTkFNRV9JTkZPUk1BVElPTiAqbnRmbikNCiB7DQogICB3aW5waWRzIHBpZHMg
KChEV09SRCkgMCk7DQogDQpAQCAtMTI3Miw4ICsxMjcxLDggQEAgZmhhbmRsZXJfcGlwZTo6Z2V0
X3F1ZXJ5X2hkbF9wZXJfcHJvY2VzcyAoV0NIQVIgKm5hbWUsDQogCQkJCSAgbnRmbiwgNjU1MzYs
ICZsZW4pOw0KIAkgIGlmICghTlRfU1VDQ0VTUyAoc3RhdHVzKSB8fCAhbnRmbi0+TmFtZS5CdWZm
ZXIpDQogCSAgICBnb3RvIGNsb3NlX2hhbmRsZTsNCi0JICBudGZuLT5OYW1lLkJ1ZmZlcltudGZu
LT5OYW1lLkxlbmd0aCAvIHNpemVvZiAoV0NIQVIpXSA9IEwnXDAnOw0KLQkgIGlmICh3Y3NjbXAg
KG5hbWUsIG50Zm4tPk5hbWUuQnVmZmVyKSA9PSAwKQ0KKwkgIGlmIChSdGxFcXVhbFVuaWNvZGVT
dHJpbmcgKHBjLmdldF9udF9uYXRpdmVfcGF0aCAoKSwNCisJCQkJICAgICAmbnRmbi0+TmFtZSwg
RkFMU0UpKQ0KIAkgICAgew0KIAkgICAgICBxdWVyeV9oZGxfcHJvYyA9IHByb2M7DQogCSAgICAg
IHF1ZXJ5X2hkbF92YWx1ZSA9IChIQU5ETEUpKGludHB0cl90KSBwaGktPkhhbmRsZXNbal0uSGFu
ZGxlVmFsdWU7DQpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9maGFu
ZGxlci5oIGIvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9maGFuZGxlci5oDQppbmRleCA2
ZGRmMzczNzAuLjg3MjllYjI3NiAxMDA2NDQNCi0tLSBhL3dpbnN1cC9jeWd3aW4vbG9jYWxfaW5j
bHVkZXMvZmhhbmRsZXIuaA0KKysrIGIvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9maGFu
ZGxlci5oDQpAQCAtMTIxNiwxMSArMTIxNiw4IEBAIHByaXZhdGU6DQogICBIQU5ETEUgcXVlcnlf
aGRsX3Byb2M7DQogICBIQU5ETEUgcXVlcnlfaGRsX3ZhbHVlOw0KICAgSEFORExFIHF1ZXJ5X2hk
bF9jbG9zZV9yZXFfZXZ0Ow0KLSAgdWludDY0X3QgcGlwZW5hbWVfa2V5Ow0KLSAgRFdPUkQgcGlw
ZW5hbWVfcGlkOw0KLSAgTE9ORyBwaXBlbmFtZV9pZDsNCiAgIHZvaWQgcmVsZWFzZV9zZWxlY3Rf
c2VtIChjb25zdCBjaGFyICopOw0KLSAgSEFORExFIGdldF9xdWVyeV9oZGxfcGVyX3Byb2Nlc3Mg
KFdDSEFSICosIE9CSkVDVF9OQU1FX0lORk9STUFUSU9OICopOw0KKyAgSEFORExFIGdldF9xdWVy
eV9oZGxfcGVyX3Byb2Nlc3MgKE9CSkVDVF9OQU1FX0lORk9STUFUSU9OICopOw0KIHB1YmxpYzoN
CiAgIGZoYW5kbGVyX3BpcGUgKCk7DQogDQotLSANCjIuNDMuMA0KDQo=

--Multipart=_Wed__6_Mar_2024_03_42_23_+0900_5WP3UoR1Wb7E1jNz--
