Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 494653857C5D; Fri, 27 Jun 2025 08:36:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 494653857C5D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751013399;
	bh=ILz8kWiKwYF0CjRqzWXWKBsevsoAV7ljQKIqETDEo8Q=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=RLqS1/7aHXFNHjdAI6WtCdoGhr98IijUkQqYKsMCVF8GQ8VWASrZpYr22NzfbHKhR
	 E11B3OTuGZ3QKski2r03fkOGFUmeh08Fd7AKNfFf7Hub47zZKkMHPGzHt2M6IV7WSn
	 530L0wkv9YWohQKYaoy4TpkqyxcDDyJbV3BWJGWc=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 1BE80A806FF; Fri, 27 Jun 2025 10:36:37 +0200 (CEST)
Date: Fri, 27 Jun 2025 10:36:37 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/5] posix_spawn fast path
Message-ID: <aF5YFVUMmcIyUo9b@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <5c8c9bad-0109-b328-195e-0a1d1da0c4cf@jdrake.com>
 <6560d72a-c5e2-d084-c815-f44b5afd897f@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6560d72a-c5e2-d084-c815-f44b5afd897f@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 26 17:12, Jeremy Drake via Cygwin-patches wrote:
> On Thu, 26 Jun 2025, Jeremy Drake via Cygwin-patches wrote:
> 
> > I *thought* this was all finally good to go, but while working on
> > posix_spawn tests today I found that it does not properly handle the case
> > where an (f)chdir file action is present and the path/file argument is
> > relative.  In that case, it should be relative to the child's cwd, not the
> > parent's.  As a result, I have left out a patch to actually hook up the
> > (f)chdir actions in the fast path, so it will continue to fall back to
> > fork/exec in that case.
> >
> > I *think* it would need a find_exec overload that uses a specified cwd, as
> > well as perhaps_suffix.  I am not sure if av::setup needs to know about
> > this or not.  It takes the path_conv real_path that came out of
> > perhaps_suffix, and only uses the prog_arg in the case of a script
> > replacing argv[0].  By the time the interpreter is run, the startup code
> > would have already chdir'd, so that'd be fine.  I am not sure about the
> > use of find_exec in av::setup though, I don't think something like
> > #!./prog is legal but if it is that will need to know the child's cwd too.
> 
> Nope, I was wrong.  I tried it on Linux and this works:
> cp /bin/bash .
> echo '#!./bash' > test.sh
> echo 'readlink /proc/$$/exe' >> test.sh
> chmod +x test.sh
> ./test.sh

Yeah, the Linux man page says

  An interpreter script is a text file that has execute permission enabled
  and whose first line is of the form:

  #!interpreter [optional-arg]

  The interpreter must be a valid pathname for an executable file.

And that's all.  POSIX is even less forthcoming:

  Another way that some historical implementations handle shell
  scripts is by recognizing the first two bytes of the file as the
  character string "#!" and using the remainder of the first line of
  the file as the name of the command interpreter to execute.

There's no rule defining a requirement for an absolute path.  Linux,
but not every OS, even allows interpreter to be a script.


Corinna
