Return-Path: <SRS0=IhUf=BQ=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id 4095E4BBCD97
	for <cygwin-patches@cygwin.com>; Mon, 16 Mar 2026 09:55:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4095E4BBCD97
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4095E4BBCD97
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773654937; cv=none;
	b=Pyrq/bD+5/F+pdltJFeYxhnOouU56FbeEbVoevAzPpEt+oqKNIrO1r0+yggf+XoIwb8lc+0I10pZGIzpyUjd/3j30ztJpvSIOfWOPJ3hI369PltvVvf8yzVzeTeylQlnQeKSSZEdpL30r/ezUuXktLdNh/wcJYZlW+SMrLMG0QE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773654937; c=relaxed/simple;
	bh=laLYSLCwv1mRwlWlG+4pvhw9/hhPeGng159GPN/eJoc=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=mDrrlxpJ2tMOMcmDXAknuJJOV6FNzWgyJr5r7l/h8A5pub7OeUInuR+3HeC2Cr8xlj6BXECsTiqCPXpxrHASjCnsnQDW8NAEs3kYilfEvBJFEbq1zBioNsGauyOdRPJzfUMv4zIi/tY1Ug5EwUOoay1/7mEEl85S7I/FeelCp3Y=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4095E4BBCD97
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=FoHc1bh6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773654931; x=1774259731;
	i=johannes.schindelin@gmx.de;
	bh=g+A7fBToOg3/BjY4majcG4Yg2AKfMU0GbL+aHyWKL2c=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FoHc1bh6r5LMKnArRDQz5y75XtC5v/pW1zBgJJKv/+FJeEz6Vd7RRRW3soseO/EV
	 01pVBlJAvSWVQhpvQbTr1wfdKeaX6HtBco9ll9A8GI1zWwqAMt2FootB6Eb/Qez1V
	 oNiYmtOx3OSpzCg8lLt4kLiSeQPD6D9O2toIdxr+K/kiHIJnhVx39r01vPDEoSCq2
	 v1225jXsxnlLwWu9cyWT3LYWdZ8zefgIdvEyxHkWt4gQDfbuhJimR7LhMWYgLtHiq
	 uVrRYM8E4AEdaSwYPV4Vayu/hyKZGnbOTC92ulwntFeamqPRCyRTnkPyeTukHHY3Z
	 udKEkuOUKpXgblZlug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0oFz-1veTqB3ZUT-00veGH; Mon, 16
 Mar 2026 10:55:30 +0100
Date: Mon, 16 Mar 2026 10:55:29 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 1/3] Cygwin: pty: Use OpenConsole.exe if available
In-Reply-To: <20260312113923.1528-2-takashi.yano@nifty.ne.jp>
Message-ID: <90f23c8e-cb9c-ad64-8c22-2f5cb3a535e3@gmx.de>
References: <20260312113923.1528-1-takashi.yano@nifty.ne.jp> <20260312113923.1528-2-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ygBMj2Ob4wz8L8oqlZb1SzEuw3LBXMiduvmc+Ri/W7+k7mSgIH/
 EBoVVThv7gZD1TM4SVQjvB/BDkndeiAmQ4hq0NsRHUTu6USVwv8qxzlDkSjexfY9ngDqbTa
 HFir1irUNxyaVtP8Uxr5oMSfG7C9r6rUf318gsHTCCL/Xf40v1xbzo79O2EqUDXh7hBk86U
 r8EWrBSWNy/xPTx58E0eQ==
UI-OutboundReport: notjunk:1;M01:P0:m+kn3A67JDE=;TlOv8aNjiBqWQOvREFmxiYsybjm
 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
 XSdmVgZQTNN
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,KAM_ASCII_DIVIDERS,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Thu, 12 Mar 2026, Takashi Yano wrote:

> This patch replaces legacy conhost.exe with OpenConsole.exe if
> it is available. This enables various new features such as mouse
> support in pseudo console and bug fixes. The legacy conhost has
> problems, e.g. character attributes are mangled or ignored, and
> terminal reports are not passed through. This patch resolve the
> issue by loading /usr/bin/OpenColnsole.exe instead of conhost.exe

I know that Corinna cares about typos in commit messages, so I'd like to
point out that "OpenColnsole" has an extra "l" in it.

> if it is available.

My biggest issue with this patch: There is no opt-out mechanism: No
CYGWIN=3Ddisable_openconsole or MSYS=3Ddisable_openconsole flag. If
/usr/bin/OpenConsole.exe exists and is buggy, or this here patch, the user
is stuck.

