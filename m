Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 175983858C50; Fri, 27 Jun 2025 12:26:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 175983858C50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751027175;
	bh=M8DjD39weu6+O8wUaa67S0kiHVUsPkmjl+R9dN7XzqE=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=JOV6Hz5rXHNkg/83F1BZ6YPQndXufxG6OggYZNuQs+s1YxtC796DxlMs1yCr7bS/q
	 MbKpHrJ4DVj7HxJziSUtJP1/5qhJZYxKWIdpi0NsZ8EgwJsTfzqAzIlnLs8kiv1UN9
	 +jw7RyPzIxxYGSoNa04/Ys6BA8Uoz13IETiPR2CE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C2B49A806FF; Fri, 27 Jun 2025 14:26:12 +0200 (CEST)
Date: Fri, 27 Jun 2025 14:26:12 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/5] Cygwin: add fast-path for posix_spawn(p)
Message-ID: <aF6N5Ds7jmadgewV@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <15b3cf9b-62f1-1273-0df8-427db6962e87@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <15b3cf9b-62f1-1273-0df8-427db6962e87@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 26 16:59, Jeremy Drake via Cygwin-patches wrote:
> Currently just file actions open/close/dup2 are supported in the fast
> path.

I'm wondering about that a bit, see below.

Also, ETOOSHORTCOMMITMESSAGE

> +	      case __posix_spawn_file_actions_entry::FAE_DUP2:
> +		if (fae->fae_newfildes < 0 || fae->fae_newfildes > 2)
> +		  goto closes;

Hmmmm.  So we only may dup2/open/close stdin/out/err?  That's not
exactly what POSIX requires.

I understand that this is because CreateProcess or better, Windows, only
defines three handles which can be unambiguously connected to descriptor
numbers, but theoretically, this restriction should only apply to
non-Cygwin executables.

Actually, I think this code path should really only be used with
non-native executables.  With Cygwin executables, all the actions should
be performed in the child process.  This is basically a job for
child_info_spawn::handle_spawn() in dcrt0.cc.

With only one exception: if the executable path is relative, create an
absolute path by emulating (but not actually executing) the chdir/fchdir
calls inside the file_action object.

As for this code, it wouldn't hurt to add more comments explicitely
describing what it's doing and why.  I would add the first comment
already when defining the fds array ;)


Thanks,
Corinna
