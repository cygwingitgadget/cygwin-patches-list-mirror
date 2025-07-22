Return-Path: <SRS0=6E+G=2D=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 1E6913858C31
	for <cygwin-patches@cygwin.com>; Tue, 22 Jul 2025 17:20:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1E6913858C31
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1E6913858C31
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753204821; cv=none;
	b=G5KusugrWbpQU0gJ8L+yfbNjKFCGzIja0brSlF3HxJMvaPqj+DQmrRmt/qqnPoUcZ4/u57VWxR/LB//IXG+qt4fJ0t8sXf8+EIkTxxBh3QpELTRjfczFZsa4ht9OG0sfin3sj58U22pK6tHcfjuOkw7DtSb6NZ1+Chp/4jX4ZFg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753204821; c=relaxed/simple;
	bh=6Bk708OjmSz9BIuM734ntlzk0oLBgeDA3Q4D7LSIriA=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=d20NvSLWJlfeyldV91CR0Pxj/SzlIOzPzHztkFdpB3p8IgXRXOerpvENtgMEiU0NMqw995wOwu9JUYW2K4Kw6guWX2KyI9P6RhJodvqWYMLeBuINYNTbM9XPj7ASZXdZJsPLi2Iu0wu7JACnd+Bd45/bf+F5XYnNWVvspVuWVFI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1E6913858C31
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=uo44UAFr
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id B72EE45CBB
	for <cygwin-patches@cygwin.com>; Tue, 22 Jul 2025 13:20:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=mY0SZd6EB0vmrqvxIBcv249j1MQ=; b=uo44U
	AFroguaDzlCGsLPUnjDNoZV209WgcbtMK4AxG+65zGfKjlGdy7NFPb9bQItNI4pT
	PFncRrECgyuHdWcCf6zCTKCW9g/02gwdlC5Tu9F6aeFPczXIaKfslZAx0apdLa9E
	HdOd5oHPEttZbmi+xr6lIwQI6TE0CKdDJc6a64=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id B298F45A5F
	for <cygwin-patches@cygwin.com>; Tue, 22 Jul 2025 13:20:20 -0400 (EDT)
Date: Tue, 22 Jul 2025 10:20:20 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [EXTERNAL] Re: [PATCH] Cygwin: mkimport: implement AArch64 +/-4GB
 relocations
In-Reply-To: <aH9jZCS92AGUaP-o@calimero.vinschen.de>
Message-ID: <b76de53a-24a7-0983-c756-2fd7213950f2@jdrake.com>
References: <DB9PR83MB0923E3D187978CF43940B188925DA@DB9PR83MB0923.EURPRD83.prod.outlook.com> <aH4NM_WJNC2KHpHT@calimero.vinschen.de> <23af2767-7e76-74fd-198f-2abdee7cc73e@jdrake.com> <GV4PR83MB0941B168699D42E77A73814F925CA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
 <aH9Pi6bJNDa_Q7V1@calimero.vinschen.de> <GV4PR83MB09417042234459A19594C15C925CA@GV4PR83MB0941.EURPRD83.prod.outlook.com> <aH9jZCS92AGUaP-o@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 22 Jul 2025, Corinna Vinschen wrote:

> On Jul 22 09:12, Radek Barton via Cygwin-patches wrote:
> > Hello.
> >
> > Thank you for this insight. So, if I build tcsh using AArch64 Cygwin
> > GNU toolchain, I should see if this behaves correctly with debugger?
>
> Yes, that would probably be helpful.  tcsh overwrites the malloc/free
> entries of __cygwin_user_data in _cygwin_crt0_common(), which is linked
> into the executable.  This occurs after dll_crt0_0, but before dll_crt0_1.
>
> So what you should see is somthing like this:
>
> (gdb) br dll_crt0_0
> (gdb) br dll_crt0_1
> (gdb) r
> Starting program: /bin/tcsh
> [New Thread 1832.0x4ac]
> [New Thread 1832.0x22d0]
>
> Thread 1 hit Breakpoint 1, dll_crt0_0 ()
> [...]
> (gdb) p __cygwin_user_data.malloc
> $6 = (void *(*)(size_t)) 0x7ffc8504cee9 <malloc>   <== pointing into cygwin1.dll
> (gdb) c
> Thread 1 hit Breakpoint 2, dll_crt0_1 ()
> [...]
> (gdb) p __cygwin_user_data.malloc
> $6 = (void *(*)(size_t)) 0x100448940 <malloc>      <== pointing into tcsh

This wouldn't be an import though.  I guess malloc would need to be
imported from a different dll for that case...

> Theoretically import_address() is only required to be able to resolve
> pointers into the Cygwin DLL itself correctly.  If it can resolve all
> variations of import table entries created by gcc for the Cygwin DLL,
> it's sufficient.  If other variations exist, but are never emitted by
> gcc(*), it would be entirely sufficent if import_address() returns NULL.
>
> tl;dr: As long as it always recognizes
>
>   import_address ((void *) user_data->malloc) == &_sigfe_malloc
>
> we're good.

... But apparently it doesn't matter if it gets the jump stub or the
imported function for that case.

Just for the record, these import jump stubs are generated by the linker
(or dlltool as part of the import library).  Apparently for the Cygwin
dll, the import library (or at least these parts of it) are generated by
mkimport rather that via the normal dlltool process.  So it's probably OK
if this code only recognizes the form of import stub generated by mkimport
which with this patch now matches what MS and LLD generate).  It's strange
to me that binutils' dlltool uses an additional instruction that doesn't
seem to be necessary.  It may not be a bad idea to either support that or
at least add a comment documenting that that's the case, in case
something later wants to use this function for some other import case.


