From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@sources.redhat.com
Subject: Re: codepage:oem doesn't affect forkee
Date: Mon, 11 Jun 2001 14:22:00 -0000
Message-id: <20010611172255.A16697@redhat.com>
References: <1805808602.20010612001554@logos-m.ru>
X-SW-Source: 2001-q2/msg00285.html

On Tue, Jun 12, 2001 at 12:15:54AM +0400, egor duda wrote:
>Hi!
>
>  File APIs mode is currently set during environment parsing. when
>process is fork child, current_codepage is taken from parent, but
>actual OS File APIs mode is set by default. this patch fixes this.

Looks good.  Please check in.

cgf
