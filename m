From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@sourceware.cygnus.com
Subject: Re: preliminary patch for incorporating internationalizing facilities
Date: Wed, 28 Jun 2000 23:41:00 -0000
Message-id: <s1slmzpng4w.fsf@jaist.ac.jp>
References: <s1sr99ho8cf.fsf@jaist.ac.jp> <395A676F.F78E67A6@cygnus.com> <20000628171354.A31411@cygnus.com> <s1sn1k5o3t6.fsf@jaist.ac.jp> <20000628181636.A24412@cygnus.com>
X-SW-Source: 2000-q2/msg00121.html

>>> On Wed, 28 Jun 2000 18:16:36 -0400
>>> Chris Faylor <cgf@cygnus.com> said:

> Hmm.  Well I don't like the thought of changing something to use
> three arguments and a (possibly) slower method of conversion unless
> it is really necessary.

My change leads no extra cost, rather reduce the cost of
conversion because atoi simply invokes strtol.

Anyway, this change isn't so important to me. You may reject it.
Another change in which strcasecmp is replaced with strcmp in
sort_by_native_name is important.

The current implementation of sort_by_native_name compares posix
paths. Obviously, this is a bug, nevertheless it cause no
serious problem till now. In the first place, lexical order of
the entries isn't important. The entries are sorted so that more
descriptive one is applied in path conversion. What is important
is its length. So my change cause no serious problem.
____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
