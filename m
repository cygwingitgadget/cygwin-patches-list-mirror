From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sources.redhat.com
Subject: Re: a problem in invoking scripts.
Date: Wed, 13 Sep 2000 07:35:00 -0000
Message-id: <20000913103441.A17015@cygnus.com>
References: <s1s7l8gjxcs.fsf@jaist.ac.jp>
X-SW-Source: 2000-q3/msg00080.html

On Wed, Sep 13, 2000 at 09:21:55PM +0900, Kazuhiro Fujieda wrote:
>We can't execute scripts with their unqualified names on recent
>snapshots.
>
>~ $ cat > /bin/foo
>#!/bin/sh
>echo hoge
>~ $ foo
>foo: Can't open foo: No such file or directory
>
>The following patch can solve this problem and recalls an old
>warning to spawn.cc.

Thanks for the report.  I've checked in a similar fix to spawn_guts.

cgf