My second-biggest issue: The commit message leaves too many legitimate
questions unanswered. It says "various new features such as mouse support"
and "terminal reports are not passed through" without specifics, without
linking to any bug report, and without explaining why reimplementing
`CreatePseudoConsole()` using undocumented NT kernel APIs
(`\Device\ConDrv\Server`) is necessary (vs. just passing the
`OpenConsole.exe` path to the standard `CreatePseudoConsole()` somehow).
The message also doesn't address the maintenance burden of vendoring
Windows Terminal code.

Another concern I have, which is however very easily addressed, is that
this patch does two things for the price of one. It would be better to
separate the CSIc handling from the `OpenConsole.exe` integration. This
would make it possible to fast-track one without the other, and make
reviews of future iterations much easier.

> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Suggested-by: Thomas Wolff <towo@towo.net>
> Reviewed-by:
> ---
>  winsup/cygwin/fhandler/pty.cc           | 218 ++++++++++++++++++++++--
>  winsup/cygwin/local_includes/fhandler.h |   1 +
>  winsup/cygwin/local_includes/tty.h      |   1 +
>  winsup/cygwin/tty.cc                    |   1 +
>  4 files changed, 208 insertions(+), 13 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index 65b10dd62..85d29f1cc 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -34,6 +34,165 @@ details. */
>  #define PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE 0x00020016
>  #endif /* PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE */
> =20
> +/* The source code of following two functions, i.e. create_conhost_hand=
le()
> +   and CreatePseudoConsole_new(), are borrowed from
> +   Microsoft WindowsTerminal project: https://github.com/microsoft/term=
inal/
> +   that is licensed under MIT license. */
> +
> +/* --------------------------------------------------------------------=
=2D-------
> +Copyright (c) Microsoft Corporation. All rights reserved.
> +
> +MIT License
> +
> +Permission is hereby granted, free of charge, to any person obtaining a=
 copy
> +of this software and associated documentation files (the "Software"), t=
o deal
> +in the Software without restriction, including without limitation the r=
ights
> +to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll
> +copies of the Software, and to permit persons to whom the Software is
> +furnished to do so, subject to the following conditions:
> +
> +The above copyright notice and this permission notice shall be included=
 in all
> +copies or substantial portions of the Software.
> +
> +THE SOFTWARE IS PROVIDED *AS IS*, WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
> +IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
> +FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL=
 THE
> +AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> +LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,
> +OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN THE
> +SOFTWARE.
> +-----------------------------------------------------------------------=
=2D---- */
> +
> +static NTSTATUS
> +create_conhost_handle (PHANDLE handle, PCWSTR device_name,
> +		       ACCESS_MASK desired_access, HANDLE parent,
> +		       BOOLEAN inheritable, ULONG open_options)
> +{
> +  ULONG flags =3D OBJ_CASE_INSENSITIVE;
> +  if (inheritable)
> +    flags |=3D OBJ_INHERIT;
> +
> +  UNICODE_STRING name;
> +  RtlInitUnicodeString (&name, device_name);
> +
> +  OBJECT_ATTRIBUTES object_attributes;
> +  InitializeObjectAttributes (&object_attributes, &name, flags, parent,=
 NULL);
> +
> +  IO_STATUS_BLOCK io;
> +  return NtOpenFile (handle, desired_access, &object_attributes, &io,
> +		     FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE,
> +		     open_options);
> +}
> +
> +extern "C" WINBASEAPI HRESULT WINAPI

This should probably not be exported from cygwin1.dll, it is for
internal use only.

