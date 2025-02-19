Return-Path: <SRS0=eoJo=VK=gmail.com=lionelcons1972@sourceware.org>
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by sourceware.org (Postfix) with ESMTPS id 34BCF3858C42
	for <cygwin-patches@cygwin.com>; Wed, 19 Feb 2025 00:12:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 34BCF3858C42
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 34BCF3858C42
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2a00:1450:4864:20::530
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1739923920; cv=none;
	b=rrxcF286960glMQ+coFSrpkiafyapiHFinOMJG6lBfGCkkH60zYbOAWe9cb/9Yege2NPNOjP3toCi6niY0BI69iuWrd3N0/EHjEQ83+krqi3h1cGgQlzsyFNR/ZtJjuO/qu4dJ8rh7DmXt2NKlvZtQy8r8Jkz5V15wP20icANcs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1739923920; c=relaxed/simple;
	bh=B1x89T1FJbBJHalyFUxUSFeVgqJqLCSCfJZEfAKICpw=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=V7ZBD6Be6J9vtnQSdsLCOf5zStliWVra2loteKgApP+Coq6iS4sJvyC9Usfa0pl291pkfK4mMYuKu4pjAMyOKhc/vdi+Fe6+f9mIFEib5k7phcsk1c7QhMCWCLVvb6Lb31xQ0QblDtMf16KdFZXGXpOujlasnKwszBLfJGzp3oE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 34BCF3858C42
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Tgd2msfT
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5e0505275b7so5135464a12.3
        for <cygwin-patches@cygwin.com>; Tue, 18 Feb 2025 16:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739923918; x=1740528718; darn=cygwin.com;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JtHX3B7niBbbPgJRMSGi9VFLxelK7fvf2FpkPdhNW3I=;
        b=Tgd2msfTAU62YQfsx8NnV+kta4HUOJtPxBW+DiUJRNm3jN5toy5dXuvGpYRVp83eP0
         jRP8IabuLM84c9VWzUg3cLxfMBXXK04mNO6zAPG0lcXIXhsmJIxGKBtOTWE4fgzESy9Z
         qK4tUlPX3zekQszN0rK2iN1i12EhwLH/qov4iQUY7lWqXCHwXUpa/p2E99353YbBTXYt
         nyF6WC72Kc0gfqbvUuZaDMFPkUl+pOriSDxavebQn36VGWSk7KG+Fu8vikDAyhy/eqwC
         XYfLlC7uwM3zZOVFkoG82IWSkyz9O+ngBb72Dzs1n2ajGXsmYbTjDaKDgeMRMrl8Xty8
         GVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739923918; x=1740528718;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JtHX3B7niBbbPgJRMSGi9VFLxelK7fvf2FpkPdhNW3I=;
        b=cQwIPdvv7WVBEbkZEh1TT6LTPsV7zaFUcOGcxt6zayrWpBoKqMFhJ2yd9p+YUD8QuB
         9nthb7oO3CFrhe/aa4MNjhEtao2028rEUox8swazbicUSq2nyoMMD/4+qBHcdiB/xhRn
         +xFJsppSAW6YQ2XTwfp9E5e17ZlgrPGeZnSORYmTVKYDQaDHls//Qxd3Oy1WOtJw5HfE
         keJJ2Ig9FcBIGJ+OwvPleUk0F2qhiRvcWVSTEFyDFYhGfbVLozNMPWsrwyo9Mbx1xLR6
         nuWpimDDzrFjeG4qYypSHH41l0/p3vgoOfeM2RxclX6DBilWa79Ul370dgIJEEQN/kuz
         5K7g==
X-Gm-Message-State: AOJu0YxgcrDKJY9XOYnsdHRLzXn2gLrkvg4087vFp+1jAH2zz7A/Eikk
	JscrGf7wphscY3DSyxQKkUE/kUyUvlUXtKif9oTh9J+dHXmCeDD0NkGnxjYGnHR2uJ3TKMX/LGw
	YS8gmiU6zCrP2grU2HC3eH7S4z51u0Eew
X-Gm-Gg: ASbGncvETkA9TajEndGrMHStqTRisP3DtfIgnnnyKYwzaBJ8BxbfkM5xyySYnsibPpp
	U5B4CkU+P413WKb6Z/m1Fjgfoptudgid3vQPJAb4Mji2X7Jo/q89zeu9XA7WMxfh5p+N46Lcdig
	==
X-Google-Smtp-Source: AGHT+IGM87deFv9k6EO5fB3hJXivHgiu+/w4PHBdUSAQi9ioXm4eWSAoU4rQYHst1DdHJjmNJmfQX3LQ+WxpcfLUIvw=
X-Received: by 2002:a05:6402:2347:b0:5e0:82a0:50dc with SMTP id
 4fb4d7f45d1cf-5e089f2ab4cmr1531030a12.28.1739923917782; Tue, 18 Feb 2025
 16:11:57 -0800 (PST)
