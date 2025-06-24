Return-Path: <SRS0=Ra+6=ZH=redhat.com=vinschen@sourceware.org>
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by sourceware.org (Postfix) with ESMTP id 48DCF3857B8F
	for <cygwin-patches@cygwin.com>; Tue, 24 Jun 2025 08:28:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 48DCF3857B8F
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=redhat.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 48DCF3857B8F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750753686; cv=none;
	b=iffHVytDJtXjbuJQjTrJS6/9Y8uypTi+zZ5WBNXoo27SVvz61EizOpfxtajoT4GCHjbtnBPlSPpSUUzGuqCdW+ws3iFY4uulARDdtNaHD66OA+1Grpkf+8aI0aMqTJkyd234k0fzOzsql20hpbS4ZmLn3aBaEEWLEMbyHd5fhGw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750753686; c=relaxed/simple;
	bh=tFEHZYSGpfkxt+N4YFgmGeJo9CGz09lN3leIrXT7uSI=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Bls4B19wAZFV2U7aoyTgPT79gC2VfFxcDQrY0dvIF559WxFcCm/afZVQQc5ph35MmVSB+qoOO82XUvwA8wtGed1UTT/b30CF4M/yjePFtnqZkwMKqbVgo8fmS9zfmx85PPgVTgpdghoqfi+ijK9/8WHYqaXmbSSTdFiCn5gfNz0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 48DCF3857B8F
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BiVXbyRQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750753686;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ztqP1/KzMRquP+f6CfmXR2405nq8Q2fWG+eLbq3uaBA=;
	b=BiVXbyRQHM64wfcsslA0h3EucSWBgh1hErHeIpf4uCtUsD3KqiF8foWS6sYGlJapCEG0eU
	x9y9TvH0juZALzfplKUjGm0W+1paWDSJyFVa/N0b8VteXPLHNHQAWx9hUXa9qKQ4VPVOuT
	8ColZgXhOa1wqWl55FZ7QVKXssgmx1s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-enPyyAm2MomY2jKu9hWdsw-1; Tue,
 24 Jun 2025 04:27:59 -0400
X-MC-Unique: enPyyAm2MomY2jKu9hWdsw-1
X-Mimecast-MFC-AGG-ID: enPyyAm2MomY2jKu9hWdsw_1750753678
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89535180120C;
	Tue, 24 Jun 2025 08:27:58 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.44.33.82])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F155C18003FC;
	Tue, 24 Jun 2025 08:27:57 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 13B93A80CF9; Tue, 24 Jun 2025 10:27:55 +0200 (CEST)
Date: Tue, 24 Jun 2025 10:27:55 +0200
From: Corinna Vinschen <vinschen@redhat.com>
To: "Richard Earnshaw (lists)" <Richard.Earnshaw@arm.com>
Cc: Radek Barton <radek.barton@microsoft.com>,
	Newlib <newlib@sourceware.org>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH/QUESTION] newlib: fenv: AArch64 Cygwin linking fixes
Message-ID: <aFphi2eE4XmnypdT@calimero.vinschen.de>
Reply-To: newlib@sourceware.org
Mail-Followup-To: "Richard Earnshaw (lists)" <Richard.Earnshaw@arm.com>,
	Radek Barton <radek.barton@microsoft.com>,
	Newlib <newlib@sourceware.org>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <GV4PR83MB0941761524523870C31AC5BD9270A@GV4PR83MB0941.EURPRD83.prod.outlook.com>
 <91bf97b2-383c-44a8-a2f3-9c38dfddcfb2@arm.com>
MIME-Version: 1.0
In-Reply-To: <91bf97b2-383c-44a8-a2f3-9c38dfddcfb2@arm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TnyKBLcbbhLpiyyumSo7fJhwPtGaXjsqnq9S2Cub6e0_1750753678
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_W,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_NONE,TXREP autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Jun 23 16:36, Richard Earnshaw (lists) wrote:
> On 16/06/2025 12:31, Radek Barton wrote:
> > Hello.
> > 
> > This is more a question than patch submission: Without the attached changes, the Cygwin cannot be linked for AArch64 failing on:
> > ```
> > ld: cannot export _fe_nomask_env: symbol not defined
> > ld: cannot export fedisableexcept: symbol not defined
> > ld: cannot export fegetexcept: symbol not defined
> > ld: cannot export fegetprec: symbol not defined
> > ld: cannot export fesetprec: symbol not defined
> > ```
> > Can anybody share some insights why are those changes needed and whether there is a better way how to overcome this issue?
> > 
> > Note that the `feenableexcept`, `fedisableexcept`, `fegetexcept` implementations are similarly defined in `newlib/libc/machine/mips/machine/fenv-fp.h` for MIPS architecture as well.
> > 
> > Thank you,
> > 
> > Radek
> > 
> 
> Ugh, this is a real rat's nest of code...
> 
> I may be on completely the wrong track, but I think the clue is in the comment:
> 
>  +/* We currently provide no external definitions of the functions below. */
> 
> So it is expected that these functions have no definition in a file, but will be inlined into the calling code when needed.  This is why they are provided in fenv.h.  fenv-fp.h seems to be the internal header that is used for code that will create the non-inlined versions; the header file fenv-fp.h isn't exported from the library though (it's only used while building it), so anything defined there will never be inlined into user code.
> 
> I suspect that the underlying issue is that coff libraries rely on
> explicitly exporting symbols, while ELF libraries do that implicitly
> (unless something is explicitly marked hidden).

I wonder if this is really the issue, because binutils ld performs
its auto-export magic for coff symbols for ages on Cygwin.  Unless
you define exactly the symbols to export in a .def file, that is.

However, Cygwin's .def file explicitly exports the above fe* symbols.

They are just not actually present in the object files in case of the
aarch64 build per Radek.


> What I don't fully understand is what role __BSD_VISIBLE might have
> here.  If that's not defined (which I'd think is possible in CYGWIN),

Only for applications built under Cygwin, but not for building the Cygwin
DLL itself, which is the problem here.

> then I can't see how your changes would resolve this.
> 
> I'm guessing (somewhat) that libm/.../fenv.c should perhaps define __BSD_VISIBLE before including fenv.h to force the inline functions to become visible. 
> 
> The other alternative might be to remove the list of functions scoped by the ifdef from libm/machine/aarch64/fenv.c so that the functions that file exports matches the comment I mentioned above.
> 
> Perhaps you could try this patch instead of yours and let me know if it resolves the issue:
> 
> diff --git a/newlib/libm/machine/aarch64/fenv.c b/newlib/libm/machine/aarch64/fenv.c
> index 3ffe23441..fb6a67dcc 100644
> --- a/newlib/libm/machine/aarch64/fenv.c
> +++ b/newlib/libm/machine/aarch64/fenv.c
> @@ -27,6 +27,9 @@
>   * $FreeBSD$
>   */
>  
> +/* Enable all fenv-related functions.  */
> +#define __BSD_VISIBLE
> +
>  #define        __fenv_static
>  #include <fenv.h>
>  #include <machine/fenv-fp.h>

Worth a try.


Thanks,
Corinna

