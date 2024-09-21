Return-Path: <SRS0=GWCD=QT=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [106.153.227.113])
	by sourceware.org (Postfix) with ESMTPS id B6CB03858D35
	for <cygwin-patches@cygwin.com>; Sat, 21 Sep 2024 14:38:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B6CB03858D35
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B6CB03858D35
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.113
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1726929524; cv=none;
	b=t0g5e6aDm93OEm8GEJ+ugi2KCu7IrD+N0BKcXaMh567rwCSUW3cWiIH5c1Nx1af2mxUJOueDnDDvT/7qaFtmXCF7udtcbLTnRk5vfHbkHbi56xJuIBDXefdeh9+0COC1LHqu1GolTj8zq057C9/ZiDnecvvPYmmi4CpINfo/xE0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1726929524; c=relaxed/simple;
	bh=oPopspqZUE1C3t0DSLU5QaMWDO2vgapmnHJj3fcC4eM=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=JDBtYUE4JalVoYxNCQqg/YevggjI/FYwkfyFniUQaTzdLvD51qu7P9SuHbjLpTzhH/mLnSGQZQ9t1eJA/ZvVuOpjMhA5NB/z0G4pJOUx5UGq+4HiKgG5KDZ1LVH7n3ioWZqDCy+9MyGsaXSEC44XnRm+4EfYHoOZ7gM9VqsPcfA=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-e01.mail.nifty.com with ESMTP
          id <20240921143839491.RVZA.87244.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sat, 21 Sep 2024 23:38:39 +0900
Date: Sat, 21 Sep 2024 23:38:38 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v7] Cygwin: pipe: Switch pipe mode to blocking mode by
 default
Message-Id: <20240921233838.6c39da4f31f8872f0a8df785@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1726929519;
 bh=MSEP2jP8JId9G6OXAedOzM3xlwuZi/uh4Nq5MsyHuPc=;
 h=Date:From:To:Subject;
 b=UbFkIoNjDiNEZn+rfY/WDnnEfdYDbSf9IXIlgkmPpsDbwn5Z0Oel9L8GbHaxhdjYHKA+8FKz
 fT2IyEAVOAbEQZt1QIwnJlcjjfF5c+hlUumATO2YIBd1mdOmnlU48CGVMvUQehD3ovaB/AVdes
 U9NneFbW0r817+DA/ClPS1vb2FlWs4seSPD8xR8tOZ8JXq8lP66YAMk8ejcCHhvEJYgSXAtLwy
 e6FiKMf6KcHJDlgkUowwbNL1wz4hJsLTSM35VJ1QbyWjwTRHXHeD2MpP23NdvgJymmuQVpnk/T
 +SAGTsfuZkB778OHV9i0WPVdwAf2yW9vDwty3lIbGJBCzNAw==
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 20 Sep 2024 23:07:53 +0900
Takashi Yano wrote:
> @@ -211,42 +198,51 @@ out:
>    return 0;
>  }
>  
> +extern "C" int swscanf (const wchar_t *, const wchar_t *, ...);
> +
> +static char *
> +get_mtx_name (HANDLE h, bool w, char *name)
> +{
> +  ULONG len;
> +  NTSTATUS status;
> +  tmp_pathbuf tp;
> +  OBJECT_NAME_INFORMATION *ntfn = (OBJECT_NAME_INFORMATION *) tp.w_get ();
> +  DWORD pid;
> +  LONG uniq_id;
> +
> +  status = NtQueryObject (h, ObjectNameInformation, ntfn, 65536, &len);
> +  if (!NT_SUCCESS (status) || !ntfn->Name.Buffer)
> +    return NULL;
> +  ntfn->Name.Buffer[ntfn->Name.Length] = L'\0';

This should be ntfn->Name.Buffer[ntfn->Name.Length / sizeof (WCHAR)] = L'\0';

> +  WCHAR *p = wcschr (ntfn->Name.Buffer, L'-');
> +  if (p == NULL)
> +    return NULL;
> +  if (2 != swscanf (p, L"-%u-pipe-nt-0x%lx", &pid, &uniq_id))
> +    return NULL;
> +  __small_sprintf (name, "cygpipe.%s.mutex.%u-%p",
> +		   w ? "output" : "input", pid, (intptr_t) uniq_id);
> +  return name;
> +}
> +

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