MIME-Version: 1.0
References: <8dd3b5f5-004c-53ee-53ea-6428de5dd597@jdrake.com>
In-Reply-To: <8dd3b5f5-004c-53ee-53ea-6428de5dd597@jdrake.com>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Wed, 19 Feb 2025 01:11:21 +0100
X-Gm-Features: AWEUYZlO2r143-EWb8iM6LZtVcWZNAVYrWlVZnAfipzlTIz4N_2oh4eHgkZgqKU
Message-ID: <CAPJSo4XGXfOPBw+1WAYYjhQDU64SXzfVfh7goSDDepUADWZrEg@mail.gmail.com>
Subject: Re: [PATCH] Cygwin: include network mounts in cygdrive_getmntent.
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Does this patch cover global mounts, i.e. SMB mounted by user
LocalSystem on a driver letter are visible to ALL users. Local users
logons can override the same drive letter via per-user net use

Example:
LocalSystem mounts H: to \\homeserver\disk4\users, this is visible to
all users in a system
User "lionel" mounts H: to \\lionelsserver\data\homedir, this is
visible to the current Logon session

Lionel

On Tue, 18 Feb 2025 at 22:25, Jeremy Drake via Cygwin-patches
<cygwin-patches@cygwin.com> wrote:
>
> After migrating from GetLogicalDrives to Find(First|Next)VolumeW, mapped
> network drives no longer showed up in getmntent output.  To fix that,
> also iterate GetLogicalDriveStringsW when builing dos_drive_mappings,
> and merge with volume mounts (skipping any volume mounts that are just
> mounted on the root of a drive, and replacing the dos mounts in the
> mapping for a volume which is mounted on both a drive root and a
> directory).
>
> Fixes: 04a5b072940cc ("Cygwin: expose all windows volume mount points.")
> Addresses: https://cygwin.com/pipermail/cygwin/2025-February/257384.html
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> ---
>
> This was generated on top of the patch
> https://cygwin.com/pipermail/cygwin-patches/2025q1/013390.html but should
> be able to be applied without it.
>
>  winsup/cygwin/mount.cc | 145 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 113 insertions(+), 32 deletions(-)
>
> diff --git a/winsup/cygwin/mount.cc b/winsup/cygwin/mount.cc
> index a3d9e5bd0f..68414f13af 100644
> --- a/winsup/cygwin/mount.cc
> +++ b/winsup/cygwin/mount.cc
> @@ -1995,6 +1995,40 @@ endmntent (FILE *)
>    return 1;
>  }
>
> +static bool
> +resolve_dos_device (const wchar_t *dosname, wchar_t *devpath)
> +{
> +  if (QueryDosDeviceW (dosname, devpath, NT_MAX_PATH))
> +    {
> +      /* The DOS drive mapping can be another symbolic link.  If so,
> +        the mapping won't work since the section name is the name
> +        after resolving all symlinks.  Resolve symlinks here, too. */
> +      for (int syml_cnt = 0; syml_cnt < SYMLOOP_MAX; ++syml_cnt)
> +       {
> +         UNICODE_STRING upath;
> +         OBJECT_ATTRIBUTES attr;
> +         NTSTATUS status;
> +         HANDLE h;
> +
> +         RtlInitUnicodeString (&upath, devpath);
> +         InitializeObjectAttributes (&attr, &upath, OBJ_CASE_INSENSITIVE,
> +                                     NULL, NULL);
> +         status = NtOpenSymbolicLinkObject (&h, SYMBOLIC_LINK_QUERY, &attr);
> +         if (!NT_SUCCESS (status))
> +           break;
> +         RtlInitEmptyUnicodeString (&upath, devpath, (NT_MAX_PATH - 1)
> +                                                     * sizeof (WCHAR));
> +         status = NtQuerySymbolicLinkObject (h, &upath, NULL);
> +         NtClose (h);
> +         if (!NT_SUCCESS (status))
> +           break;
> +         devpath[upath.Length / sizeof (WCHAR)] = L'\0';
> +       }
> +      return true;
> +    }
> +  return false;
> +}
> +
>  dos_drive_mappings::dos_drive_mappings ()
>  : mappings(0)
>  , cur_mapping(0)
> @@ -2004,6 +2038,44 @@ dos_drive_mappings::dos_drive_mappings ()
>    wchar_t vol[64]; /* Long enough for Volume GUID string */
>    wchar_t *devpath = tp.w_get ();
>    wchar_t *mounts = tp.w_get ();
> +  mapping **nextm = &mappings;
> +  mapping *endfirstloop = NULL;
> +  DWORD len;
> +
> +  /* Iterate over all drive letters, fetch the DOS device path */
> +  if (!(len = GetLogicalDriveStringsW (NT_MAX_PATH - 1, mounts)) ||
> +      len >= NT_MAX_PATH)
> +    debug_printf ("GetLogicalDriveStringsW, %E");
> +  else {
> +    for (wchar_t *mount = mounts; *mount; mount += len + 2)
> +      {
> +       len = wcslen (mount);
> +       mount[--len] = L'\0'; /* Drop trailing backslash */
> +       if (resolve_dos_device (mount, devpath))
> +         {
> +           mapping *m = new mapping ();
> +           if (m)
> +             {
> +               m->dos.path = wcsdup (mount);
> +               m->ntdevpath = wcsdup (devpath);
> +               if (!m->dos.path || !m->ntdevpath)
> +                 {
> +                   free (m->dos.path);
> +                   free (m->ntdevpath);
> +                   delete m;
> +                   continue;
> +                 }
> +               m->dos.len = len;
> +               m->ntlen = wcslen (m->ntdevpath);
> +               *nextm = endfirstloop = m;
> +               nextm = &m->next;
> +             }
> +         }
> +       else
> +         debug_printf ("Unable to determine the native mapping for %ls "
> +                       "(error %E)", mount);
> +      }
> +  }
>
>    /* Iterate over all volumes, fetch the list of DOS paths the volume is
>       mounted to. */
> @@ -2011,43 +2083,22 @@ dos_drive_mappings::dos_drive_mappings ()
>    if (sh == INVALID_HANDLE_VALUE)
>      debug_printf ("FindFirstVolumeW, %E");
>    else {
> -    mapping **nextm = &mappings;
>      do
>        {
> -       /* Skip drives which are not mounted. */
> -       DWORD len;
> +       /* Skip volumes which are not mounted. */
>         if (!GetVolumePathNamesForVolumeNameW (vol, mounts, NT_MAX_PATH, &len)
>             || mounts[0] == L'\0')
>           continue;
> +       /* Skip volumes which are only mounted to the root of a drive letter:
> +          they were handled in the loop above */
> +       if (len == 5 && mounts[1] == L':' && mounts[2] == L'\\' && !mounts[3])
> +         continue;
> +
>         *wcsrchr (vol, L'\\') = L'\0';
> -       if (QueryDosDeviceW (vol + 4, devpath, NT_MAX_PATH))
> +       if (resolve_dos_device (vol + 4, devpath))
>           {
> -           /* The DOS drive mapping can be another symbolic link.  If so,
> -              the mapping won't work since the section name is the name
> -              after resolving all symlinks.  Resolve symlinks here, too. */
> -           for (int syml_cnt = 0; syml_cnt < SYMLOOP_MAX; ++syml_cnt)
> -             {
> -               UNICODE_STRING upath;
> -               OBJECT_ATTRIBUTES attr;
> -               NTSTATUS status;
> -               HANDLE h;
> -
> -               RtlInitUnicodeString (&upath, devpath);
> -               InitializeObjectAttributes (&attr, &upath,
> -                                           OBJ_CASE_INSENSITIVE, NULL, NULL);
> -               status = NtOpenSymbolicLinkObject (&h, SYMBOLIC_LINK_QUERY,
> -                                                  &attr);
> -               if (!NT_SUCCESS (status))
> -                 break;
> -               RtlInitEmptyUnicodeString (&upath, devpath, (NT_MAX_PATH - 1)
> -                                                           * sizeof (WCHAR));
> -               status = NtQuerySymbolicLinkObject (h, &upath, NULL);
> -               NtClose (h);
> -               if (!NT_SUCCESS (status))
> -                 break;
> -               devpath[upath.Length / sizeof (WCHAR)] = L'\0';
> -             }
>             mapping *m = new mapping ();
> +           bool hadrootmount = false;
>             if (m)
>               {
>                 /* store mount point list */
> @@ -2072,15 +2123,45 @@ dos_drive_mappings::dos_drive_mappings ()
>                     dos->path = mount;
>                     dos->len = wcslen (dos->path);
>                     dos->path[--dos->len] = L'\0'; /* Drop trailing backslash */
> +                   if (dos->len == 2 && dos->path[1] == L':')
> +                     hadrootmount = true;
>                   }
>                 m->ntlen = wcslen (m->ntdevpath);
> -               *nextm = m;
> -               nextm = &m->next;
> +               if (hadrootmount)
> +               {
> +                 /* This device has already been added to the mappings list
> +                    in the first loop above, but with only the drive root
> +                    mount.  Find that entry and replace it with the complete
> +                    list of mounts. */
> +                 hadrootmount = false;
> +                 for (mapping *m2 = mappings;
> +                      endfirstloop && m2 != endfirstloop->next;
> +                      m2 = m2->next)
> +                   {
> +                     if (m->ntlen == m2->ntlen &&
> +                         !wcscmp (m->ntdevpath, m2->ntdevpath))
> +                       {
> +                         free (m2->dos.path);
> +                         m2->dos.next = m->dos.next;
> +                         m2->dos.path = m->dos.path;
> +                         m2->dos.len = m->dos.len;
> +                         free (m->ntdevpath);
> +                         delete m;
> +                         hadrootmount = true;
> +                         break;
> +                       }
> +                   }
> +               }
> +               if (!hadrootmount)
> +                 {
> +                   *nextm = m;
> +                   nextm = &m->next;
> +                 }
>               }
>           }
>         else
>           debug_printf ("Unable to determine the native mapping for %ls "
> -                       "(error %u)", vol, GetLastError ());
> +                       "(error %E)", vol);
>        }
>      while (FindNextVolumeW (sh, vol, 64));
>      FindVolumeClose (sh);
> --
> 2.48.1.windows.1
>


-- 
Lionel
