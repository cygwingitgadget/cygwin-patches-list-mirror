From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: generating /etc/passwd and /etc/group for domians with users with cyrillic names
Date: Tue, 10 Apr 2001 10:01:00 -0000
Message-id: <20010410130112.A18200@redhat.com>
References: <130292291322.20010409223921@logos-m.ru>
X-SW-Source: 2001-q2/msg00026.html

On Mon, Apr 09, 2001 at 10:39:21PM +0400, egor duda wrote:
>currently, mkpasswd and mkgroup print garbage if user name or group
>name contains cyrillic symbols.  attached patch fixes that.

I'll take your word for the fact that this fixes the problem.  Go ahead
and check this in, Egor.

cgf
