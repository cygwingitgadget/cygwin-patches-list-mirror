Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id D324F3858C42; Wed, 19 Feb 2025 08:49:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D324F3858C42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1739954996;
	bh=OkfITs7uXvTha3vDHE4KUUvaWn4os0fGN7AzSu7tLy4=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=eDfyJ+uQ2y6GCGm8gCavecyaCqWvlAGdyQMOckYX2ufXxQLwk1JKLTTQBJWw2PTTS
	 XPApCD3msYYYlCtT5yKFrbzGjCrG3MrYBY8QAzI9OXoC9JFBQ43IO+1F4af9zA1Ljn
	 acqF7C8noCZq4UpOG+92pxtVmRuzu76amke8eoMQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C7C1AA80B96; Wed, 19 Feb 2025 09:49:53 +0100 (CET)
Date: Wed, 19 Feb 2025 09:49:53 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: include network mounts in cygdrive_getmntent.
Message-ID: <Z7WbMRwybO1yY9Pt@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <8dd3b5f5-004c-53ee-53ea-6428de5dd597@jdrake.com>
 <CAPJSo4XGXfOPBw+1WAYYjhQDU64SXzfVfh7goSDDepUADWZrEg@mail.gmail.com>
 <d45a6382-2df8-be02-4024-432cdb9d5d0b@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d45a6382-2df8-be02-4024-432cdb9d5d0b@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Feb 18 17:54, Jeremy Drake via Cygwin-patches wrote:
> On Wed, 19 Feb 2025, Lionel Cons wrote:
> 
> > Does this patch cover global mounts, i.e. SMB mounted by user
> > LocalSystem on a driver letter are visible to ALL users. Local users
> > logons can override the same drive letter via per-user net use
> >
> > Example:
> > LocalSystem mounts H: to \\homeserver\disk4\users, this is visible to
> > all users in a system
> > User "lionel" mounts H: to \\lionelsserver\data\homedir, this is
> > visible to the current Logon session

GetLogicalDrives and GetLogicalDriveStringsW always show the
mounts valid and visible for the current user.

> I believe so, but it doesn't actually matter.  From the Cygwin
> perspective, it would just show a mount of H: on /cygdrive/h.

...and that.
