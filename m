From: Corinna Vinschen <corinna@vinschen.de>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: symlink changes
Date: Sun, 02 Apr 2000 01:18:00 -0000
Message-id: <38E71042.A4DE611C@vinschen.de>
References: <38E4F407.3AB20C82@vinschen.de> <20000331150508.F1576@cygnus.com> <38E50B89.829ABC4B@vinschen.de> <38E5F4AA.C5C4A31B@vinschen.de>
X-SW-Source: 2000-q2/msg00002.html

Corinna Vinschen wrote:
> [...]
> While testing it (this change implies reconfiguring and new compiling
> of fileutils) I found a surprising error in chown.c and chgrp.c:
> 
> While differentiating between changing a link or the referenced file,
> both tools call `lstat' for getting owner/group information. This
> gives wrong results, because both tools check out if at least the
> owner or the group changes. If you then try to change the owner of
> the file to the same owner as of the link, lstat returns the owner
> of the link so that it doesn't call chown(2). Nothing is changed
> and chown/chgrp are sure to have done the right thing. Moreover
> chgrp has no option `--dereference' while the global variable
> `change_symlinks' is set to 1 by default!
> 
> You will find the error in linux, too, because it's really an
> error in the GNU fileutils sources.

I have sent the patch additionally to fileutils-bugs@gnu.ai.mit.edu.
As I have seen, there's no patch to fileutils since 1998. I hope
there's still somebody who feels responsible.

Corinna
