Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 95C313857830; Tue, 22 Jul 2025 10:09:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 95C313857830
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1753178982;
	bh=oCxREOcAdzA8xQaC71lUHQGigODuYNEc7iIui+ifT+g=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=e8JAFPoZxoj98p46mRr7nxRbFsAimwF+mxmml3dE5mZJDPkQW/ROSom4M3cmgKqX9
	 wpcFF4QtYHKBtd5S7Vc0axYGDv56YaPQuJJovnjMXwKmhgGbuBcpFqYLZRCH2Teg52
	 rHy9xjs/kb6hWGtF8h1HspaaPUc8TKcBPFePf+Tk=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id AC76BA80D00; Tue, 22 Jul 2025 12:09:40 +0200 (CEST)
Date: Tue, 22 Jul 2025 12:09:40 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [EXTERNAL] Re: [PATCH] Cygwin: mkimport: implement AArch64
 +/-4GB relocations
Message-ID: <aH9jZCS92AGUaP-o@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <DB9PR83MB0923E3D187978CF43940B188925DA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aH4NM_WJNC2KHpHT@calimero.vinschen.de>
 <23af2767-7e76-74fd-198f-2abdee7cc73e@jdrake.com>
 <GV4PR83MB0941B168699D42E77A73814F925CA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
 <aH9Pi6bJNDa_Q7V1@calimero.vinschen.de>
 <GV4PR83MB09417042234459A19594C15C925CA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <GV4PR83MB09417042234459A19594C15C925CA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul 22 09:12, Radek Barton via Cygwin-patches wrote:
> Hello.
> 
> Thank you for this insight. So, if I build tcsh using AArch64 Cygwin
> GNU toolchain, I should see if this behaves correctly with debugger?

Yes, that would probably be helpful.  tcsh overwrites the malloc/free
entries of __cygwin_user_data in _cygwin_crt0_common(), which is linked
into the executable.  This occurs after dll_crt0_0, but before dll_crt0_1.

So what you should see is somthing like this:

(gdb) br dll_crt0_0
(gdb) br dll_crt0_1
(gdb) r
Starting program: /bin/tcsh
[New Thread 1832.0x4ac]
[New Thread 1832.0x22d0]

Thread 1 hit Breakpoint 1, dll_crt0_0 ()
[...]
(gdb) p __cygwin_user_data.malloc
$6 = (void *(*)(size_t)) 0x7ffc8504cee9 <malloc>   <== pointing into cygwin1.dll
(gdb) c
Thread 1 hit Breakpoint 2, dll_crt0_1 ()
[...]
(gdb) p __cygwin_user_data.malloc
$6 = (void *(*)(size_t)) 0x100448940 <malloc>      <== pointing into tcsh

Theoretically import_address() is only required to be able to resolve
pointers into the Cygwin DLL itself correctly.  If it can resolve all
variations of import table entries created by gcc for the Cygwin DLL,
it's sufficient.  If other variations exist, but are never emitted by
gcc(*), it would be entirely sufficent if import_address() returns NULL.

tl;dr: As long as it always recognizes

  import_address ((void *) user_data->malloc) == &_sigfe_malloc

we're good.


Corinna

(*) Or clang, but I don't think we can build Cygwin with clang yet anyway
