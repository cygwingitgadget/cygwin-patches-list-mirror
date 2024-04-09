Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 72E3E3858C39; Tue,  9 Apr 2024 13:08:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 72E3E3858C39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1712668108;
	bh=zUd2q/C8xlnuM3zc9YxExJAB4+ADxhPGbab98G47/AI=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=X7f9fVsCLgPVTwuWFZ7ogj5KlN4a+sKniQdve5Vjrq5ZYWpM0PfAzi7l2Vr5V02gD
	 zaCt0AWiUkqnaMXIZ/EF+jiFZLXp6dRH8NMikZnZNkpu4MvJPH81AQYgAC8o9iJmLg
	 fitNkqcCXwgC0n4E1plCvfrB/WwrGG3r9qTD6YBQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 6E843A80DC7; Tue,  9 Apr 2024 15:08:26 +0200 (CEST)
Date: Tue, 9 Apr 2024 15:08:26 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: /proc/<pid>/{cwd, root} links to <defunct> for cygrunsrv,
 daemons, and shells
Message-ID: <ZhU9yqAGCtJzcNGn@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0df79ac3-02ea-4180-8177-375407dee2a1@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0df79ac3-02ea-4180-8177-375407dee2a1@SystematicSW.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

On Apr  7 13:34, Brian Inglis wrote:
> ISTM anomalous that for cygrunsrv, daemons, cron processes, and shells
> /proc/<pid>/{cwd,root} have bad symlinks to "<defunct>", normally a process
> or exe status:
> 
> /proc/732/exe   -> /usr/bin/cygrunsrv
> /proc/732/root  -> <defunct>
> /proc/732/cwd   -> <defunct>
> |  /proc/733/exe   -> /usr/sbin/cygserver
>  ->/proc/733/root  -> <defunct>
>    /proc/733/cwd   -> <defunct>
> /proc/740/exe   -> /usr/bin/cygrunsrv
> /proc/740/root  -> <defunct>
> /proc/740/cwd   -> <defunct>
> |  /proc/741/exe   -> /usr/sbin/syslog-ng
>  ->/proc/741/root  -> <defunct>
>    /proc/741/cwd   -> <defunct>
> /proc/748/exe   -> /usr/bin/cygrunsrv
> /proc/748/root  -> <defunct>
> /proc/748/cwd   -> <defunct>
> |  /proc/749/exe   -> /usr/sbin/cron
>  ->/proc/749/root  -> <defunct>
>    /proc/749/cwd   -> <defunct>
>    |  /proc/2080/exe  -> /usr/sbin/cron
>     ->/proc/2080/root -> <defunct>
>       /proc/2080/cwd  -> <defunct>
>       |  /proc/2082/exe  -> /usr/bin/bash
>        ->/proc/2082/root -> <defunct>
>          /proc/2082/cwd  -> <defunct>
> 
> Should we consider changing that to root "/", or nothing, null, or something
> meaningful?

That's typically a permission problem.  On Linux you get something like

  ls: cannot read symbolic link '/proc/1/cwd': Permission denied

But on Cygwin the content of those links require to open the processes'
signal pipe and send/receive a message containing the information.  I
didn't look into the code for a while but it seems we don't check why we
couldn't connect to a process to fetch the info.  IIRC the current
fhandler_process framework doesn't have a way to communicate that
info.

If you want to change that, feel free!


Corinna