> +CreatePseudoConsole_new (COORD size, HANDLE h_input, HANDLE h_output,
> +			 DWORD flags, HPCON *hpcon)
> +{
> +
> +  HANDLE h_con_server, h_con_reference;
> +  NTSTATUS status;
> +  BOOL res;
> +  HANDLE h_read_pipe, h_write_pipe;
> +  BOOL inherit_cursor;
> +  path_conv conhost ("/usr/bin/OpenConsole.exe");

Is it really a good idea to hard-code that path? That would not only
preclude an `OpenConsole.exe` that is in the `PATH` to be used, it also
suggests that you plan on building a Cygwin version of that executable
(because that location should only contain native Cygwin applications and
DLLs).

> +  size_t len;
> +  HANDLE inherited_handles[4];
> +  STARTUPINFOEXW si =3D {0, };
> +  PROCESS_INFORMATION pi;
> +  SIZE_T list_size =3D 0;
> +  LPPROC_THREAD_ATTRIBUTE_LIST attr_list;
> +  HPCON_INTERNAL *hpcon_internal;
> +
> +  status =3D create_conhost_handle (&h_con_server, L"\\Device\\ConDrv\\=
Server",
> +				  GENERIC_ALL, NULL, TRUE, 0);
> +  if (!NT_SUCCESS (status))
> +    goto cleanup;
> +  status =3D create_conhost_handle (&h_con_reference, L"\\Reference",
> +				  GENERIC_READ | GENERIC_WRITE | SYNCHRONIZE,
> +				  h_con_server, FALSE,
> +				  FILE_SYNCHRONOUS_IO_NONALERT);
> +  if (!NT_SUCCESS (status))
> +    goto cleanup_h_con_server;
> +
> +  res =3D CreatePipe (&h_read_pipe, &h_write_pipe, &sec_none, 0);
> +  if (!res)
> +    goto cleanup_h_con_reference;
> +  res =3D SetHandleInformation (h_read_pipe,
> +			      HANDLE_FLAG_INHERIT, HANDLE_FLAG_INHERIT);
> +  if (!res)
> +    goto cleanup_pipe;
> +
> +  inherit_cursor =3D (flags & PSEUDOCONSOLE_INHERIT_CURSOR) ? TRUE : FA=
LSE;
> +
> +  WCHAR cmd[MAX_PATH];
> +  len =3D conhost.get_wide_win32_path_len ();
> +  conhost.get_wide_win32_path (cmd);
> +  __small_swprintf (cmd + len,
> +		    L" --headless %W"
> +		    "--width %d --height %d --signal 0x%x --server 0x%x",
> +		    inherit_cursor ? L"--inheritcursor " : L"",
> +		    size.X, size.Y, h_read_pipe, h_con_server);
> +
> +  si.StartupInfo.cb =3D sizeof (STARTUPINFOEXW);
> +  si.StartupInfo.hStdInput =3D h_input;
> +  si.StartupInfo.hStdOutput =3D h_output;
> +  si.StartupInfo.hStdError =3D h_output;
> +  si.StartupInfo.dwFlags |=3D STARTF_USESTDHANDLES;
> +
> +  inherited_handles[0] =3D h_con_server;
> +  inherited_handles[1] =3D h_input;
> +  inherited_handles[2] =3D h_output;
> +  inherited_handles[3] =3D h_read_pipe;
> +
> +  InitializeProcThreadAttributeList (NULL, 1, 0, &list_size);

This requires a corresponding `DeleteProcThreadAttributeList()` call.

> +  attr_list =3D
> +    (LPPROC_THREAD_ATTRIBUTE_LIST) HeapAlloc (GetProcessHeap (), 0, lis=
t_size);
> +  if (!attr_list)
> +    goto cleanup_pipe;
> +
> +  si.lpAttributeList =3D attr_list;
> +  InitializeProcThreadAttributeList (si.lpAttributeList, 1, 0, &list_si=
ze);
> +  UpdateProcThreadAttribute (si.lpAttributeList, 0,
> +			     PROC_THREAD_ATTRIBUTE_HANDLE_LIST,
> +			     inherited_handles, sizeof (inherited_handles),
> +			     NULL, NULL);
> +
> +
> +  res =3D CreateProcessW (NULL, cmd, NULL, NULL,
> +			TRUE, EXTENDED_STARTUPINFO_PRESENT,
> +			NULL, NULL, &si.StartupInfo, &pi);
> +  if (!res)
> +    goto cleanup_heap;
> +
> +  hpcon_internal =3D (HPCON_INTERNAL *)
> +    HeapAlloc (GetProcessHeap (), 0, sizeof (HPCON_INTERNAL));
> +  if (!hpcon_internal)
> +    goto cleanup_heap;
> +  hpcon_internal->hWritePipe =3D h_write_pipe;
> +  hpcon_internal->hConDrvReference =3D h_con_reference;
> +  hpcon_internal->hConHostProcess =3D pi.hProcess;
> +  *hpcon =3D (HPCON) hpcon_internal;
> +
> +  HeapFree (GetProcessHeap(), 0, attr_list);
> +  CloseHandle (h_con_server);
> +  CloseHandle (pi.hThread);

I see `h_read_pipe` being closed in the failure mode, but not in the
success one.

`h_write_pipe` is stored in `*h_pcon`, so it becomes the caller's
responsibility. And `h_con_server`/`pi.hThread` are closed properly, but I
don't see where `h_read_pipe` is handled properly.

> +
> +  return S_OK;
> +
> +cleanup_heap:
> +  HeapFree (GetProcessHeap(), 0, attr_list);
> +cleanup_pipe:
> +  CloseHandle (h_read_pipe);
> +  CloseHandle (h_write_pipe);
> +cleanup_h_con_reference:
> +  CloseHandle (h_con_reference);
> +cleanup_h_con_server:
> +  CloseHandle (h_con_server);
> +cleanup:
> +  return E_FAIL;
> +}
> +
> +
>  extern "C" int sscanf (const char *, const char *, ...);
> =20
>  #define close_maybe(h) \
> @@ -2176,13 +2335,16 @@ fhandler_pty_master::write (const void *ptr, siz=
e_t len)
> =20
>    push_process_state process_state (PID_TTYOU);
> =20
> -  if (get_ttyp ()->pcon_start)
> +  int pcon_start_mode =3D
> +    get_ttyp ()->pcon_start ? 1 : (get_ttyp ()->pcon_start_csi_c ? 2 : =
0);
> +  if (pcon_start_mode)

