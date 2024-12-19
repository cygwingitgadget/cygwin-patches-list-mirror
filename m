Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 36F103858D26; Thu, 19 Dec 2024 17:27:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 36F103858D26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1734629233;
	bh=H1btAWJCk/7ul4SumK3PgPFsBGmqihl9hfDQWVjK+cU=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=t6xPI1fYN8VZM4U7Na068L/zug8mM1spUsbDUkGt2g17WLAeNmIpqOHejfWyv0zgY
	 DH948YwDLRmAQls1njcibzqXyLZZ9UiCGN8O3ecbT02oJc3wumEPusOu5ls98LT5bs
	 89/6Nrb4qp76OXUwDwL5fSh6Y+/PRE9rRGz5yPCE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A5C25A8096C; Thu, 19 Dec 2024 18:27:09 +0100 (CET)
Date: Thu, 19 Dec 2024 18:27:09 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: mmap fixes
Message-ID: <Z2RXbRhvAkGrXS6I@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3c4f732a-52de-42d3-a6d3-7fea99a343ff@cornell.edu>
 <Z2PyzRoS2QeOrNem@calimero.vinschen.de>
 <c2b2c0ee-e848-4b1d-b41d-7568671b77e4@cornell.edu>
 <3c63a503-af61-4a6d-8bae-b9dbab839fce@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3c63a503-af61-4a6d-8bae-b9dbab839fce@cornell.edu>
List-Id: <cygwin-patches.cygwin.com>

On Dec 19 11:19, Ken Brown wrote:
> I've pushed the two modified commits to both main and cygwin-3_5-branch.
> When I pushed to main, I got back the following message from git:
> 
> remote:  Committer: Ken Brown <kbrown@server2.sourceware.org>
> remote: Your name and email address were configured automatically based
> remote: on your username and hostname. Please check that they are accurate.
> remote: You can suppress this message by setting them explicitly.
> 
> I don't recall ever seeing this before, but it's been awhile since I've
> pushed to main.  Is this to be expected or did I do something wrong?  I do
> have my name and email address set in ~/.gitconfig:
> 
> $ cat ~/.gitconfig
> [user]
>         name = Ken Brown
>         email = kbrown@cornell.edu
> [...]
> 
> Ken

I have nothing else in my .gitconfig so I'm not quite sure what
remote is trying to tell you.  Especially since your Committer info
is entirely correct:

$ git log -2 --pretty=fuller
commit 67bef16f7edf8642366ff55399bf9cf007c66d52 (HEAD -> main, origin/master, origin/main, origin/HEAD)
Author:     Ken Brown <kbrown@cornell.edu>
AuthorDate: Wed Dec 18 11:43:09 2024 -0500
Commit:     Ken Brown <kbrown@cornell.edu>
CommitDate: Thu Dec 19 10:40:18 2024 -0500

    Cygwin: mmap_list::try_map: fix a condition in a test of an mmap request
    
    [...]

commit 677e3150907a83f17e50d546f79b7ca863ebd77d
Author:     Ken Brown <kbrown@cornell.edu>
AuthorDate: Wed Dec 18 11:39:31 2024 -0500
Commit:     Ken Brown <kbrown@cornell.edu>
CommitDate: Thu Dec 19 10:25:53 2024 -0500

    Cygwin: mmap: fix protection when unused pages are recycled
    
    [...]


Corinna
