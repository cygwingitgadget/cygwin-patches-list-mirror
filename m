From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: Chris Faylor <cgf@cygnus.com>
Cc: cygwin-patches@sources.redhat.com
Subject: Re: a weird behavior on a command prompt.
Date: Wed, 13 Sep 2000 12:17:00 -0000
Message-id: <s1s3dj4je7c.fsf@jaist.ac.jp>
References: <s1s66o0jnd3.fsf@jaist.ac.jp> <20000913142841.C17331@cygnus.com>
X-SW-Source: 2000-q3/msg00085.html

>>> On Wed, 13 Sep 2000 14:28:41 -0400
>>> Chris Faylor <cgf@cygnus.com> said:

> If I'm reading your patch correctly, the only thing that really needed
> to be done was to
> 
> return p;
> 
> rather than
> 
> return p + 1;
> 
> That is the change that I've made.

I think this can cause the same problem.

For example...

At first:
   "ls" --version
cmd^

After the first memmove():
   ls" --version
cmd^

After the strchr():
   ls" --version
    p^

After the second memmove():
   ls --version
    p^

Return to build_argv():
   ls --version
   cmd^
____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