Does this need to be made thread-safe in case `write()` is called
simultaneously on two separate processor cores?

>      { /* Reaches here when pseudo console initialization is on going. *=
/
>        /* Pseudo condole support uses "CSI6n" to get cursor position.
>  	 If the reply for "CSI6n" is divided into multiple writes,
>  	 pseudo console sometimes does not recognize it.  Therefore,
>  	 put them together into wpbuf and write all at once. */
> -      static const int wpbuf_len =3D strlen ("\033[32768;32868R");
> +      /* Do the same for CSIc. */
> +      static const int wpbuf_len =3D 64; /* Enough space for CSIc respo=
nse */
>        static char wpbuf[wpbuf_len];
>        static int ixput =3D 0;
>        static int state =3D 0;
> @@ -2214,7 +2376,15 @@ fhandler_pty_master::write (const void *ptr, size=
_t len)
>  	  else
>  	    line_edit (p + i, 1, ti, &ret);
>  	  if (state =3D=3D 1 && p[i] =3D=3D 'R')
> -	    state =3D 2;
> +	    {
> +	      get_ttyp ()->pcon_start =3D false;
> +	      state =3D 2;
> +	    }
> +	  if (state =3D=3D 1 && p[i] =3D=3D 'c')
> +	    {
> +	      get_ttyp ()->pcon_start_csi_c =3D false;
> +	      state =3D 2;
> +	    }
>  	  if (state =3D=3D 2)
>  	    {
>  	      /* req_xfer_input is true if "ESC[6n" was sent just for
> @@ -2227,13 +2397,13 @@ fhandler_pty_master::write (const void *ptr, siz=
e_t len)
>  	      ixput =3D 0;
>  	      state =3D 0;
>  	      get_ttyp ()->req_xfer_input =3D false;
> -	      get_ttyp ()->pcon_start =3D false;
> -	      break;
> +	      if (!get_ttyp ()->pcon_start && !get_ttyp ()->pcon_start_csi_c)
> +		break;
>  	    }
>  	}
>        ReleaseMutex (input_mutex);
> =20
> -      if (!get_ttyp ()->pcon_start)
> +      if (pcon_start_mode =3D=3D 1 && !get_ttyp ()->pcon_start)
>  	{ /* Pseudo console initialization has been done in above code. */
>  	  pinfo pp (get_ttyp ()->pcon_start_pid);
>  	  if (get_ttyp ()->switch_to_nat_pipe
> @@ -2683,8 +2853,10 @@ pty_master_thread (VOID *arg)
>  #define CONSOLE_HELPER "\\bin\\cygwin-console-helper.exe"
>  #define CONSOLE_HELPER_LEN (sizeof (CONSOLE_HELPER) - 1)
> =20
> -inline static DWORD
> -workarounds_for_pseudo_console_output (char *outbuf, DWORD rlen)
> +DWORD
> +fhandler_pty_master::workarounds_for_pseudo_console_output (char *outbu=
f,
> +							    DWORD rlen,
> +							    tty *ttyp)
>  {
>    int state =3D 0;
>    int start_at =3D 0;
> @@ -2693,6 +2865,7 @@ workarounds_for_pseudo_console_output (char *outbu=
f, DWORD rlen)
>    int arg =3D 0;
>    bool saw_greater_than_sign =3D false;
>    bool saw_question_mark =3D false;
> +  static bool in_pcon_start =3D false;
>    for (DWORD i=3D0; i<rlen; i++)
>      if (state =3D=3D 0 && outbuf[i] =3D=3D '\033')
>        {
> @@ -2774,8 +2947,21 @@ workarounds_for_pseudo_console_output (char *outb=
uf, DWORD rlen)
>  	    start_at =3D i;
>  	    state =3D 1;
>  	  }
> +	else if (arg =3D=3D 6 && outbuf[i] =3D=3D 'n' && ttyp->pcon_start)
> +	  {
> +	    in_pcon_start =3D true;

Should this variable be reset in error paths below? This might be
_particularly_ nasty to debug because `in_pcon_start` is `static` and will
therefore persist indefinitely.

> +	    state =3D 0;
> +	  }
> +	else if (arg =3D=3D 0 && outbuf[i] =3D=3D 'c' && in_pcon_start)
> +	  {
> +	    ttyp->pcon_start_csi_c =3D true;
> +	    state =3D 0;
> +	  }
>  	else
> -	  state =3D 0;
> +	  {
> +	    in_pcon_start =3D false;
> +	    state =3D 0;
> +	  }
> =20
>  	if (state < 2)
>  	  {
> @@ -2873,7 +3059,8 @@ fhandler_pty_master::pty_master_fwd_thread (const =
master_fwd_thread_param_t *p)
>        char *ptr =3D outbuf;
>        if (p->ttyp->pcon_activated)
>  	{
> -	  wlen =3D rlen =3D workarounds_for_pseudo_console_output (outbuf, rle=
n);
> +	  wlen =3D rlen =3D
> +	    workarounds_for_pseudo_console_output (outbuf, rlen, p->ttyp);
> =20
>  	  if (p->ttyp->term_code_page !=3D CP_UTF8)
>  	    {
> @@ -3373,9 +3560,14 @@ fhandler_pty_slave::setup_pseudoconsole ()
>        const DWORD inherit_cursor =3D 1;
>        hpcon =3D NULL;
>        SetLastError (ERROR_SUCCESS);
> -      HRESULT res =3D CreatePseudoConsole (size, get_handle_nat (),
> -					 get_output_handle_nat (),
> -					 inherit_cursor, &hpcon);
> +      /* Try OpenConsole.exe before conhost.exe */
> +      HRESULT res =3D CreatePseudoConsole_new (size, get_handle_nat (),
> +					     get_output_handle_nat (),
> +					     inherit_cursor, &hpcon);
> +      if (res !=3D S_OK) /* Fallback to legacy conhost.exe */
> +        res =3D CreatePseudoConsole (size, get_handle_nat (),
> +				   get_output_handle_nat (),
> +				   inherit_cursor, &hpcon);
>        if (res !=3D S_OK || GetLastError () =3D=3D ERROR_PROC_NOT_FOUND)
>  	{
>  	  if (res !=3D S_OK)
> diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/loc=
al_includes/fhandler.h
> index 16f55b4f7..dd907c4ba 100644
> --- a/winsup/cygwin/local_includes/fhandler.h
> +++ b/winsup/cygwin/local_includes/fhandler.h
> @@ -2572,6 +2572,7 @@ public:
> =20
>    static DWORD pty_master_thread (const master_thread_param_t *p);
>    static DWORD pty_master_fwd_thread (const master_fwd_thread_param_t *=
p);
> +  static DWORD workarounds_for_pseudo_console_output (char *, DWORD, tt=
y *);
>    int process_slave_output (char *buf, size_t len, int pktmode_on);
>    void doecho (const void *str, DWORD len);
>    int accept_input ();
> diff --git a/winsup/cygwin/local_includes/tty.h b/winsup/cygwin/local_in=
cludes/tty.h
> index 9485e24c5..163b38222 100644
> --- a/winsup/cygwin/local_includes/tty.h
> +++ b/winsup/cygwin/local_includes/tty.h
> @@ -120,6 +120,7 @@ private:
>    bool pcon_activated;
>    bool pcon_start;
>    pid_t pcon_start_pid;
> +  bool pcon_start_csi_c;
>    bool switch_to_nat_pipe;
>    DWORD nat_pipe_owner_pid;
>    UINT term_code_page;
> diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
> index acc21c0ca..35853186a 100644
> --- a/winsup/cygwin/tty.cc
> +++ b/winsup/cygwin/tty.cc
> @@ -243,6 +243,7 @@ tty::init ()
>    fwd_not_empty =3D false;
>    pcon_start =3D false;
>    pcon_start_pid =3D 0;
> +  pcon_start_csi_c =3D false;
>    pcon_cap_checked =3D false;
>    has_csi6n =3D false;
>    need_invisible_console =3D false;
> --=20
> 2.51.0

I'm really excited to learn what benefits this `OpenConsole.exe`
integration brings in the next iteration of this commit message.

Thank you!
Johannes
