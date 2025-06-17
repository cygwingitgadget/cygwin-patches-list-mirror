Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 03A773852FE7; Tue, 17 Jun 2025 09:42:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 03A773852FE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750153354;
	bh=gC+JCeyAEaNR3bPefWDKYMQsLThzUbSV4qiWBcUD1rs=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=rQ0l2iddtZCK692G/OvDLno4FlDpeHTzwhRcKaZMpWFl3pGDgm7VLn4R7bFp5NOUd
	 vvLzvto/bnoPlwqFxMaoO5e0Er7eCHmSpbeZSXqIq915vPsZRg1ltX07YD0sbJlikA
	 +X9CR+IVfKOFiQMWXwbwbh2SQiTiUytQvEnhu6pg=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id DCE18A80961; Tue, 17 Jun 2025 11:42:31 +0200 (CEST)
Date: Tue, 17 Jun 2025 11:42:31 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [RFC PATCH 2/3] Cygwin: hook posix_spawn/posix_spawnp
Message-ID: <aFE4hznx51Xw_aNF@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <610f9534-b03b-a495-d046-6f09f7a077db@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <610f9534-b03b-a495-d046-6f09f7a077db@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On May 29 10:58, Jeremy Drake via Cygwin-patches wrote:
> This will allow checking for and optimizing cases that can easily be
> implemented using ch_spawn instead of using a full fork/exec.
> ---
>  winsup/cygwin/cygwin.din |  4 +--
>  winsup/cygwin/spawn.cc   | 70 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 72 insertions(+), 2 deletions(-)
> 
> --- a/winsup/cygwin/spawn.cc
> +++ b/winsup/cygwin/spawn.cc
> @@ -1376,3 +1378,71 @@ __posix_spawn_execvpe (const char *path, char * const *argv, char *const *envp,
>    __posix_spawn_sem_release (sem, errno);
>    return -1;
>  }
> +
> +/* HACK: duplicate some structs from newlib/libc/posix/posix_spawn.c */
> +struct __posix_spawn_file_actions {
> +  STAILQ_HEAD(, __posix_spawn_file_actions_entry) fa_list;
> +};
> +
> +typedef struct __posix_spawn_file_actions_entry {
> +  STAILQ_ENTRY(__posix_spawn_file_actions_entry) fae_list;
> +  enum {
> +    FAE_OPEN,
> +    FAE_DUP2,
> +    FAE_CLOSE,
> +    FAE_CHDIR,
> +    FAE_FCHDIR
> +  } fae_action;
> +
> +  int fae_fildes;
> +  union {
> +    struct {
> +      char *path;
> +#define fae_path	fae_data.open.path
> +      int oflag;
> +#define fae_oflag	fae_data.open.oflag
> +      mode_t mode;
> +#define fae_mode	fae_data.open.mode
> +    } open;
> +    struct {
> +      int newfildes;
> +#define fae_newfildes	fae_data.dup2.newfildes
> +    } dup2;
> +    char *dir;
> +#define fae_dir		fae_data.dir
> +    int dirfd;
> +#define fae_dirfd		fae_data.dirfd
> +  } fae_data;
> +} posix_spawn_file_actions_entry_t;

That would be better defined in a common newlib header.


Thanks,
Corinna
