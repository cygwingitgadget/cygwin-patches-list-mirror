From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: Re: new option for ssh-agent.exe
Date: Fri, 16 Mar 2001 02:19:00 -0000
Message-id: <20010316111802.G19468@cygbert.vinschen.de>
References: <B1F282D5B226D411B8B900E08110486F01E85744@sweetness.idrive.com>
X-SW-Source: 2001-q1/msg00185.html

That's pretty cool.

I'm currently not quite sure how to integrate that, though.
I think the change to ssh-agent isn't too hard so it should
get acceptance from the OpenSSH maintainers. The shell scripts
(which I would prefer without ".sh" suffix) could end up in
the contrib/cygwin subdir. We could release them with the next
OpenSSH version.

However, I have some hints and there's a small error.

- Could you please add appropriate documentation to contrib/cygwin/README
  for the users?

- In the long run I would like to drop the need for instsrv and
  srvany by adding the ability to install itself as a service
  to sshd and ssh-agent, eventually.
  Are you interested in adding this to OpenSSH, perhaps?

On Thu, Mar 15, 2001 at 03:25:02PM -0800, David Peterson wrote:
> --------------- install-ssh-agent-service.sh ------------
> [...]
> SERVICE_BASE_KEY='\machine\SYSTEM\CurrentControlSet\Services\sshagent'

You can make your live easier by using forward slashes.
regtool recognizes forward slashes as key separator if
the key begins with a slash. So the above line could even be:

SERVICE_BASE_KEY=/machine/SYSTEM/CurrentControlSet/Services/sshagent

> ----------------- patch follows -------------------------
> --- ../openssh-2.5.1p2/ssh-agent.c	Sat Feb 10 15:13:41 2001
> +++ ssh-agent.c	Wed Mar 14 23:56:18 2001
> @@ -708,7 +708,7 @@ void
>  usage(void)
>  {
>  	fprintf(stderr, "ssh-agent version %s\n", SSH_VERSION);
> -	fprintf(stderr, "Usage: %s [-c | -s] [-k] [command {args...]]\n",
> +	fprintf(stderr, "Usage: %s [-c | -s] [-k] [ [-n] command
> {args...]]\n",

That's the small error. I think the usage should be:

+	fprintf(stderr, "Usage: %s [-c | -s] [-k] [-n] [command {args...]]\n",

As I said, a really small one.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
