From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: mount flag of UNC paths.
Date: Wed, 09 May 2001 12:06:00 -0000
Message-id: <20010509150422.B2089@redhat.com>
References: <s1soft2xty6.fsf@jaist.ac.jp>
X-SW-Source: 2001-q2/msg00213.html

On Thu, May 10, 2001 at 03:23:29AM +0900, Kazuhiro Fujieda wrote:
>I think the mount flag of UNC paths should be picked up from the
>mount table the same as paths including `:' or `\' for consistency.
>The following patch can realize it.
>
>2001-05-10  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>
>
>	* path.cc (mount_info::conv_to_win32_path): Treat UNC paths the same
>	as paths including `:' or `\'.

Applied, thanks.

cgf
