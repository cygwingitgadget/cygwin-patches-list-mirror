Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 2C0163858D20; Tue,  5 Mar 2024 16:54:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2C0163858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1709657661;
	bh=cg1VgsQQUi00PLhlw8U53N1e06A2ux7xeY4zgvMwmvw=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=S71NPNBOkliXCcER9yrpPUrmPATxgdxdR/NIKzLx7W0gOY0d9VdVQxfBVvwTXR2Lu
	 Fd7yIitzkguXMYcOh42QO42cMKQc1frwHq6R0wXgc28ScDBwK/UWgPvwi2H1bZ5A8Y
	 wx8K4jrr1LagWSENOA+xt5T1QjGH++DpEhVY5BUw=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 61331A80CF5; Tue,  5 Mar 2024 17:54:19 +0100 (CET)
Date: Tue, 5 Mar 2024 17:54:19 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Give up to use query_hdl for non-cygwin
 apps.
Message-ID: <ZedOO5gM1xApOb3A@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240305234753.b484e79322961aba9f8c9979@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Mar  5 23:47, Takashi Yano wrote:
> On Tue, 5 Mar 2024 11:14:46 +0100
> Corinna Vinschen wrote:
> > This doesn't affect your patch, but while looking into this, what
> > strikes me as weird is that fhandler_pipe::temporary_query_hdl() calls
> > NtQueryObject() and assembles the pipe name via swscanf() every time it
> > is called.
> > 
> > Wouldn't it make sense to store the name in the fhandler's
> > path_conv::wide_path/uni_path at creation time instead?
> > The wide_path member is not used at all in pipes, ostensibly.
> 
> Is the patch attached as you intended?

Yes, but it looks like it misses a few potential simplifications:

> diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
> index c877d89d7..0611dd1c3 100644
> --- a/winsup/cygwin/fhandler/pipe.cc
> +++ b/winsup/cygwin/fhandler/pipe.cc
> @@ -93,6 +93,19 @@ fhandler_pipe::init (HANDLE f, DWORD a, mode_t mode, int64_t uniq_id)
>         even with FILE_SYNCHRONOUS_IO_NONALERT. */
>      set_pipe_non_blocking (get_device () == FH_PIPER ?
>  			   true : is_nonblocking ());
> +
> +  /* Store pipe name to path_conv pc for query_hdl check */
> +  if (get_dev () == FH_PIPEW)
> +    {
> +      ULONG len;
> +      tmp_pathbuf tp;
> +      OBJECT_NAME_INFORMATION *ntfn = (OBJECT_NAME_INFORMATION *) tp.w_get ();
> +      NTSTATUS status = NtQueryObject (f, ObjectNameInformation, ntfn,
> +				       65536, &len);
> +      if (NT_SUCCESS (status) && ntfn->Name.Buffer)
> +	pc.set_nt_native_path (&ntfn->Name);

We don't have to call NtQueryObject.  The name is created in nt_create()
and we know the unique id, so the name is

  "%S%S-%u-pipe-nt-%p", &ro_u_ntfs, &cygheap->installation_key,
  			GetCurrentProcessId (), unique_id);

Do you think it's cheaper to call NtQueryObject()?  If so, no worries,
but NtQueryObject() has to call into the kernel, while just creating
the name by ourselves doesn't.

> @@ -1149,6 +1162,9 @@ fhandler_pipe::temporary_query_hdl ()
>    tmp_pathbuf tp;
>    OBJECT_NAME_INFORMATION *ntfn = (OBJECT_NAME_INFORMATION *) tp.w_get ();
>  
> +  UNICODE_STRING *name = pc.get_nt_native_path (NULL);
> +  name->Buffer[name->Length / sizeof (WCHAR)] = L'\0';

The string returned by get_nt_native_path() is always NUL-terminated.

>    /* Try process handle opened and pipe handle value cached first
>       in order to reduce overhead. */
>    if (query_hdl_proc && query_hdl_value)
> @@ -1161,14 +1177,7 @@ fhandler_pipe::temporary_query_hdl ()
>        status = NtQueryObject (h, ObjectNameInformation, ntfn, 65536, &len);
>        if (!NT_SUCCESS (status) || !ntfn->Name.Buffer)
>  	goto hdl_err;
> -      ntfn->Name.Buffer[ntfn->Name.Length / sizeof (WCHAR)] = L'\0';
> -      uint64_t key;
> -      DWORD pid;
> -      LONG id;
> -      if (swscanf (ntfn->Name.Buffer,
> -		   L"\\Device\\NamedPipe\\%llx-%u-pipe-nt-0x%x",
> -		   &key, &pid, &id) == 3 &&
> -	  key == pipename_key && pid == pipename_pid && id == pipename_id)
> +      if (RtlEqualUnicodeString (name, &ntfn->Name, FALSE))
>  	return h;
>  hdl_err:
>        CloseHandle (h);
> @@ -1178,19 +1187,9 @@ cache_err:
>        query_hdl_value = NULL;
>      }
>  
> -  status = NtQueryObject (get_handle (), ObjectNameInformation, ntfn,
> -			  65536, &len);
> -  if (!NT_SUCCESS (status) || !ntfn->Name.Buffer)
> +  if (name->Length == 0 || name->Buffer == NULL)
>      return NULL; /* Non cygwin pipe? */
> -  WCHAR name[MAX_PATH];
> -  int namelen = min (ntfn->Name.Length / sizeof (WCHAR), MAX_PATH-1);
> -  memcpy (name, ntfn->Name.Buffer, namelen * sizeof (WCHAR));
> -  name[namelen] = L'\0';
> -  if (swscanf (name, L"\\Device\\NamedPipe\\%llx-%u-pipe-nt-0x%x",
> -	       &pipename_key, &pipename_pid, &pipename_id) != 3)
> -    return NULL; /* Non cygwin pipe? */
> -
> -  return get_query_hdl_per_process (name, ntfn); /* Since Win8 */
> +  return get_query_hdl_per_process (name->Buffer, ntfn); /* Since Win8 */

Given the name is stored in the fhandler, get_query_hdl_per_process()
doesn't need it as argument, and get_query_hdl_per_process() can just
call RtlCompareUnicodeString() instead of adding a \0 and calling
wcscmp().


Thanks,
Corinna

